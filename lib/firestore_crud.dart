import 'package:cloud_firestore/cloud_firestore.dart';

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
}
