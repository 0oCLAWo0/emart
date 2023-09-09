// ignore_for_file: prefer_const_constructors, unnecessary_import, avoid_print
// ignore: unused_import
import 'package:emart/auth_controller.dart';
import 'package:emart/firebase_options.dart';
import 'package:emart/screens/Seller/registration.dart';
import 'package:emart/screens/Seller/settings.dart';
import 'package:emart/screens/buyer_homepage.dart';
import 'package:emart/screens/mapScreen.dart';
import 'package:emart/screens/multi_splash_screen.dart';
import 'package:emart/screens/onetime_splash_screen.dart';
import 'package:emart/screens/Seller/seller_homepage.dart';
import 'package:emart/screens/loginpage.dart';
import 'package:emart/screens/signuppage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  print("Initializing");
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  //  final location = Location();
  // await location.requestPermission();
  // await location.changeSettings(
  //   accuracy: LocationAccuracy.high,
  //   interval: 10000, // 10 seconds
  //);
  print("inside main");
  Get.put(AuthController());

  runApp(GetMaterialApp(
    initialRoute: '/splash_screen',
    getPages: [
      GetPage(
        name: '/Multi_splash_screen',
        page: () => MultiTimeSplashScreen(),
      ),
      GetPage(
        name: '/splash_screen',
        page: () => OneTimeSplashScreen(),
      ),
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
       GetPage(
        name: '/buisnessRegistration',
        page: () => BuisnessRegistraion(),
      ),
      GetPage(
        name: '/googleMap',
        page: () => GoogleMapWidget(),
      ),
      GetPage(
        name: '/sellerSettings',
        page: () => SellerSettings(),
      ),
    ],
  ));
}
