import 'package:emart/auth_controller.dart';
import 'package:emart/common_widgets.dart';
import 'package:emart/screens/Seller/seller_homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
  ImageProvider userDP = SellerHomepageState.userDP;
  SellerHomepageState seller = SellerHomepageState();
  CommonWidgets common = CommonWidgets();
  FirebaseAuth auth = FirebaseAuth.instance;
  User? user;

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
              await Future.delayed(const Duration(seconds: 2));
              setState(() {
                isButtonPressed = false;
              });
            }
          : onTap,
    );
  }

  Widget showMenuOptions() {
    return Align(
      alignment: Alignment.topRight,
      child: Container(
        width: 220,
        height: 220,
        margin: EdgeInsets.only(top: 70, right : 20),
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
              CreateListTile(
                  disableButton: false,
                  onTap: () {},
                  buttonIcon: Icons.create,
                  title: 'Edit Name'),
              CreateListTile(
                  disableButton: false,
                  onTap: () {},
                  buttonIcon: Icons.create,
                  title: 'Edit Name'),
              CreateListTile(
                  disableButton: false,
                  onTap: () {},
                  buttonIcon: Icons.create,
                  title: 'Edit Name')
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
                    icon: Icon(Icons.more_vert_rounded),
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
                          child: CircleAvatar(
                            backgroundImage: userDP,
                          ),
                        ),
                        // sized
                        const SizedBox(
                          width: 20,
                        ),
                        Column(children: [
                          const SizedBox(
                            height: 9,
                          ),
                          common.getTitleText(
                            '${user!.displayName!}',
                            color: nameColor,
                            fontSize: 25,
                          ),
                        ]),
                        const SizedBox(
                          width: 80,
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
                          user!.email!,
                          color: emailColor,
                          fontSize: 17,
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
                    CreateListTile(
                        buttonIcon: Icons.settings,
                        title: 'Setting',
                        disableButton: false,
                        onTap: () {}),
                    CreateListTile(
                        buttonIcon: Icons.inventory,
                        title: 'Inventory',
                        disableButton: false,
                        message: 'Registration Pending',
                        onTap: () {}),
                    CreateListTile(
                      buttonIcon: Icons.history,
                      title: 'Order History',
                      disableButton: true,
                      message: 'Registration Pending',
                      onTap: () {},
                    ),
                    CreateListTile(
                        buttonIcon: Icons.business_sharp,
                        title: 'Registration',
                        disableButton: false,
                        message:
                            'Verification Status :\n\nCan\'t Register Again',
                        onTap: () {}),
                    CreateListTile(
                        buttonIcon: Icons.logout,
                        title: 'Logout',
                        disableButton: false,
                        onTap: () {}),
                    CreateListTile(
                        buttonIcon: Icons.logout,
                        title: 'Logout',
                        disableButton: false,
                        onTap: () {}),
                    CreateListTile(
                        buttonIcon: Icons.logout,
                        title: 'Logout',
                        disableButton: false,
                        onTap: () {}),
                    CreateListTile(
                        buttonIcon: Icons.logout,
                        title: 'Logout',
                        disableButton: false,
                        onTap: () {}),
                    CreateListTile(
                        buttonIcon: Icons.logout,
                        title: 'Logout',
                        disableButton: false,
                        onTap: () {}),
                    CreateListTile(
                        buttonIcon: Icons.logout,
                        title: 'Logout',
                        disableButton: false,
                        onTap: () {}),
                    CreateListTile(
                        buttonIcon: Icons.logout,
                        title: 'Logout',
                        disableButton: false,
                        onTap: () {}),
                    CreateListTile(
                        buttonIcon: Icons.logout,
                        title: 'Logout',
                        disableButton: false,
                        onTap: () {}),
                    CreateListTile(
                        buttonIcon: Icons.logout,
                        title: 'Logout',
                        disableButton: false,
                        onTap: () {}),
                    CreateListTile(
                        buttonIcon: Icons.logout,
                        title: 'Logout',
                        disableButton: false,
                        onTap: () {}),
                    CreateListTile(
                        buttonIcon: Icons.logout,
                        title: 'Logout',
                        disableButton: false,
                        onTap: () {}),
                    CreateListTile(
                        buttonIcon: Icons.logout,
                        title: 'Logout',
                        disableButton: false,
                        onTap: () {}),
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
}
