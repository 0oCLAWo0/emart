// ignore_for_file: prefer_const_constructors
import 'package:emart/auth_controller.dart';
import 'package:emart/common_widgets.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/register.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 30, top: 100),
            child: Text(
              'Create\nAccount',
              style: TextStyle(
                color: Color.fromARGB(255, 255, 255, 255),
                fontSize: 33,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.43),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 35, right: 35),
                    child: Column(
                      children: [
                        CustomTextField(
                          controller: nameController,
                          hintText: "Name",
                        ),
                        SizedBox(height: 20),
                        CustomTextField(
                          controller: emailController,
                          hintText: "Email",
                        ),
                        SizedBox(height: 20),
                        CustomTextField(
                          controller: passwordController,
                          hintText: "Password",
                          isPassword: true,
                          helperText: "Password must contain special character",
                          helperStyle: TextStyle(
                            color: Color.fromARGB(255, 21, 111, 24),
                          ),
                        ),
                        SizedBox(height: 40,),
                        _buildActionButtons(context),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Column(
      children: [
        _buildActionButton(
          context,
          'Sign up',
          () => _handleSignUp(context),
          Color(0xff4c505b),
        ),
        SizedBox(height: 20),
        _buildTextButton(context, 'Sign in', () => _navigateToLogin(context)),
      ],
    );
  }

  Widget _buildActionButton(BuildContext context, String text,
      VoidCallback onPressed, Color backgroundColor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: TextStyle(
            fontSize: 27,
            fontWeight: FontWeight.w700,
            color: backgroundColor,
          ),
        ),
        CircleAvatar(
          radius: 30,
          backgroundColor: backgroundColor,
          child: IconButton(
            color: Color.fromARGB(255, 254, 254, 254),
            onPressed: onPressed,
            icon: Icon(
              Icons.arrow_forward,
              size: 35,
            ),
          ),
        ),
      ],
    );
  }

  void _handleSignUp(BuildContext context) {
    if (nameController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("All fields are required")));
    } else {
      AuthController.instance.register(
        nameController.text.trim(),
        emailController.text.trim(),
        passwordController.text.trim(),
      );
    }
  }

  void _navigateToLogin(BuildContext context) {
    Navigator.pushNamed(context, '/login');
  }

  Widget _buildTextButton(
      BuildContext context, String text, VoidCallback onPressed) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
            decoration: TextDecoration.underline,
            color: Color.fromARGB(255, 32, 107, 56),
            fontSize: 18),
      ),
    );
  }
}
