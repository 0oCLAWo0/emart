import 'package:emart/auth_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SellerHomepage extends StatefulWidget {
  const SellerHomepage({super.key});

  @override
  State<SellerHomepage> createState() => _SellerHomepageState();
}

class _SellerHomepageState extends State<SellerHomepage> {
  bool isMenuOpen = false; // Track whether the icon list is open or not.
  FirebaseAuth auth = FirebaseAuth.instance;
  Color orange = const Color.fromARGB(255, 183, 98, 45);
  Color highLighter = const Color.fromARGB(255, 160, 255, 223);
  Color blueGrey = Colors.blueGrey;
  Color iconColor = const Color.fromARGB(255, 60, 58, 58);
  @override
  Widget build(BuildContext context) {
    User? user = auth.currentUser;
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
      width: 200, // Set the width of the Container.
      //height: ,
      child: Drawer(
        backgroundColor: const Color.fromARGB(255, 233, 181, 70),
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          children: [
            Container(
              alignment: Alignment.topLeft,
              margin: const EdgeInsets.only(
                left: 18,
                top: 11,
                bottom: 18,
              ),
              child: GestureDetector(
                onTap: () {
                  print("tapped");
                },
                child: const CircleAvatar(
                  radius: 40,
                ),
              ),
            ),
            CreateListTile(buttonIcon: Icons.settings, title: 'Setting', onTap: (){}),
            CreateListTile(buttonIcon: Icons.inventory, title:'Inventory', onTap: (){}),
            CreateListTile(buttonIcon: Icons.history, title:  'Order History', onTap: (){}),
            CreateListTile(buttonIcon: Icons.logout, title: 'Logout', onTap: (){
              AuthController.instance.logOut();
            }),
          ],
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  ListTile CreateListTile({
    required VoidCallback onTap,
    required IconData buttonIcon,
    required String title,
    double hPad = 16.0,
    double vPad = 0.0,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(
          horizontal: hPad, vertical: vPad), // Adjust padding here.
      leading: Icon(
        buttonIcon,
        size: 26,
        color: iconColor,
      ), // Replace with your first icon.
      title: Text(
        title,
        style: TextStyle(
          color: iconColor,
          fontSize: 18,
        ),
      ),
      onTap: onTap,
    );
  }

  AppBar createAppbar(User? user) {
    return AppBar(
      backgroundColor: orange,
      title: Text('${user!.displayName}'),
      actions: <Widget>[
        Builder(
          builder: (context) {
            // Use Builder to create a new context.
            return IconButton(
              icon: const Icon(
                Icons.dehaze_rounded,
                size: 20,
              ),
              tooltip: 'Show Drawer',
              onPressed: () {
                // Open the Drawer when the icon is clicked.
                Scaffold.of(context).openEndDrawer();
              },
            );
          },
        ),
      ],
    );
  }
}
