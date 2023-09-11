import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirestoreCRUD {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Create (Add) Data
  Future<void> addData(String collectionName, Map<String, dynamic> data) async {
    await _firestore.collection(collectionName).add(data);
  }

  // Read (Retrieve) Data
  Future<List<Map<String, dynamic>>> getData(String collectionName) async {
    QuerySnapshot querySnapshot =
        await _firestore.collection(collectionName).get();
    List<Map<String, dynamic>> dataList = [];
    // ignore: avoid_function_literals_in_foreach_calls
    querySnapshot.docs.forEach((doc) {
      dataList.add(doc.data() as Map<String, dynamic>);
    });
    return dataList;
  }

  // Update Data
  Future<void> updateData(String collectionName, String documentId,
      Map<String, dynamic> data) async {
    await _firestore.collection(collectionName).doc(documentId).update(data);
  }

  // Delete Data
  Future<void> deleteData(String collectionName, String documentId) async {
    await _firestore.collection(collectionName).doc(documentId).delete();
  }

  Future<bool> isEmailExists(String email) async {
    final QuerySnapshot result = await FirebaseFirestore.instance
        .collection(
            'users') // Replace 'users' with the name of your Firestore collection
        .where('email', isEqualTo: email)
        .get();

    // Check if any documents match the query
    return result.docs.isNotEmpty;
  }

  Future<String> getAccountType(String email) async {
    QuerySnapshot result = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: email)
        .limit(1)
        .get();

    return result.docs[0]['accountType'];
  }

  Future<String> getRegistrationStatus(String email) async {
    QuerySnapshot result = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: email)
        .limit(1)
        .get();

    return result.docs[0]['registrationStatus'];
  }

  Future<bool> isUserDpExist(String email) async {
    try {
      QuerySnapshot result = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: email)
          .limit(1)
          .get();

      if (result.docs.isNotEmpty) {
        final userDocument = result.docs[0].data() as Map<String, dynamic>;

        return userDocument['isUserDpExist'];
      }

      return false; // Return null if the user or userDP field doesn't exist
    } catch (e) {
      print("Error fetching userDP: $e");
      return false;
    }
  }

  Future<String?> uploadFileToStorage(
      File file, String storagePath, String email) async {
    try {
      final Reference storageReference =
          FirebaseStorage.instance.ref().child(storagePath);

      final UploadTask uploadTask = storageReference.putFile(file);
      final TaskSnapshot downloadUrl = await uploadTask.whenComplete(() {});
      final String fileUrl = await downloadUrl.ref.getDownloadURL();
      addFieldsForEmail(email, {'isUserDpExist': true});
      return fileUrl; // Returns the URL of the uploaded file
    } catch (e) {
      print("Error uploading file: $e");
      return null;
    }
  }

  Future<String?> getFileDownloadUrl(String storagePath, String email) async {
    if (await isUserDpExist(email) == false) {
      return null;
    }
    final Reference storageReference;
    try {
      print("finding dp");
      storageReference = FirebaseStorage.instance.ref().child(storagePath);
      print("printing");
      print(FirebaseStorage.instance.ref().child(storagePath).toString());
      // Returns the URL of the file
    } catch (e) {
      print("Error retrieving file: $e");
      return null;
    }

    try {
      final String fileUrl = await storageReference.getDownloadURL();
      return fileUrl;
    } catch (e) {
      print('exception caught : ${e.toString()}');
      return null;
    }
  }

  Future<bool> deleteFile(String storagePath, String email) async {
    if (await isUserDpExist(email) == false) {
      return true;
    }
    try {
      // Create a Firebase Storage reference to the file you want to delete.
      Reference storageReference =
          FirebaseStorage.instance.ref().child(storagePath);

      // Delete the file.
      await storageReference.delete();
      await addFieldsForEmail(email, {'isUserDpExist': false});
      print('File deleted successfully');
      return true;
    } catch (e) {
      print('Error deleting file: $e');
      return false;
    }
  }

  Future<bool> addFieldsForEmail(
      String email, Map<String, dynamic> newFields) async {
    try {
      QuerySnapshot users = await _firestore
          .collection('users')
          .where('email', isEqualTo: email)
          .get();

      if (users.docs.isNotEmpty) {
        String userId = users.docs[0].id;
        await _firestore.collection('users').doc(userId).update(newFields);
        return true;
      }
      return false;
    } catch (e) {
      print('Error adding fields: $e');
      return false;
    }
  }
}
