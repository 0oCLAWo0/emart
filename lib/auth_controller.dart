// Import necessary packages and files

// ignore_for_file: non_constant_identifier_names, avoid_print

import 'package:emart/screens/signuppage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:emart/firestore_crud.dart';
import 'package:emart/screens/loginpage.dart';
import 'package:emart/screens/buyer_homepage.dart';
import 'package:emart/screens/seller_homepage.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirestoreCRUD crud = FirestoreCRUD();
  // late String email;

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
      showSnackbar("Registration error", message, titleText,
          isSuccess ? Colors.green : Colors.redAccent);
    }
    if (isSuccess) {
      navigateToLoginPage();
    }
  }

  Future<void> login(
    String email_id, String user_password, String dropdownValue) async {
    String message = "";
    String titleText = "";
    if (await crud.isEmailExists(email_id)) {
      try {
        UserCredential userCredential = await _auth.signInWithEmailAndPassword(
            email: email_id, password: user_password);
        if (userCredential.user!.emailVerified) {
          String accountType = await crud.getAccountType(email_id);
          if (accountType == dropdownValue) {
            if (accountType == "Buyer") {
              navigateToBuyerHomepage();
            } else {
              navigateToSellerHomepage();
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
          print(message);

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
      print(message);
    }
    if (titleText.isNotEmpty) {
      showSnackbar("Login", message, titleText, Colors.redAccent);
    } else {
      print("error");
    }
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
    navigateToLoginPage();
  }

  void showSnackbar(
      String title, String message, String titleText, Color backgroundColor) {
    Get.snackbar(
      title,
      message,
      duration: const Duration(seconds: 2),
      backgroundColor: backgroundColor,
      snackPosition: SnackPosition.BOTTOM,
      titleText: Text(
        titleText,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }

  void showMessengerSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(duration: const Duration(seconds: 3), content: Text(message)));
  }

  void directUser() async {
    User? user = _auth.currentUser;
    if (user != null && user.email != null) {
      String email = user.email!;
      String accountType = await crud.getAccountType(email);
      if (accountType == 'Buyer') {
        Get.offAll(() => const BuyerHomepage(),
        transition: Transition.fade,
        );
      } else {
        Get.offAll(() => const SellerHomepage(),
        transition: Transition.fade,
        );
      }
    } else {
      Get.offAll(() => const LoginPage(),
      transition: Transition.fade,
      );
    }
  }
}
