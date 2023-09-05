// ignore_for_file: prefer_const_constructors, unused_label, duplicate_ignore, non_constant_identifier_names

import 'package:emart/firestore_crud.dart';
import 'package:emart/screens/loginpage.dart';
import 'package:emart/screens/buyer_homepage.dart';
import 'package:emart/screens/seller_homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

  class AuthController extends GetxController {
  static AuthController instance = Get.find();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool isLogin = true;
  late String email;

  void _navigateToLoginPage() {
    Get.offAll(() => LoginPage());
  }

  void _navigateToBuyerHomepage() {
    Get.offAll(() => BuyerHomepage());
  }

  void _navigateToSellerHomepage() {
    Get.offAll(() => SellerHomepage());
  }

  Future<void> register(
      {required user_name,
      required email_id,
      required user_password,
      required dropdownValue}) async {
    String? message;
    String? titleText;
    FirestoreCRUD crud = FirestoreCRUD();
    bool isSuccess = false;
    try {
      if (await crud.isEmailExists(email_id)) {
        message = "Same Email Can't be Used Again";
        titleText = "Account Already Exists for $dropdownValue";
      } else {
        // create in firebase
        await _auth.createUserWithEmailAndPassword(
            email: email_id, password: user_password);
        // create in firestore
        await crud.addData('users', {
          'email': email_id,
          'name': user_name,
          'accountType': dropdownValue
        });

        // get currrent user
        final User? user = _auth.currentUser;
        if (user != null) {
          // ignore: unused_label
          message = "CHECK YOUR MAILBOX";
          // ignore: unused_label
          titleText = "Verify using the link sent to your email";

          await user.updateDisplayName(user_name);
          await user.sendEmailVerification();
          isSuccess = true;
        }
      }
    } catch (e) {
      // ignore: unused_label
      message = "Something Went Wrong";
      // ignore: unused_label
      titleText = "Registration Failed";
    }
    if (message != null && titleText != null) {
      _showSnackbar("Registration error", message, titleText, isSuccess ? Colors.green :Colors.redAccent);
    }
    if (isSuccess) {
      _navigateToLoginPage();
    }
  }

  Future<void> login(
      String email_id, String user_password, String dropdownValue) async {
    String message = "";
    String titleText = "";
    FirestoreCRUD crud = FirestoreCRUD();

    if (await crud.isEmailExists(email_id)) {
      try {
        UserCredential userCredential = await _auth.signInWithEmailAndPassword(
            email: email_id, password: user_password);
        if (userCredential.user!.emailVerified) {
          String accountType = await crud.getAccountType(email_id);
          if (accountType == dropdownValue) {
            if (accountType == "Buyer") {
              _navigateToBuyerHomepage();
            } else {
              _navigateToSellerHomepage();
            }
          }
          // if account type not matching with choosen type
          else {
            message = "Can't Sign In to $dropdownValue's Account";
            titleText = "Different Account Type";
          }
        }
        // email not verified
        else {
          message = "Please Verify your email first";
          titleText = "Account Verification";

          await userCredential.user!.sendEmailVerification();
        }
      } catch (e) {
        message = "Check your password again";
        titleText = "Something Went Wrong";
      }
    }
    // if email id is invalid
    else {
      message = "Invalid Email";
      titleText = "Login Failed";
    }
    if (titleText.isNotEmpty) {
      _showSnackbar("Login", message, titleText, Colors.redAccent);
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      _showSnackbar("Reset mail sent",
          "Password Reset", "A password reset email has been sent to $email.", Colors.green);
    } catch (e) {
      _showSnackbar("Reset Failed", "Check your email id again", "Something Went Wrong", Colors.redAccent);
    }
  }

  void logOut() async {
    await _auth.signOut();
    _navigateToLoginPage();
  }

  void _showSnackbar(
      String title, String message, String titleText, Color backgroundColor) {
    Get.snackbar(
      title,
      message,
      backgroundColor: backgroundColor,
      snackPosition: SnackPosition.BOTTOM,
      titleText: Text(
        titleText,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
