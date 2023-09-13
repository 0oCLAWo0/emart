// ignore_for_file: avoid_print

import 'package:emart/services/auth_controller.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    print("splash screen");
    Future.delayed(const Duration(milliseconds: 2000), () {
      AuthController().directUser(); // Call your function here
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: const Color.fromARGB(255, 167, 96, 52),
      child: Stack(
        children: [
          Center(
            child: Container(
              width: 200,
              height: 200,
              color: Colors.transparent,
              child: ColorFiltered(
                colorFilter: const ColorFilter.mode(
                  Color.fromARGB(255, 160, 255,
                      223), // Change this color to the desired color
                  BlendMode.srcIn,
                ),
                child: Image.asset('assets/eMartLogo.png'),
              ),
            ),
          ),
          const Center(
            child: Icon(
              Icons.circle_outlined,
              size: 180,
              color: Color.fromARGB(255, 160, 255, 223),
            ),
          ),
        ],
      ),
    );
  }
}
