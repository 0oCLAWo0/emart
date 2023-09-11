import 'package:emart/auth_controller.dart';
import 'package:emart/common_widgets.dart';
import 'package:emart/manage_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditNamePage extends StatelessWidget {
  FirebaseAuth auth = FirebaseAuth.instance;
  final TextEditingController nameController = TextEditingController();
  CommonWidgets common = CommonWidgets();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'EDIT NAME',
        ),
        backgroundColor: const Color.fromARGB(255, 142, 73, 68),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () async {
              if (nameController.text.isNotEmpty) {
                User? user = auth.currentUser;
                Get.back();
                try{
                await user!.updateDisplayName(nameController.text.toString());
                }
                catch(e){
                  AuthController.instance.showMessengerSnackBar(context, 'Check Your Network Connection\nOR Try Again Later');
                }

                user = auth.currentUser;
                print("changing");
                print(
                  UserController.displayName.value,
                );
                UserController.displayName.value = user!.displayName!;
              }
            },
          ),
        ],
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 30, right: 30),
        color: Colors.white,
        child: Center(
          child: common.buildTextField(
              controller: nameController, hintText: 'ENTER NEW NAME'),
        ),
      ),
    );
  }
}
