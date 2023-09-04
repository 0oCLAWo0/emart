// ignore_for_file: prefer_const_constructors

import 'package:emart/screens/loginpage.dart';
import 'package:emart/screens/welcomepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class AuthController extends GetxController {
  static AuthController instance = Get.find();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Rx<User?> _user = Rx<User?>(null);
  bool isLogin = true;
  late String email;

  @override
  void onReady() {
    super.onReady();
    _user.bindStream(_auth.userChanges());
    ever(_user, _handleUserState);
  }

  void _handleUserState(User? user) {
    if (user != null && user.email == email && user.emailVerified) {
      _navigateToWelcomePage(user.displayName.toString());
    } 
    else{
      if (user != null &&
          user.email == email &&
          !user.emailVerified &&
          isLogin) {
        _showErrorSnackbar("Login Failed", "Please Verify your email first");
        user.sendEmailVerification();
      }
      
      _navigateToLoginPage();
    }
  }

  void _navigateToLoginPage() {
    Get.offAll(() => LoginPage());
  }

  void _navigateToWelcomePage(String name) {
    Get.offAll(() => WelcomePage(userName: name));
  }

  void register(String name, String email, String password) async {
    try {
      isLogin = false;
      this.email = email;
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      final User? user = _auth.currentUser;
      if (user != null) {
        _showSnackbar(
          "About User",
          "CHECK YOUR MAILBOX",
          "Verify using the link sent to your email",
          Colors.redAccent,
        );
        await user.updateDisplayName(name);
        await user.sendEmailVerification();
      }
    } catch (e) {
      if (e.toString() ==
          '[firebase_auth/email-already-in-use] The email address is already in use by another account.') {
        // Email is already in use
        _showSnackbar(
          "About User",
          "You already have an account",
          "Have you verified your email ?",
          Colors.redAccent,
        );
      } else {
        _showErrorSnackbar("Account Creation Failed", e.toString());
      }
    }
  }

  void login(String email, String password) async {
    try {
      isLogin = true;
      this.email = email;
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      _showErrorSnackbar("Login Failed", "login message");
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      _showSuccessSnackbar(
          "Password Reset", "A password reset email has been sent to $email.");
    } catch (e) {
      _showErrorSnackbar("Password Reset Failed", e.toString());
    }
  }

  void logOut() async => await _auth.signOut();

  void _showErrorSnackbar(String title, String message) {
    _showSnackbar(title, message, "Error", Colors.redAccent);
  }

  void _showSuccessSnackbar(String title, String message) {
    _showSnackbar(title, message, "Success", Colors.green);
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
