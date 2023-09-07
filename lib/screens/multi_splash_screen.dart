// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

class MultiTimeSplashScreen extends StatefulWidget {
  const MultiTimeSplashScreen({Key? key}) : super(key: key);

  @override
  MultiTimeSplashScreenState createState() => MultiTimeSplashScreenState();
}

class MultiTimeSplashScreenState extends State<MultiTimeSplashScreen> {
  @override
  void initState() {
    super.initState();

    print("splash screen");
    // Introduce a delay of 2 seconds before calling directUser
    // Future.delayed(const Duration(milliseconds: 20000), () {
    //   AuthController().directUser(); // Call your function here
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: const Color.fromARGB(255, 167, 96, 52),
      child: const Stack(
        children: [
          Center(
            child: Icon(
              Icons.shopping_cart_checkout,
              size: 50,
              color: Color.fromARGB(255, 160, 255, 223),
            ),
          ),
          Center(
            child: Icon(
              Icons.circle_outlined,
              size: 150,
              color: Color.fromARGB(255, 160, 255, 223),
            ),
          ),
        ],
      ),
    );
  }
}
