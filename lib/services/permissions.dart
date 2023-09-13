import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationPermissionDialog extends StatelessWidget {
  final VoidCallback onPermissionGranted;

  const LocationPermissionDialog({super.key, required this.onPermissionGranted});

  Future<void> _handleLocationPermission(BuildContext context) async {
    final status = await Permission.location.request();
    if (status.isGranted) {
      // Permission granted, you can now use location services
      onPermissionGranted();
    } else if (status.isDenied || status.isRestricted) {
      // Permission denied or restricted, show a message or dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Location Permission Required"),
            content: const Text(
                "Please enable location permission in settings to use this feature."),
            actions: <Widget>[
              TextButton(
                child: const Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        _handleLocationPermission(context);
      },
      icon: const Icon(
        Icons.location_history,
        size: 30,
      ),
    );
  }
}
