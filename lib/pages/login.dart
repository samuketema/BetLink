import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../constants.dart';
import '../Components/roundedbutton.dart';
import 'package:betlink/pages/root.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'loginScreen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>(); // Add a form key
  String? email;
  String? password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Form(
          key: _formKey, // Associate the form key with the form
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
                'Log in to BetLink',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              TextFormField( // Use TextFormField
                onChanged: (value) {
                  email = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
                decoration: kTextFieldDecoration.copyWith(hintText: 'Enter your email'),
              ),
              SizedBox(height: 8.0),
              TextFormField( // Use TextFormField
                onChanged: (value) {
                  password = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
                obscureText: true, // Hide password
                decoration: kTextFieldDecoration.copyWith(hintText: 'Enter your password'),
              ),
              SizedBox(height: 24.0),
              RoundedButton(
                color: Colors.lightGreen,
                onPressed: () async {
                  if (_formKey.currentState!.validate()) { // Validate the form
                    try {
                      final user = await _auth.signInWithEmailAndPassword(
                        email: email as String,
                        password: password as String,
                      );
                      if (user != null) {
                        print('User logged in: ${user.user?.email}');
                        Navigator.pushNamed(context, RootApp.id);
                      }
                    } catch (e) {
                      print('Error during login: $e');
                    }
                  }
                },
                title: 'Log In',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
