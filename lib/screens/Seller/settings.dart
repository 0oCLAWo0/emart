import 'package:flutter/material.dart';

class SellerSettings extends StatefulWidget {
  const SellerSettings({super.key});

  @override
  State<SellerSettings> createState() => _SellerSettingsState();
}

class _SellerSettingsState extends State<SellerSettings> {
  Color blueAndGrey = Colors.blueGrey;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: blueAndGrey,
    );
  }
}