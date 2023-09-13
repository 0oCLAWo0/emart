import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart/Firestore/user_data_firestore.dart';
import 'package:emart/services/auth_controller.dart';
import 'package:emart/common_widgets.dart';
import 'package:emart/manage_state.dart';
import 'package:emart/screens/map_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class BuisnessRegistraion extends StatefulWidget {
  const BuisnessRegistraion({super.key});

  @override
  State<BuisnessRegistraion> createState() => BuisnessRegistraionState();
}

class BuisnessRegistraionState extends State<BuisnessRegistraion> {
  Color pageColor = const Color.fromARGB(255, 233, 181, 70);
  CommonWidgets common = CommonWidgets();
  final TextEditingController buisnessTypeController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  final TextEditingController homeDeliveryController = TextEditingController();
  static LatLng? selectedLocation;
  bool buttonTapped = false;
  bool isTnCAccepted = false;
  bool isRegistered = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pageColor,
      appBar: AppBar(
        backgroundColor: pageColor,
        title: const Text(
          '!! REGISTER YOUR BUISNESS !!',
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.only(left: 20, right: 20),
            child: Column(children: [
              const SizedBox(
                height: 10,
              ),
              buildRegistrationContainer('Buisness Type'),
              common.buildTextField(
                  controller: buisnessTypeController,
                  hintText: 'General Store, Medical Store'),
              buildRegistrationContainer('Owner Name'),
              common.buildTextField(
                  controller: nameController, hintText: 'Sumit Aggarwal'),
              buildRegistrationContainer('Address'),
              common.buildTextField(
                  controller: addressController,
                  hintText: 'shop no, street, landmark, state, pincode'),
              buildRegistrationContainer('Contact Number'),
              common.buildTextField(
                  controller: contactController, hintText: '+91 93064 XXXXX'),
              buildRegistrationContainer('Home Delivery'),
              common.buildTextField(
                  controller: homeDeliveryController,
                  hintText: 'Yes : Area(radius 1 km)/ No'),
              const SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Icon(
                        Icons.location_history,
                        size: 30,
                      ),
                      TextButton(
                        onPressed: () {
                          Get.to(() => const GoogleMapWidget());
                        },
                        child: const Text(
                          'Drop Location',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 58, 15, 143)),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                          onPressed: () {
                            setState(() {
                              isTnCAccepted = !isTnCAccepted;
                            });
                          },
                          icon: isTnCAccepted
                              ? const Icon(
                                  Icons.check_box,
                                )
                              : const Icon(
                                  Icons.check_box_outline_blank,
                                  size: 20,
                                )),
                      TextButton(
                          onPressed: () {},
                          style: ButtonStyle(
                            padding:
                                MaterialStateProperty.all<EdgeInsetsGeometry>(
                              const EdgeInsets.symmetric(
                                  vertical: 8,
                                  horizontal: 0), // Adjust padding here
                            ),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.transparent),
                          ),
                          child: const Text(
                            'Accept T&C',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 58, 15, 143)),
                          )),
                    ],
                  ),
                ],
              ),
              GestureDetector(
                onTap: () async {
                  if (buttonTapped == true) {
                    return;
                  }
                  setState(() {
                    buttonTapped = true;
                  });
                  // ignore: unused_local_variable
                  String message = '';
                  if (buisnessTypeController.text.isEmpty ||
                      nameController.text.isEmpty ||
                      addressController.text.isEmpty ||
                      contactController.text.isEmpty ||
                      homeDeliveryController.text.isEmpty) {
                    common.showMessengerSnackBar(
                        context, 'ALL FIELDS ARE REQUIRED');
                  } else if (selectedLocation == null) {
                    AuthController.instance.showSnackbar(
                        'Registration',
                        'Pick Your Shop\'s Location',
                        'Location Not Picked',
                        Colors.redAccent);
                  } else if (isTnCAccepted == false) {
                    AuthController.instance.showSnackbar(
                        'Registration',
                        'Agree to our T&C to Continue',
                        '** Read T&C **',
                        Colors.redAccent);
                  } else {
                    // Get the current date and time
                    Timestamp currentTime = Timestamp.now();
                    UserDataFirestore udCRUD = UserDataFirestore();
                    User? user = FirebaseAuth.instance.currentUser;
                    Map<String, dynamic> map = {
                      'buisnessType': buisnessTypeController.text,
                      'ownerName': nameController.text,
                      'address': addressController.text,
                      'contact': contactController.text,
                      'homeDelivery': homeDeliveryController.text,
                      'longitude': selectedLocation!.longitude,
                      'latitude': selectedLocation!.latitude,
                      'isRegistered': true,
                      'registrationTimeStamp': currentTime,
                      'registrationStatus': 'pending',
                    };

                    isRegistered =
                        await udCRUD.addFieldsForEmail(user!.email!, map);
                    if (isRegistered == true) {

                      UserController.registrationStatus.value = 'pending';
                      setState(() {
                        buttonTapped = false;
                      });
                      Get.back();
                      await Future.delayed(const Duration(seconds: 2));
                      AuthController.instance.showSnackbar(
                        'Registration Success',
                        'We will verify your request with in 5-7 working days',
                        'REGISTRATION SUCCESSFUL',
                        Colors.greenAccent,
                      );
                    }
                    else {
                    AuthController.instance.showSnackbar(
                      'Registration failed',
                      'Please Try Again Later',
                      'Something Went Wrong',
                      Colors.redAccent,
                    );
                    await Future.delayed(const Duration(seconds: 2));
                    setState(() {
                      buttonTapped = false;
                    });
                  }
                  } // Wait for 2 seconds
                 
                },
                child: Container(
                  margin: const EdgeInsets.only(top: 15),
                  width: 100,
                  height: 45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: buttonTapped ? Colors.black : Colors.white,
                  ),
                  child: Center(
                      child: Text(
                    'REGISTER',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: buttonTapped ? Colors.white : Colors.black,
                    ),
                  )),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }

  Container buildRegistrationContainer(String label) {
    return Container(
      margin: const EdgeInsets.only(top: 15, left: 10, bottom: 7),
      child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            label,
            style: const TextStyle(fontSize: 14),
          )),
    );
  }
}
