import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  static RxString displayName = ''.obs;  
  static Rx<ImageProvider?> userDP = Rx<ImageProvider?>(const AssetImage('assets/userDP2.gif'));
}
