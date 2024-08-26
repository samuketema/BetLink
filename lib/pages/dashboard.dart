import 'package:betlink/pages/add_property.dart';
import 'package:betlink/pages/register_as_agent.dart';
import 'package:flutter/material.dart';
import '../theme/color.dart';
import '../widgets/custom_image.dart';
import '../components/roundedButton.dart';

class DashboardScreen extends StatelessWidget {
  static const String id = 'dashboard_screen';
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.green,
        title: Text('Dashboard',style: TextStyle(color:Colors.white),),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomButton(
                  assetData: 'assets/images/house.png',
                  onTap: () {
                    Navigator.pushNamed(context, AddProperty.id);
                  },
                  message: 'Publish new Properties',
                ),
                CustomButton(
                    message: 'Favorite Properties',
                    onTap: () {},
                    assetData: 'assets/images/home2.jpg')
              ],
            ),
            SizedBox(
              height: 20,
            ),
            RoundedButton(
              onPressed: () {},
              color: Colors.green,
              title: 'Published Properties',
            ),
            RoundedButton(
              onPressed: () {},
              color: Colors.blueGrey,
              title: 'Featured Properties',
            ),
            RoundedButton(
              onPressed: () {},
              color: Colors.blue,
              title: 'Pending Properties',
            ),
            RoundedButton(
              onPressed: () {
                Navigator.pushNamed(context, RegisterAsAgent.id);
              },
              color: Colors.orangeAccent,
              title: 'Register as an agent',
            ),
            
          ],
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  VoidCallback onTap;
  String message;
  String assetData;
  CustomButton(
      {super.key,
      required this.message,
      required this.onTap,
      required this.assetData});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 185,
        height: 130,
        margin: EdgeInsets.only(right: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: AppColor.shadowColor.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 1,
              offset: Offset(0, 1), // changes position of shadow
            ),
          ],
        ),
        child: Stack(
          children: [
            CustomImage(
              assetData,
              radius: 20,
              width: double.infinity,
              height: double.infinity,
            ),
            Container(
              height: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black.withOpacity(.8),
                    Colors.white.withOpacity(.01),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 12,
              left: 10,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    message,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
