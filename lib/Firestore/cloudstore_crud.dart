import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class FirestoreCRUD {

  Future<String?> uploadFileToStorage(
      File file, String storagePath, String email) async {
    try {
      final Reference storageReference =
          FirebaseStorage.instance.ref().child(storagePath);

      final UploadTask uploadTask = storageReference.putFile(file);
      final TaskSnapshot downloadUrl = await uploadTask.whenComplete(() {});
      final String fileUrl = await downloadUrl.ref.getDownloadURL();
      return fileUrl; // Returns the URL of the uploaded file
    } catch (e) {
      return null;
    }
  }

  Future<String?> getFileDownloadUrl(String storagePath, String email) async {
    final Reference storageReference;
    try {
      storageReference = FirebaseStorage.instance.ref().child(storagePath);
      // Returns the URL of the file
    } catch (e) {
      return null;
    }

    try {
      final String fileUrl = await storageReference.getDownloadURL();
      return fileUrl;
    } catch (e) {
      return null;
    }
  }

  Future<bool> deleteFile(String storagePath, String email) async {
    try {
      // Create a Firebase Storage reference to the file you want to delete.
      Reference storageReference =
          FirebaseStorage.instance.ref().child(storagePath);

      // Delete the file.
      await storageReference.delete();
      return true;
    } catch (e) {
      return false;
    }
  }
}
