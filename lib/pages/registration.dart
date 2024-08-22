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
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Custom email validation using RegExp
  bool isValidEmail(String email) {
    final RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // ... (other widgets remain unchanged)
              
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!isValidEmail(value)) {
                    return 'Invalid email format';
                  }
                  return null;
                },
                decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Enter your email',
                ),
              ),
              TextFormField(
                controller: _passwordController,
                validator: (value) {
                  if (value == null || value.length < 6 || value.isEmpty) {
                    return 'Please enter your password (at least 6 characters)';
                  }
                  return null;
                },
                obscureText: true, // Hide password
                decoration: kTextFieldDecoration.copyWith(hintText: 'Enter your password'),
              ),

              // ... (other widgets remain unchanged)

              RoundedButton(
                color: Colors.lightGreen,
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    try {
                      final newUser = await _auth.createUserWithEmailAndPassword(
                        email: _emailController.text,
                        password: _passwordController.text,
                      );
                      if (newUser != null) {
                        _emailController.clear();
                        _passwordController.clear();
                        Navigator.pushNamed(context, RootApp.id);
                      }
                    } catch (e) {
                      print('Error during registration: $e');
                    }
                  }
                },
                title: 'Register',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
