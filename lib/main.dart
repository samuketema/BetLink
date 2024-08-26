import 'package:betlink/pages/add_property.dart';
import 'package:betlink/pages/dashboard.dart';
import 'package:betlink/pages/home.dart';
import 'package:betlink/pages/login.dart';
import 'package:betlink/pages/register_as_agent.dart';
import 'package:betlink/pages/registration.dart';
import 'package:betlink/pages/welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import '../firebase_options.dart';
import 'pages/root.dart';
import 'theme/color.dart';
import 'widgets/image_upload.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Real Estate App',
      theme: ThemeData(
        primaryColor: AppColor.primary,
      ),
      initialRoute: WelcomeScreen.id,
      routes: {
        RootApp.id : (context) => RootApp(),
        HomePage.id : (context) => HomePage(),
        WelcomeScreen.id : (context) => WelcomeScreen(),
        RegistrationScreen.id : (context) => RegistrationScreen(),
       LoginScreen.id : (context) => LoginScreen(),
       DashboardScreen.id : (context) => DashboardScreen(),
       AddProperty.id: (context)=> AddProperty(),
      UploadImageAndMore.id : (context)=> UploadImageAndMore(),
      RegisterAsAgent.id: (context) => RegisterAsAgent()
      },
    );
  }
}
