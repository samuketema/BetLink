import 'package:betlink/pages/add_property.dart';
import 'package:betlink/pages/dashboard.dart';
import 'package:betlink/pages/brokers_page.dart';
import 'package:betlink/pages/home.dart';
import 'package:betlink/pages/login.dart';
import 'package:betlink/pages/register_as_agent.dart';
import 'package:betlink/pages/registration.dart';
import 'package:betlink/pages/welcome_screen.dart';
import 'package:betlink/providers/user_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../firebase_options.dart';
import 'pages/root.dart';
import 'theme/color.dart';
import 'widgets/image_upload.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(ProviderScope(child: MyApp()));
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
        BrokersPage.id : (context) => const BrokersPage(),
        RootApp.id : (context) => const RootApp(),
        HomePage.id : (context) => const HomePage(),
        WelcomeScreen.id : (context) => WelcomeScreen(),
        RegistrationScreen.id : (context) => RegistrationScreen(),
       LoginScreen.id : (context) => LoginScreen(),
       DashboardScreen.id : (context) => const DashboardScreen(),
       AddProperty.id: (context)=> AddProperty(),
      UploadImageAndMore.id : (context)=> const UploadImageAndMore(),
      RegisterAsAgent.id: (context) => RegisterAsAgent()
      },
    );
  }
}
