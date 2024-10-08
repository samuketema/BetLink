import 'package:betlink/pages/home.dart';
import 'package:betlink/pages/root.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart'; // Import the image_picker package
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io'; // Import Firebase Storage

class AddProperty extends StatefulWidget {
  static const String id = 'add_property';

  @override
  State<AddProperty> createState() => _AddPropertyState();
}

class _AddPropertyState extends State<AddProperty> {
  String? imageUrl;

  final _firestore = FirebaseFirestore.instance;

  final TextEditingController nameController = TextEditingController();

  final TextEditingController priceController = TextEditingController();

  final TextEditingController locationController = TextEditingController();

  bool _uploadingImage = false;
  // Add this variable
  void _addProperty() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final imageFile = File(pickedFile.path);
      final storageRef = FirebaseStorage.instance.ref().child(
          'property_images/${DateTime.now().millisecondsSinceEpoch}.jpg');
      final uploadTask = storageRef.putFile(imageFile);

      setState(() {
        _uploadingImage = true; // Show progress indicator
      });

      imageUrl = await uploadTask
          .then((taskSnapshot) => taskSnapshot.ref.getDownloadURL());

      setState(() {
        _uploadingImage = false; // Hide progress indicator
      });
    }
  }

  void _add() async {
    await _firestore.collection('recents').add({
      'image': imageUrl ?? "https://www.crestolympiads.com/assets/images/science/house.png",
      'name': nameController.text ?? 'Double Villa',
      'price': priceController.text ?? "2000000",
      'location': locationController.text ?? 'Addis Ababa',
      'is_favorited': false,
    });

    Navigator.of(context).pop();
    Navigator.of(context).pushNamed(RootApp.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Add Property',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.green,
        ),
        backgroundColor: Colors.grey.shade200,
        body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        const Text(
                          'Add Your New Property',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        // Replace the TextField with an image picker button
                        if (_uploadingImage)
                          const CircularProgressIndicator() // Show progress indicator
                        else
                          IconButton(
                            icon: const Icon(Icons.photo_camera),
                            onPressed: _addProperty,
                          ),
                        _buildTextField(nameController, 'Property Name'),
                        _buildTextField(priceController, 'Price (\$)'),
                        _buildTextField(locationController, 'Location'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: _add,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text(
                      'Add Property',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  )
                ])));
  }

  Widget _buildTextField(TextEditingController controller, String hintText) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
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
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ))));
  }
}
