import 'package:betlink/widgets/broker_item.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BuildBrokers extends StatelessWidget {
  // Declare the populars list as a late variable
  late List<Map<String, Object>> brokers;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('brokers').snapshots(),
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
          brokers = properties?.map((propertyDoc) {
            final propertyData = propertyDoc.data() as Map<String, dynamic>;
            return {
              'type': propertyData['type'] as String,
              'name': propertyData['name'] as String,
              'image': propertyData['image'] as String,
              'description': propertyData['description'] as String,
              
              
              'rate':4
            };
          }).toList() as List<Map<String, Object>>;
        }
        // Now you have your populars list populated!
        // Use it wherever you need in your app.

        // For now, let's just return an empty container.
        List<Widget> lists = List.generate(
      brokers.length,
      (index) => BrokerItem(
        data: brokers[index],
      ),
    );
        return  Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Column(children: lists),
    );
      },
    );
  }
}
