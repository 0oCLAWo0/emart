import 'package:flutter/material.dart';

class CommonWidgets {
  List<String> itemList = <String>['Seller', 'Buyer'];
  String dropdownValue = "Seller";

  Widget buildTextField({
    required TextEditingController controller,
    required String hintText,}) {
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
          value: dropdownValue,
          elevation: 16,
          underline: Container(
            color: Colors.transparent,
          ),
          onChanged: (newValue) {
            dropdownValue = newValue!;
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
}
