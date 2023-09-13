import 'dart:io';

import 'package:emart/services/auth_controller.dart';
import 'package:emart/common_widgets.dart';
import 'package:emart/Firestore/cloudstore_crud.dart';
import 'package:emart/manage_state.dart';
import 'package:emart/screens/Seller/seller_homepage.dart';
import 'package:emart/screens/Seller/settings/edit_name_page.dart';
import 'package:emart/screens/Seller/settings/help_and_support.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SellerSettings extends StatefulWidget {
  const SellerSettings({super.key});

  @override
  State<SellerSettings> createState() => SellerSettingsState();
}

class SellerSettingsState extends State<SellerSettings> {
  Color blueAndGrey = Colors.blueGrey;
  Color iconColor = const Color.fromARGB(255, 60, 58, 58);
  Color emailColor = Colors.white;
  Color nameColor = const Color.fromARGB(255, 94, 158, 185);
  Color emailIconColor = const Color.fromARGB(255, 169, 167, 167);
  bool isButtonPressed = false;
  SellerHomepageState seller = SellerHomepageState();
  CommonWidgets common = CommonWidgets();
  FirebaseAuth auth = FirebaseAuth.instance;
  FirestoreCRUD crud = FirestoreCRUD();
  User? user;

  Widget createListTile({
    required bool disableButton,
    required VoidCallback onTap,
    required IconData buttonIcon,
    required String title,
    double hPad = 6.0,
    double vPad = 0.0,
    String message = '',
    bool isLongPress = false,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(
          horizontal: hPad, vertical: vPad), // Adjust padding here.
      leading: Icon(
        buttonIcon,
        size: 25,
        color: !disableButton ? iconColor : Colors.white,
      ), // Replace with your first icon.
      title: Text(
        title,
        style: TextStyle(
          color: !disableButton ? iconColor : Colors.white,
          fontSize: 17,
        ),
      ),
      onLongPress: isLongPress ? onTap : () {},
      onTap: disableButton
          ? () async {
              if (isButtonPressed) {
                return;
              }
              setState(() {
                isButtonPressed = true;
              });
              common.showMessengerSnackBar(context, message);
              await Future.delayed(const Duration(seconds: 2));
              setState(() {
                isButtonPressed = false;
              });
            }
          : isLongPress
              ? () {}
              : onTap,
    );
  }

  Widget showMenuOptions() {
    return Align(
      alignment: Alignment.topRight,
      child: Container(
        width: 220,
        height: 205,
        margin: const EdgeInsets.only(top: 70, right: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            // Add this to specify a border
            color: Colors.blueGrey, // Set the border color
            width: 17.0, // Set the border width
          ),
        ),
        child: Drawer(
          backgroundColor: Colors.white,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              createListTile(
                  disableButton: false,
                  onTap: () {
                    Get.back();
                    Get.to(() => EditNamePage());
                  },
                  buttonIcon: Icons.create,
                  title: 'Edit Name'),
              createListTile(
                disableButton: false,
                onTap: () {
                  User? user = auth.currentUser;
                  String storagePath = 'user_profile/${user!.uid}/userDP';
                  crud.deleteFile(storagePath, user.email!);
                  UserController.userDP.value =
                      const AssetImage('assets/userDP2.gif');
                  Get.back();
                },
                isLongPress: true,
                buttonIcon: Icons.delete,
                title: 'Remove DP',
              ),
              createListTile(
                  disableButton: false,
                  onTap: () {
                    AuthController.instance.logOut();
                  },
                  buttonIcon: Icons.logout,
                  title: 'Logout')
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    user = auth.currentUser;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 102, 137, 155),
      endDrawer: showMenuOptions(),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            title: const Text('Settings'),
            actions: [
              IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
              Builder(
                builder: (BuildContext context) {
                  return IconButton(
                    onPressed: () {
                      Scaffold.of(context).openEndDrawer();
                    },
                    icon: const Icon(Icons.more_vert_rounded),
                  );
                },
              )
            ],
            backgroundColor: blueAndGrey,
            expandedHeight: 200.0, // Initial height of the app bar
            floating: false, // Set to true if you want the app bar to float
            pinned: true, // Set to true to keep the app bar pinned
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.pin,
              background: Container(
                color: const Color.fromARGB(255, 68, 90, 101),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 90,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          width: 10,
                          height: 90,
                        ),
                        SizedBox(
                          height: 90,
                          width: 90,
                          child: GestureDetector(
                            onLongPress: () async {
                              String dpPath =
                                  await common.getImageFromUser() ?? '';
                              if (dpPath.isNotEmpty) {
                                User? user = auth.currentUser;
                                String storagePath =
                                    'user_profile/${user!.uid}/userDP';
                                crud.uploadFileToStorage(
                                    File(dpPath), storagePath, user.email!);
                                UserController.userDP.value =
                                    FileImage(File(dpPath));
                              }
                            },
                            child: Obx(() {
                              return CircleAvatar(
                                  backgroundImage: UserController.userDP.value);
                            }),
                          ),
                        ),
                        // sized
                        const SizedBox(
                          width: 10,
                        ),
                        Column(children: [
                          const SizedBox(
                            height: 30,
                          ),
                          SizedBox(
                            width: 175,
                            child: Center(
                              child: Obx(() {
                                return common.getTitleText(
                                  UserController.displayName.value,
                                  color: nameColor,
                                  fontSize: 16,
                                );
                              }),
                            ),
                          ),
                        ]),
                        const SizedBox(
                          width: 10,
                        ),
                        const SizedBox(
                          height: 90,
                          width: 90,
                          child: CircleAvatar(
                            backgroundImage: AssetImage('assets/settings.gif'),
                            backgroundColor: Colors.transparent,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        const SizedBox(
                          width: 10,
                        ),
                        Icon(
                          Icons.email,
                          color: emailIconColor,
                        ),
                        const SizedBox(
                          width: 6,
                        ),
                        common.getTitleText(
                          user!.email ?? "",
                          color: emailColor,
                          fontSize: 15,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Column(
                  children: [
                    getContainerColoumn(
                        title: 'Update Buisness Info', vpad: 30),
                    createListTile(
                        buttonIcon: Icons.contact_phone,
                        title: 'Change Phone Number',
                        disableButton: true,
                        message: 'Registration Pending',
                        onTap: () {}),
                    createListTile(
                        buttonIcon: Icons.location_city,
                        title: 'Edit Address',
                        disableButton: true,
                        message: 'Registration Pending',
                        onTap: () {}),
                    createListTile(
                        buttonIcon: Icons.type_specimen,
                        title: 'Change Buisness Domain',
                        disableButton: true,
                        message: 'Registration Pending',
                        onTap: () {}),
                    createListTile(
                        buttonIcon: Icons.smart_button,
                        title: 'Change Delivery Type',
                        disableButton: true,
                        message: 'Registration Pending',
                        onTap: () {}),
                    getContainerColoumn(title: 'UPDATE LOCATION', vpad: 25),
                    createListTile(
                        buttonIcon: Icons.location_pin,
                        title: 'Update Location',
                        disableButton: true,
                        message: 'Registration Pending',
                        onTap: () {}),
                    getContainerColoumn(title: 'ACCOUNT SETTINGS', vpad: 25),
                    createListTile(
                        buttonIcon: Icons.lock,
                        title: 'Change Password',
                        disableButton: false,
                        onTap: () {
                          AuthController.instance.resetPassword(user!.email!);
                        }),
                    createListTile(
                        buttonIcon: Icons.attach_email_rounded,
                        title: 'Change Email',
                        disableButton: true,
                        onTap: () {}),
                    createListTile(
                        buttonIcon: Icons.delete_forever,
                        title: 'Delete Account',
                        disableButton: true,
                        onTap: () {}),
                    getContainerColoumn(title: 'SALES', vpad: 25),
                    createListTile(
                        buttonIcon: Icons.auto_graph,
                        title: 'Sales',
                        disableButton: true,
                        onTap: () {}),
                    getContainerColoumn(title: 'HELP & SUPPORT', vpad: 25),
                    createListTile(
                        buttonIcon: Icons.help_center,
                        title: 'Help and Support',
                        disableButton: false,
                        onTap: () {
                          Get.to(() => const HelpAndSupport());
                        }),
                  ],
                );
              },
              childCount: 1, // Replace with the number of list items
            ),
          ),
        ],
      ),
    );
  }

  Column getContainerColoumn({required String title, required double vpad}) {
    return Column(
      children: [
        Container(
          height: vpad,
          margin: const EdgeInsets.only(left: 10, bottom: 5),
          child: Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                title,
                style: const TextStyle(
                  color: Color.fromARGB(255, 212, 206, 207),
                  fontSize: 15,
                ),
              )),
        ),
        Container(
          color: emailIconColor,
          height: 4,
        ),
      ],
    );
  }
}
