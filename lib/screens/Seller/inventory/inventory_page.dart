import 'package:emart/screens/Seller/inventory/add_item_inventory.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InventoryPage extends StatefulWidget {
  const InventoryPage({super.key});

  @override
  State<InventoryPage> createState() => _InventoryPageState();
}

class _InventoryPageState extends State<InventoryPage> {
  Color pageColor = const Color.fromARGB(255, 183, 98, 45);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pageColor,
      appBar: AppBar(
        title: const Text(
          'Inventory',
        ),
        actions: [
          IconButton(
            onPressed: () {
              Get.to(() => const AddItemToInventory());
            },
            icon: const Icon(Icons.add_box),
          ),
          const SizedBox(
            width: 10,
          ),
        ],
        backgroundColor: pageColor,
      ),
      body: const Column(children: []),
    );
  }
}
