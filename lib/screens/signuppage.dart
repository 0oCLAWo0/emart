// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:emart/common_widgets.dart'; // Import the common widget
import 'package:emart/auth_controller.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  SignUpPageState createState() => SignUpPageState();
}

class SignUpPageState extends State<SignUpPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String dropdownValue = 'Seller'; // Initialize with the default value
  CommonWidgets widgetBuilder = CommonWidgets();
  bool obscureText = true;

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
                  top: MediaQuery.of(context).size.height * 0.38),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 35, right: 35),
                    child: Column(
                      children: [
                        widgetBuilder.buildDropDownButton(
                            onChanged: (newValue) {
                          setState(() {
                            dropdownValue = newValue!;
                          });
                        }),
                        SizedBox(height: 20,),
                        widgetBuilder.buildTextField(
                          controller: nameController,
                          hintText: "Name",
                        ),
                        SizedBox(height: 20),
                        widgetBuilder.buildTextField(
                          controller: emailController,
                          hintText: "Email",
                        ),
                        SizedBox(height: 20),
                        TextField(
                          controller: passwordController,
                          obscureText:
                              obscureText, // Use the obscureText variable
                          decoration: InputDecoration(
                            hintText: "Password",
                            helperText:
                                "Password must contain atleat 6 characters",
                            helperStyle: TextStyle(
                              color: Color.fromARGB(255, 7, 60, 9),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                             fillColor: Colors.grey.shade200,
                            filled: true,
                            suffixIcon: IconButton(
                              icon: Icon(
                                obscureText
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                              onPressed: () {
                                setState(() {
                                  obscureText = !obscureText;
                                });
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
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
        user_name: nameController.text.trim(),
        email_id: emailController.text.trim(),
        user_password: passwordController.text.trim(),
        dropdownValue: dropdownValue,
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

// ignore: unused_element
