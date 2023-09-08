import 'package:emart/common_widgets.dart';
import 'package:flutter/material.dart';

class BuisnessRegistraion extends StatefulWidget {
  const BuisnessRegistraion({super.key});

  @override
  State<BuisnessRegistraion> createState() => _BuisnessRegistraionState();
}

class _BuisnessRegistraionState extends State<BuisnessRegistraion> {
  Color pageColor = const Color.fromARGB(255, 233, 181, 70);
  CommonWidgets common = CommonWidgets();
  bool isTnCAccepted = false;
  final TextEditingController buisnessTypeController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  final TextEditingController homeDeliveryController = TextEditingController();

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
                      IconButton(
                          onPressed: () {
                            setState(() {
                              //
                            });
                          },
                          icon: const Icon(
                            Icons.location_history,
                            size: 30,
                          )),
                      const Text(
                        'Drop Location',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 58, 15, 143)),
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
                          onPressed: () {
                            print('terms and condition');
                          },
                          style: ButtonStyle(
                            padding:
                                MaterialStateProperty.all<EdgeInsetsGeometry>(
                              const EdgeInsets.symmetric(
                                  vertical: 8,
                                  horizontal: 0), // Adjust padding here
                            ),
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.transparent),
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
                child: Container(
                  margin: const EdgeInsets.only(top: 15),
                  width: 100,
                  height: 45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: const Center(
                      child: Text(
                    'REGISTER',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
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
