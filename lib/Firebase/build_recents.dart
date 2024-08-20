import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import '../widgets/recent_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BuildRecents extends StatelessWidget {
  late List<Map<String, Object>> recents;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('recents').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

        if (snapshot.hasData) {
          // Extract data from the snapshot
          final properties = snapshot.data?.docs;

          // Create a list of property maps
          recents = properties?.map((propertyDoc) {
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

        List<Widget> lists = List.generate(
      recents.length,
      (index) => RecentItem(
        data: recents[index],
      ),
    );
        return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      padding: EdgeInsets.only(bottom: 5, left: 15),
      child: Column(
        children: lists),
    );
      },
    );
  }
}