import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart/screens/signuppage.dart';
import 'package:emart/Firestore/user_data_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:emart/Firestore/cloudstore_crud.dart';
import 'package:emart/screens/loginpage.dart';
import 'package:emart/screens/buyer_homepage.dart';
import 'package:emart/screens/Seller/seller_homepage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirestoreCRUD crud = FirestoreCRUD();
  UserDataFirestore udCRUD = UserDataFirestore();

  void navigateToLoginPage() {
    Get.offAll(() => const LoginPage());
  }

  void navigateToSignupPage() {
    Get.offAll(() => const SignUpPage());
  }

  void navigateToBuyerHomepage() {
    Get.offAll(() => const BuyerHomepage());
  }

  void navigateToSellerHomepage() {
    Get.offAll(() => const SellerHomepage());
  }

  Future<void> register(
      {required userName,
      required emailID,
      required userPassword,
      required accountType}) async {
    String? message;
    String? titleText;
    bool isSuccess = false;
    try {
      await _auth.createUserWithEmailAndPassword(
          email: emailID, password: userPassword);
      Timestamp currentTime = Timestamp.now();
      accountType == 'Buyer' ?
          await udCRUD.addBuyerData({
            'email': emailID,
          }) :
      await udCRUD.addSellerData({
        'email': emailID,
        'registrationStatus': 'onRequest',
        'signInTimeStamp': currentTime,
      });
      // get currrent user
      final User? user = _auth.currentUser;
      if (user != null) {
        // ignore: unused_label
        message = "CHECK YOUR MAILBOX";
        // ignore: unused_label
        titleText = "Verify using the link sent to your email";

        await user.updateDisplayName(userName);
        await user.sendEmailVerification();
        isSuccess = true;
      }
    } catch (e) {
      // ignore: unused_label
      message = "Something Went Wrong";
      // ignore: unused_label
      titleText = "Registration Failed";
    }
    if (message != null && titleText != null) {
      showSnackbar("Registration error", message, titleText,
          isSuccess ? Colors.green : Colors.redAccent);
    }
    if (isSuccess) {
      navigateToLoginPage();
    }
  }

  Future<void> login(
      String emailId, String userPassword, String dropdownValue) async {
    String message = "";
    String titleText = "";

    if (await udCRUD.isAccountExist(dropdownValue, emailId)) {
      try {
        UserCredential userCredential = await _auth.signInWithEmailAndPassword(
            email: emailId, password: userPassword);

        if (userCredential.user!.emailVerified) {
          String myString = dropdownValue;
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('accountType', myString);

          if (dropdownValue == "Buyer") {
            navigateToBuyerHomepage();
          } else {
            navigateToSellerHomepage();
          }
        } else {
          message = "Please Verify your email first";
          titleText = "Account Verification";

          await userCredential.user!.sendEmailVerification();
        }
      } catch (e) {
        message = "Check your password again";
        titleText = "Something Went Wrong";
      }
    } else {
      message = "Invalid Email or Account Type";
      titleText = "Login Failed";
    }
    if (titleText.isNotEmpty) {
      showSnackbar("Login", message, titleText, Colors.redAccent);
    } else {}
  }

  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      showSnackbar("Reset mail sent", "Password Reset",
          "A password reset email has been sent to $email.", Colors.green);
    } catch (e) {
      showSnackbar("Reset Failed", "Check your email id again",
          "Something Went Wrong", Colors.redAccent);
    }
  }

  void logOut() async {
    await _auth.signOut();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('accountType'); // Remove the 'accountType' key
    navigateToLoginPage();
  }

  void showSnackbar(
      String title, String message, String titleText, Color backgroundColor,
      {Color textColor = Colors.white}) {
    Get.snackbar(
      title,
      message,
      duration: const Duration(seconds: 2),
      backgroundColor: backgroundColor,
      snackPosition: SnackPosition.BOTTOM,
      titleText: Text(
        titleText,
        style: TextStyle(
          color: textColor,
        ),
      ),
    );
  }

  void directUser() async {
    User? user = _auth.currentUser;
    if (user == null) {
    } else {}

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accountType = prefs.getString('accountType');
    if (user != null &&
        user.email != null &&
        user.emailVerified &&
        accountType != null) {
      if (accountType == 'Buyer') {
        Get.offAll(
          () => const BuyerHomepage(),
          transition: Transition.fade,
        );
      } else {
        Get.offAll(
          () => const SellerHomepage(),
          transition: Transition.fade,
        );
      }
    } else {
      Get.offAll(
        () => const LoginPage(),
        transition: Transition.fade,
      );
    }
  }
}
