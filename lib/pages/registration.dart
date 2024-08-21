import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../constants.dart';
import '../Components/roundedbutton.dart';
import 'package:betlink/pages/root.dart';

class RegistrationScreen extends StatefulWidget {
  static String id = 'registrationScreen';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  String? email;
  String? password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Hero(
              tag: 'logo',
              child: Container(
                height: 100.0,
                child: Image.asset('assets/images/home.jpg'),
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              'Register to BetLink',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            TextField(
              onChanged: (value) {
                email = value;
              },
              decoration: kTextFieldDecoration.copyWith(
                hintText: 'Enter your email',
                fillColor: Colors.black,
              ),
            ),
            SizedBox(height: 8.0),
            TextField(
              onChanged: (value) {
                password = value;
              },
              decoration: kTextFieldDecoration.copyWith(
                hintText: 'Enter your password',
              ),
            ),
            SizedBox(height: 24.0),
            RoundedButton(
              color: Colors.lightGreen,
              onPressed: () async {
                try {
                  final newUser = await _auth.createUserWithEmailAndPassword(
                    email: email as String,
                    password: password as String,
                  );
                  if (newUser != null) {
                    Navigator.pushNamed(context, RootApp.id);
                  }
                } catch (e) {
                  print('Error during registration: $e');
                }
              },
              title: 'Register',
            ),
          ],
        ),
      ),
    );
  }
}
