// ignore_for_file: prefer_const_constructors

import 'package:emart/services/auth_controller.dart';
import 'package:emart/common_widgets.dart';
import 'package:emart/screens/signuppage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  CommonWidgets common = CommonWidgets();
  String? dropdownValue = "Seller";
  bool obscureText = true;
  CommonWidgets widgetBuilder = CommonWidgets();
  bool isButtonPressed = false;
 

  @override
  void initState() {
    super.initState();
  }

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
                            },
                            itemList: <String>['Seller', 'Buyer'],
                            dropDownValue: dropdownValue!,
                          ),
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
                              GestureDetector(
                                onTap: isButtonPressed
                                    ? null
                                    : () => _handleButtonTap(() async {
                                          _handleLogin(context);
                                        }),
                                child: CircleAvatar(
                                  radius: 30,
                                  backgroundColor:
                                      Color.fromARGB(255, 248, 160, 87),
                                  child: isButtonPressed
                                      ? CircularProgressIndicator(
                                          color: Color.fromARGB(
                                              255, 225, 235, 235),
                                        )
                                      : Icon(
                                          Icons.arrow_forward,
                                          color: Colors.white,
                                          size: 35,
                                        ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _buildTextButton(
                                context,
                                'Sign up',
                                () => Get.to(() => SignUpPage()),
                              ), // Replace NextPage with your destination page
                              _buildTextButton(context, 'Forgot Password', () {
                                if (isButtonPressed) {
                                  return;
                                }
                                _handleButtonTap(() async {
                                  _resetPassword(context);
                                });
                              }),
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
      common.showMessengerSnackBar(context, "All fields are Required");
    } else {
      AuthController.instance.login(emailController.text.trim(),
          passwordController.text.trim(), dropdownValue!);
    }
  }

  void _resetPassword(BuildContext context) {
    if (emailController.text.isEmpty) {
      common.showMessengerSnackBar(context, "Please enter your email first.");
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

  Future<void> _handleButtonTap(Function name) async {
    setState(() {
      isButtonPressed = true;
    });
    await Future.delayed(Duration(seconds: 4)); // Wait for 2 seconds
    setState(() {
      isButtonPressed = false;
    });
    await name();
  }
}
