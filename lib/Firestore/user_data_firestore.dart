import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart/manage_state.dart';

class UserDataFirestore {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Create (Add) Data
  Future<void> addSellerData(Map<String, dynamic> data) async {
    await _firestore.collection('Seller').add(data);
  }

  Future<void> addBuyerData(Map<String, dynamic> data) async {
    await _firestore.collection('Buyer').add(data);
  }

  // update or add new fields using email
  Future<bool> addFieldsForEmail(
      String email, Map<String, dynamic> newFields) async {
    try {
      QuerySnapshot user = await _firestore
          .collection(UserController.accountType.value)
          .where('email', isEqualTo: email)
          .get();

      if (user.docs.isNotEmpty) {
        String userId = user.docs[0].id;
        await _firestore
            .collection(UserController.accountType.value)
            .doc(userId)
            .update(newFields);
        return true;
      }
      return false;
    } catch (e) {
      print("exception caught: ${e}");
      return false;
    }
  }

  Future<String> getRegistrationStatus(String email) async {
    QuerySnapshot result = await FirebaseFirestore.instance
        .collection('Seller')
        .where('email', isEqualTo: email)
        .limit(1)
        .get();

    return result.docs[0]['registrationStatus'];
  }

  Future<bool> isAccountExist(String accountType, String email) async {
    final QuerySnapshot result = await FirebaseFirestore.instance
        .collection(
            accountType) // Replace 'users' with the name of your Firestore collection
        .where('email', isEqualTo: email)
        .get();

    // Check if any documents match the query
    return result.docs.isNotEmpty;
  }

  Future<QueryDocumentSnapshot<Object?>?> getUserData(String email) async {
    try {
      QuerySnapshot result = await FirebaseFirestore.instance
          .collection('USERS')
          .where('email', isEqualTo: email)
          .limit(1)
          .get();

      if (result.docs.isNotEmpty) {
        return result.docs.first;
      } else {
        return null; // No matching document found
      }
    } catch (e) {
      return null; // Handle the error and return null
    }
  }
}
