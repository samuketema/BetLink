import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../theme/color.dart'; // Replace with your actual theme import

class AddProperty extends StatelessWidget {
  static const String id = 'add_property';

  final _firestore = FirebaseFirestore.instance;
  final TextEditingController imageController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController locationController = TextEditingController();

  void _addProperty() async {
    await _firestore.collection('recents').add({
      'image': imageController.text,
      'name': nameController.text,
      'price': priceController.text,
      'location': locationController.text,
      'is_favorited': false,
    });
  }


  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      centerTitle: true,
      title: Text('Add Property'),
      backgroundColor: Colors.green,
    ),
    backgroundColor: AppColor.appBgColor,
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            margin: EdgeInsets.only(top: 20),
            decoration: BoxDecoration(
              border: Border.all(),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(children: [
              Text(
            'Add Your New Property',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          _buildTextField(imageController, 'Image URL'),
          _buildTextField(nameController, 'Property Name'),
          _buildTextField(priceController, 'Price (\$)'),
          _buildTextField(locationController, 'Location'),
            ],),
          ),
          SizedBox(
            height: 30,
          ),
          
          ElevatedButton(
            onPressed: _addProperty,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: Text(
              'Add Property',
              style: TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    ),
  );
}


  Widget _buildTextField(TextEditingController controller, String hintText) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 10),
      child: Container(
        
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(20),
        ),
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hintText,
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
        ),
      ),
    );
  }
}
