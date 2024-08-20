import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../pages/home.dart';
import '../theme/color.dart';

class AddProperty extends StatelessWidget {
  String? image;
  String? location;
  String? name;
  String? price;
  bool? is_favorited;

  final _firesStore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Add Property'),
        backgroundColor: AppColor.appBgColor,
      ),
      backgroundColor: AppColor.appBgColor,
      body: Center(
        child: Column(
          children: [
            Text('Add your new Property'),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(20),
              ),
              child: TextField(
                decoration: InputDecoration(hintText: "Enter its image "),
                onChanged: (value) {
                  image = value;
                },
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(20),
              ),
              child: TextField(
                decoration: InputDecoration(hintText: "Enter its name "),
                onChanged: (value) {
                  name = value;
                },
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(20),
              ),
              child: TextField(
                decoration: InputDecoration(hintText: "Enter its  price"),
                onChanged: (value) {
                  price = value;
                },
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(20),
              ),
              child: TextField(
                decoration: InputDecoration(hintText: "Enter its location "),
                onChanged: (value) {
                  location = value;
                },
              ),
            ),
            ElevatedButton(
                onPressed: () async {
                  await _firesStore.collection('recents').add({
                    'image': image,
                    'name':name,
                    'price': price,
                    'location':location,
                    'is_favorited':false
                  });
                },

                child: Text('Add'))
          ],
        ),
      ),
    );
  }
}
