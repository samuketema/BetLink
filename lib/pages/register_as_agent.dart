import 'package:betlink/pages/root.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart'; // Import the image_picker package
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io'; // Import Firebase Storage

class RegisterAsAgent extends StatefulWidget {
  static const String id = 'register_as_agent';

  @override
  State<RegisterAsAgent> createState() => _RegisterAsAgentState();
}

class _RegisterAsAgentState extends State<RegisterAsAgent> {
  String? imageUrl;

  final _firestore = FirebaseFirestore.instance;

  final TextEditingController nameController = TextEditingController();

  final TextEditingController typeController = TextEditingController();

  final TextEditingController descriptionController = TextEditingController();

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
    await _firestore.collection('brokers').add({
      'image': imageUrl,
      'name': nameController.text,
      'type': typeController.text,
      'description': descriptionController.text,
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
            'Register as Agent',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.green,
        ),
        backgroundColor: Colors.grey.shade200,
        body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
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
                            'Register as an Agent',
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          // Replace the TextField with an image picker button
                          if (_uploadingImage)
                            const CircularProgressIndicator() // Show progress indicator
                          else
                            GestureDetector(
                              onTap: _addProperty,
                              child: CircleAvatar(
                                backgroundImage: imageUrl != null
                                    ? NetworkImage(
                                        imageUrl!) // Display selected image
                                    : const AssetImage(
                                        'assets/images/green-person.png'), // Default icon
                                radius: 50,
                              ),
                            ),
                            const Text(' Please Press the above icon to insert your profile picture'),
                            const SizedBox(
                              height: 20,
                            ),
                          _buildTextField(nameController, 'Full Name', 1),
                          _buildTextField(typeController, 'Type', 1),
                          _buildTextField(
                              descriptionController, 'Description', 3),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      onPressed:_add,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Text(
                        'Register',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    )
                  ]),
            )));
  }

  Widget _buildTextField(
      TextEditingController controller, String hintText, int maxLine) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        child: Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(20),
            ),
            child: TextField(
                maxLines: maxLine,
                controller: controller,
                decoration: InputDecoration(
                  hintText: hintText,
                  border: InputBorder.none,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ))));
  }
}
