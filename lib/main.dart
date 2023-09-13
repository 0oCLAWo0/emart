
import 'package:emart/services/auth_controller.dart';
import 'package:emart/services/firebase_options.dart';
import 'package:emart/manage_state.dart';
import 'package:emart/screens/Seller/registration.dart';
import 'package:emart/screens/Seller/settings/edit_name_page.dart';
import 'package:emart/screens/Seller/settings/settings.dart';
import 'package:emart/screens/buyer_homepage.dart';
import 'package:emart/screens/map_screen.dart';
import 'package:emart/screens/splash_screen.dart';
import 'package:emart/screens/Seller/seller_homepage.dart';
import 'package:emart/screens/loginpage.dart';
import 'package:emart/screens/signuppage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform, 
  );
 
  Get.put(AuthController());
  Get.put(UserController());

  SharedPreferences prefs = await SharedPreferences.getInstance();
  UserController.accountType.value = prefs.getString('accountType')!; 


  runApp(GetMaterialApp(
    initialRoute: '/splash_screen',
    getPages: [
      GetPage(
        name: '/splash_screen',
        page: () => const SplashScreen(),
      ),
      GetPage(
        name: '/login',
        page: () => const LoginPage(),
      ),
      GetPage(
        name: '/signup',
        page: () => const SignUpPage(),
      ),
      GetPage(
        name: '/buyerHomePage',
        page: () => const BuyerHomepage(),
      ),
      GetPage(
        name: '/sellerHomePage',
        page: () => const SellerHomepage(),
      ),
       GetPage(
        name: '/buisnessRegistration',
        page: () => const BuisnessRegistraion(),
      ),
      GetPage(
        name: '/googleMap',
        page: () => const GoogleMapWidget(),
      ),
      GetPage(
        name: '/sellerSettings',
        page: () => const SellerSettings(),
      ),
      GetPage(name: '/editNmaePage',
       page: () => EditNamePage(),
      ),
    ],
  ),
  );
}
