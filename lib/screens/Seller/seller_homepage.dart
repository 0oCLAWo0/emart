import 'dart:async';
import 'dart:ffi';

import 'package:emart/auth_controller.dart';
import 'package:emart/common_widgets.dart';
import 'package:emart/firestore_crud.dart';
import 'package:emart/manage_state.dart';
import 'package:emart/screens/Seller/registration.dart';
import 'package:emart/screens/Seller/settings/settings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SellerHomepage extends StatefulWidget {
  const SellerHomepage({Key? key}) : super(key: key);

  @override
  State<SellerHomepage> createState() => SellerHomepageState();
}

class SellerHomepageState extends State<SellerHomepage> {
  bool isMenuOpen = false; // Track whether the icon list is open or not.
  bool isUserRegistered = false;
  bool isButtonPressed = false;
  String registrationStatus = 'onRequest';
  FirebaseAuth auth = FirebaseAuth.instance;
  User? user;
  FirestoreCRUD crud = FirestoreCRUD();
  CommonWidgets common = CommonWidgets();

  Color orange = const Color.fromARGB(255, 183, 98, 45);
  Color highLighter = const Color.fromARGB(255, 160, 255, 223);
  Color blueGrey = Colors.blueGrey;
  Color iconColor = const Color.fromARGB(255, 60, 58, 58);
  Color drawerColor = const Color.fromARGB(255, 233, 181, 70);
  @override
  void initState() {
    super.initState();
    user = auth.currentUser;
    UserController.displayName.value = user!.displayName!;
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      UserController.userDP.value = (await common.fetchUserDP());
      registrationStatus = (await crud.getRegistrationStatus(user!.email!));
      setState(() {
        isUserRegistered = registrationStatus == 'verified' ? true : false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
// Declare _timer as Timer? (nullable)
    return Scaffold(
      appBar: createAppbar(user),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '!!! WELCOME TO SELLER\'s PAGE !!!',
              style: TextStyle(
                color: Colors.purple,
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
      // Drawer that opens from the right when the icon is clicked.
      endDrawer: _buildIconList(),
    );
  }

  Widget _buildIconList() {
    return SizedBox(
      width: 220,
      child: Drawer(
        backgroundColor: drawerColor,
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          children: [
            Container(
              color: orange,
              padding: const EdgeInsets.only(top: 0),
              child: Column(
                children: [
                  Container(
                    height: 80,
                    alignment: Alignment.topLeft,
                    margin: const EdgeInsets.only(
                      left: 23,
                      top: 27,
                      bottom: 10,
                    ),
                    child: Obx(() {
                      return CircleAvatar(
                        radius: 40,
                        backgroundImage: UserController.userDP.value,
                      );
                    }),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    margin:
                        const EdgeInsets.only(left: 32, bottom: 13, right: 10),
                    child: Obx(() {
                      print("changing");
                      print(
                        UserController.displayName.value,
                      );
                      return common.getTitleText(
                          UserController.displayName.value,
                          color: highLighter);
                    }),
                  ),
                ],
              ),
            ),
            CreateListTile(
                buttonIcon: Icons.settings,
                title: 'Setting',
                disableButton: false,
                onTap: () {
                  Get.to(() => const SellerSettings());
                }),
            CreateListTile(
                buttonIcon: Icons.inventory,
                title: 'Inventory',
                disableButton: !isUserRegistered,
                message: 'Registration Pending',
                onTap: () {}),
            CreateListTile(
              buttonIcon: Icons.history,
              title: 'Order History',
              disableButton: !isUserRegistered,
              message: 'Registration Pending',
              onTap: () {},
            ),
            CreateListTile(
                buttonIcon: Icons.business_sharp,
                title: 'Registration',
                disableButton: registrationStatus != 'onRequest' ? true : false,
                message:
                    'Verification Status : $registrationStatus\n\nCan\'t Register Again',
                onTap: () {
                  Get.to(() => const BuisnessRegistraion());
                }),
            CreateListTile(
                buttonIcon: Icons.logout,
                title: 'Logout',
                disableButton: false,
                onTap: () {
                  AuthController.instance.logOut();
                }),
          ],
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget CreateListTile({
    required bool disableButton,
    required VoidCallback onTap,
    required IconData buttonIcon,
    required String title,
    double hPad = 16.0,
    double vPad = 0.0,
    String message = '',
  }) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(
          horizontal: hPad, vertical: vPad), // Adjust padding here.
      leading: Icon(
        buttonIcon,
        size: 26,
        color: !disableButton ? iconColor : Colors.white,
      ), // Replace with your first icon.
      title: Text(
        title,
        style: TextStyle(
          color: !disableButton ? iconColor : Colors.white,
          fontSize: 18,
        ),
      ),
      onTap: disableButton
          ? () async {
              if (isButtonPressed) {
                return;
              }
              setState(() {
                isButtonPressed = true;
              });
              AuthController.instance.showMessengerSnackBar(context, message);
              await Future.delayed(Duration(seconds: 2));
              setState(() {
                isButtonPressed = false;
              });
            }
          : onTap,
    );
  }

  AppBar createAppbar(User? user) {
    return AppBar(
      backgroundColor: orange,
      title: common.getTitleText('E MART'),
      actions: <Widget>[
        Builder(
          builder: (context) {
            // Use Builder to create a new context.
            return Row(
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.search,
                    size: 20,
                  ),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(
                    Icons.dehaze_rounded,
                    size: 20,
                  ),
                  tooltip: 'Show Drawer',
                  onPressed: () {
                    // Open the Drawer when the icon is clicked.
                    Scaffold.of(context).openEndDrawer();
                  },
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
