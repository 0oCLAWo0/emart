import 'package:emart/common_widgets.dart';
import 'package:emart/screens/Seller/registration.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapWidget extends StatefulWidget {
  const GoogleMapWidget({super.key});

  @override
  State<GoogleMapWidget> createState() => GoogleMapWidgetState();
}

class GoogleMapWidgetState extends State<GoogleMapWidget> {
  // ignore: unused_field
  GoogleMapController? _controller;
  BuisnessRegistraionState locate = BuisnessRegistraionState();
  CommonWidgets common = CommonWidgets();
  bool isLoading = true;
  LatLng currentLocation = const LatLng(25, 77);
  static LatLng? selectedLocation;

  @override
  void initState() {
    super.initState();
    {
      // Call getCurrentLocation to update currentLocation

      WidgetsBinding.instance.addPostFrameCallback((_) async {
        LatLng? temp = await common.getCurrentLocation();
        setState(() {
          isLoading = false;
        });
        if (temp == null) {
          Get.back();
        }
        currentLocation = temp ?? currentLocation;
        print("done");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 132, 180, 101),
        title: const Text('Pick Your Location'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator(
            backgroundColor: const Color.fromARGB(255, 132, 180, 101),
            ))
          : GoogleMap(
              initialCameraPosition: CameraPosition(
                target: currentLocation, // Initial map center (New Delhi)
                zoom: 12.0, // Initial zoom level
              ),
              onMapCreated: (controller) {
                setState(() {
                  _controller = controller;
                });
              },
              onTap: (position) {
                print("tapped");
                setState(() {
                  selectedLocation = position;
                  BuisnessRegistraionState.selectedLocation = position;
                  print(selectedLocation);
                });
              },

              markers: Set<Marker>.of(
                selectedLocation != null
                    ? [
                        Marker(
                          markerId: const MarkerId('selected-location'),
                          position: selectedLocation!,
                        ),
                      ]
                    : [],
              ),

              // Add more markers as needed
            ),
    );
  }
}
