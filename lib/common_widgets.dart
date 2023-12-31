import 'package:emart/Firestore/cloudstore_crud.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:marquee/marquee.dart';

class CommonWidgets {
  late String? imagePath; // Pass the selected image path to this widget
  FirebaseAuth auth = FirebaseAuth.instance;
  FirestoreCRUD crud = FirestoreCRUD();

  Widget buildTextField({
    required TextEditingController controller,
    required String hintText,
  }) {
    return TextField(
      controller: controller,
      obscureText: false,
      decoration: InputDecoration(
        hintText: hintText,
        fillColor: Colors.grey.shade200,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  Widget buildDropDownButton({
    required void Function(String?) onChanged,
    required List<String> itemList,
    required String dropDownValue,
  }) {
    return Container(
      height: 30,
      width: 80,
      decoration: BoxDecoration(
        color: Colors.grey.shade400,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Center(
        child: DropdownButton<String>(
          value: dropDownValue,
          elevation: 16,
          underline: Container(
            color: Colors.transparent,
          ),
          onChanged: (newValue) {
            onChanged(newValue);
          },
          items: itemList.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ),
    );
  }

  Future<String?> getImageFromUser() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      // User selected an image
      return pickedFile.path;
      // You can now do something with the selected image path, e.g., display it in an Image widget.
    } else {
      return null;
    }
  }

  Widget getTitleText(String message,
      {Color color = Colors.black, double fontSize = 20}) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final text = message;
        final textPainter = TextPainter(
          text: TextSpan(
              text: text, style: TextStyle(fontSize: fontSize, color: color)),
          textDirection: TextDirection.ltr,
        )..layout(maxWidth: double.infinity);

        if (textPainter.width > constraints.maxWidth) {
          return SizedBox(
            height: kToolbarHeight,
            child: Marquee(
              text: text,
              scrollAxis: Axis.horizontal,
              crossAxisAlignment: CrossAxisAlignment.center,
              blankSpace: 15.0,
              velocity: 50.0,
              startPadding: 10.0,
            ),
          );
        } else {
          return Text(text, style: TextStyle(fontSize: fontSize, color: color));
        }
      },
    );
  }

  // fetch dp
  Future<ImageProvider> fetchUserDP() async {
    User? user = auth.currentUser;
    user = auth.currentUser;
    ImageProvider userDP;
    String? storagePath = 'user_profile/${user!.uid}/userDP';
    try {
      String? userDPUrl =
          await crud.getFileDownloadUrl(storagePath, user.email!);
      if (userDPUrl != null) {
        userDP = NetworkImage(userDPUrl);
      } else {
        userDP = const AssetImage('assets/userDP2.gif');
      }
    } catch (e) {
      userDP = const AssetImage('assets/userDP2.gif');
    }
    return userDP;
  }

  // fetch user's current location
  Future<LatLng?> getCurrentLocation() async {
    Location location = Location();
    LocationData currentLocationData;

    try {
      currentLocationData = await location.getLocation();
      return LatLng(
          currentLocationData.latitude!, currentLocationData.longitude!);
    } catch (e) {
      return null;
    }
  }


  void showMessengerSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(duration: const Duration(seconds: 3), content: Text(message)));
  }
}
