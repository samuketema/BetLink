import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../widgets/property_item.dart';

class BuildPopulars extends StatelessWidget {
  // Declare the populars list as a late variable
  late List<Map<String, Object>> populars;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('populars').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasData) {
          // Extract data from the snapshot
          final properties = snapshot.data?.docs;

          // Create a list of property maps
          populars = properties?.map((propertyDoc) {
            final propertyData = propertyDoc.data() as Map<String, dynamic>;
            return {
              'image': propertyData['image'] as String,
              'name': propertyData['name'] as String,
              'price': propertyData['price'] as String,
              'location': propertyData['location'] as String,
              'is_favorited': propertyData['is_favorited'] as bool,
            };
          }).toList() as List<Map<String, Object>>;
        }

        // Now you have your populars list populated!
        // Use it wherever you need in your app.

        // For now, let's just return an empty container.
        return  CarouselSlider(
      options: CarouselOptions(
        height: 240,
        enlargeCenterPage: true,
        disableCenter: false,
        viewportFraction: .8
      ),
      items: List.generate(
        populars.length,
        (index) => PropertyItem(
          data: populars[index],
        ),
      ),
    );
      },
    );
  }
}
