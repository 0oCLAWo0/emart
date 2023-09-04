// ignore_for_file: prefer_const_constructors

import 'package:emart/auth_controller.dart';
import 'package:emart/common_widgets.dart';
import 'package:flutter/material.dart';


class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/login.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 25, top: 130),
            child: Text(
              'Welcome !!',
              style: TextStyle(
                  color: Color.fromARGB(255, 208, 132, 102), fontSize: 33),
            ),
          ),
          SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.29),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 35, right: 35),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 95,
                          backgroundImage: AssetImage('assets/eMartLogo.png'),
                          backgroundColor: Colors.transparent,
                        ),
                        SizedBox(height: 10),
                        CustomTextField(
                          controller: emailController,
                          hintText: "Email",
                        ),
                        SizedBox(height: 20),
                        CustomTextField(
                          controller: passwordController,
                          hintText: "Password",
                          isPassword: true,
                        ),
                        SizedBox(height: 50),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Sign in',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 248, 160, 87),
                                  fontSize: 27, fontWeight: FontWeight.w500),
                            ),
                            CircleAvatar(
                              radius: 30,
                              backgroundColor:
                                  Color.fromARGB(255, 248, 160, 87),
                              child: IconButton(
                                color: Color.fromARGB(255, 255, 255, 255),
                                onPressed: () => _handleLogin(context),
                                icon: Icon(
                                  Icons.arrow_forward,
                                  size: 35,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 25),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildTextButton(context, 'Sign up',
                                () => _navigateToSignup(context)),
                            _buildTextButton(context, 'Forgot Password',
                                () => _resetPassword(context)),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _handleLogin(BuildContext context) {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("All fields are required")));
    } else {
      AuthController.instance
          .login(emailController.text.trim(), passwordController.text.trim());
    }
  }

  void _navigateToSignup(BuildContext context) {
    Navigator.pushNamed(context, '/signup');
  }

  void _resetPassword(BuildContext context) {
    if (emailController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Please enter your email first.")));
    } else {
      AuthController.instance.resetPassword(emailController.text.trim());
    }
  }

  Widget _buildTextButton(
      BuildContext context, String text, VoidCallback onPressed) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
            decoration: TextDecoration.underline,
            color: Color.fromARGB(255, 1, 207, 176),
            fontSize: 18),
      ),
    );
  }
}
