// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  static String id = "settings";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text('Settings'),
        ),
        body: ListView(
          padding: EdgeInsets.all(16.0),
          children: [
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/images/samuel.jpg'),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'User1',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            ButtonList(
              leadingIcon: Icons.person,
              title: 'Profile',
              iconColor: Colors.orange,
            ),
            ButtonList(
              leadingIcon: Icons.notifications,
              title: 'Notification',
              iconColor: Colors.blue,
            ),
            ButtonList(
              leadingIcon: Icons.lock,
              title: 'Change Password',
              iconColor: Colors.green,
            ),
            ButtonList(
              leadingIcon: Icons.brightness_4,
              title: 'Appearance',
              iconColor: Colors.grey,
            ),
            ButtonList(
              leadingIcon: Icons.favorite,
              title: 'Favorites',
              iconColor: Colors.red,
            ),
            ButtonList(
              leadingIcon: Icons.info,
              title: 'Privacy Policy',
              iconColor: Colors.blueGrey,
            ),
            ButtonList(
              leadingIcon: Icons.logout,
              title: 'Log Out',
              iconColor: Colors.redAccent,
            ),
          ],
        ),
      ),
    );
  }
}

class ButtonList extends StatelessWidget {
  final IconData leadingIcon;
  final String title;
  final Color iconColor;

  ButtonList({
    required this.leadingIcon,
    required this.title,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(leadingIcon, color: iconColor),
      title: Text(title),
      trailing: Icon(Icons.arrow_forward_ios),
      onTap: () {
        // Add navigation or other actions here
      },
    );
  }
}
