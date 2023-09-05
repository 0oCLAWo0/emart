// ignore_for_file: prefer_const_constructors

import 'package:emart/auth_controller.dart';
import 'package:emart/common_widgets.dart';
import 'package:flutter/material.dart';

List<String> list = <String>['Seller', 'Buyer'];

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String? dropdownValue = "Seller";
  bool obscureText = true;
  CommonWidgets widgetBuilder = CommonWidgets();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/login.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.19),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 35),
                      child: Text(
                        'Welcome !!',
                        style: TextStyle(
                            color: Color.fromARGB(255, 208, 132, 102),
                            fontSize: 33),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 30, right: 30, top: 10),
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 100,
                            backgroundColor: Colors.transparent,
                            child:
                                Image(image: AssetImage('assets/eMartLogo.png')
                                    // fit: BoxFit.cover,
                                    ),
                          ),
                          widgetBuilder.buildDropDownButton(
                              onChanged: (newValue) {
                              setState(() {
                              dropdownValue = newValue;
                            });
                          }),
                          SizedBox(
                            height: 25,
                          ),
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
                          SizedBox(height: 40),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Sign in',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 248, 160, 87),
                                    fontSize: 27,
                                    fontWeight: FontWeight.w500),
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
      ),
    );
  }

  void _handleLogin(BuildContext context) {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("All fields are required")));
    } else {
      AuthController.instance
          .login(emailController.text.trim(), passwordController.text.trim(), dropdownValue!);
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

// ignore: unused_element
 

