// ignore_for_file: prefer_const_constructors

import 'package:emart/auth_controller.dart';
import 'package:flutter/material.dart';

class BuyerHomepage extends StatelessWidget {

  const BuyerHomepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('userName'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.dehaze_rounded,
              size: 20,
            ),
            tooltip: 'Show Snackbar',
            onPressed: () {
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '!!! WELCOME userName !!!',
              style: const TextStyle(
                color: Colors.purple,
                fontSize: 30,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            TextButton(
              onPressed: () {
                AuthController.instance.logOut();
              },
              style: const ButtonStyle(),
              child: const Center(
                child: Text(
                  'Logout',
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: Color.fromARGB(255, 32, 107, 56),
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
