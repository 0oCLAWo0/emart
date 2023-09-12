import 'package:emart/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

final _formKey = GlobalKey<FormState>();

class AddItemToInventory extends StatefulWidget {
  const AddItemToInventory({super.key});

  @override
  State<AddItemToInventory> createState() => _AddItemToInventoryState();
}

class _AddItemToInventoryState extends State<AddItemToInventory> {
  Color pageColor = const Color.fromARGB(255, 233, 181, 70);
  TextEditingController nameController = TextEditingController();
  TextEditingController stockController = TextEditingController();
  TextEditingController discriptionController = TextEditingController();
  TextEditingController mrpController = TextEditingController();
  TextEditingController spController = TextEditingController();
  TextEditingController companyController = TextEditingController();
  TextEditingController flavorController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController expireController = TextEditingController();

  String qtyORweight = "Units";
  CommonWidgets common = CommonWidgets();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pageColor,
      appBar: AppBar(
        title: const Text('Add Item'),
        backgroundColor: pageColor,
      ),
      //expire date //company // flavor // image
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  createFormField(
                      controller: nameController,
                      label: 'Item Name*',
                      wid: 0.4,
                      leftMargin: 20.0,
                      topMargin: 30.0),
                  createFormField(
                      controller: stockController,
                      label: 'Stock*',
                      wid: 0.2,
                      leftMargin: 30.0,
                      topMargin: 30.0,
                      isOnlyNum: true),
                  const SizedBox(
                    width: 10,
                  ),
                  common.buildDropDownButton(
                    onChanged: (newValue) {
                      setState(() {
                        qtyORweight = newValue!;
                      });
                    },
                    itemList: <String>['Units', 'KG'],
                    dropDownValue: qtyORweight,
                  ),
                ],
              ),
              const SizedBox(height: 20,),
              Row(
                children: [
                  createFormField(
                      controller: discriptionController,
                      label: 'Item Discription*',
                      wid: 0.6,
                      leftMargin: 20.0,
                      topMargin: 30.0),
                  createFormField(
                    controller: mrpController,
                    label: 'MRP*',
                    wid: 0.2,
                    leftMargin: 20.0,
                    topMargin: 30.0,
                    isDecimal: true,
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  createFormField(
                    controller: weightController,
                    label: 'Weight*',
                    wid: 0.22,
                    leftMargin: 20.0,
                    topMargin: 30.0,
                    isDecimal: true,
                  ),
                  createFormField(
                    controller: spController,
                    label: 'Selling Price*',
                    wid: 0.32,
                    leftMargin: 20.0,
                    topMargin: 30.0,
                    isDecimal: true,
                  ),
                  createFormField(
                    controller: flavorController,
                    label: 'Flavour',
                    wid: 0.22,
                    leftMargin: 20.0,
                    topMargin: 30.0,
                    canEmpty: true,
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  createFormField(
                      controller: companyController,
                      label: 'Company Name',
                      wid: 0.4,
                      leftMargin: 20.0,
                      topMargin: 30.0,
                      canEmpty: true,
                      ),
                  createFormField(
                    controller: expireController,
                    label: 'Expire Date',
                    wid: 0.4,
                    leftMargin: 20.0,
                    topMargin: 30.0,
                    canEmpty: true,
                  ),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              TextButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      print("validate");
                    }
                  },
                  child: Container(
                  decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color.fromARGB(255, 13, 6, 89), // Border color
                          width: 2.0, // Border width
                        ),
                      ),
                   child: const Padding( 
                     padding: EdgeInsets.all(8.0),
                     child: Text(
                      "ADD ITEM",
                      style: TextStyle(
                        color: Color.fromARGB(255, 13, 6, 89),
                        fontWeight: FontWeight.w900,
                        fontSize: 20,
                      ),
                                     ),
                   )
                  ))
            ],
          ),
        ),
      ),
    );
  }

  Widget createFormField({
    required TextEditingController controller,
    required String label,
    required double wid,
    required leftMargin,
    required topMargin,
    bool canEmpty = false,
    bool isOnlyNum = false,
    bool isDecimal = false,
  }) {
    return Container(
      width: MediaQuery.of(context).size.width * wid,
      margin: EdgeInsets.only(left: leftMargin, top: topMargin),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          fillColor: Colors.grey.shade300,
          filled: true,
        ),
        validator: (value) {
          if (value == null) {
            return "Required";
          }

          if (!canEmpty && value.isEmpty) {
            return "Required";
          }

          if (isDecimal && !value.isNum) {
            // Try to parse the input as a double
            return "invalid num";
          }
          if (isOnlyNum && !value.isNumericOnly) {
            // Try to parse the input as a double
            return "only digit";
          }

          return null;
        },
      ),
    );
  }
}
