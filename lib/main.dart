// ignore_for_file: prefer_const_constructors, unnecessary_import
import 'package:emart/auth_controller.dart';
import 'package:emart/firebase_options.dart';
import 'package:emart/screens/buyer_homepage.dart';
import 'package:emart/screens/seller_homepage.dart';
import 'package:emart/screens/loginpage.dart';
import 'package:emart/screens/signuppage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Register AuthController
  Get.put(AuthController());

  runApp(GetMaterialApp( 
    initialRoute: '/login',
    getPages: [
      GetPage(
        name: '/login',
        page: () => LoginPage(),
      ),
      GetPage(
        name: '/signup',
        page: () => SignUpPage(),
      ),
      GetPage(
        name: '/buyerHomePage',
        page: () => BuyerHomepage(),
      ),
      GetPage(
        name: '/sellerHomePage',
        page: () => SellerHomepage(),
      ),
    ],
    home: LoginPage(),
  ));
}
