import 'package:betlink/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../constants.dart';
import '../Components/roundedbutton.dart';
import 'package:betlink/pages/root.dart';

class RegistrationScreen extends ConsumerStatefulWidget{
  static String id = 'registrationScreen';

  @override
  ConsumerState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends ConsumerState<RegistrationScreen> {
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
             Hero(
                tag: 'logo',
                child: Container(
                  height: 100.0,
                  child: Image.asset('assets/images/home.jpg'),
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                'Signup to BetLink',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              
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
                      await ref.read(UserProvider.notifier).signup(_emailController.text);
                      if (newUser != null) {
                        _emailController.clear();
                        _passwordController.clear();
                        Navigator.pushNamed(context, RootApp.id);
                      }
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
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
