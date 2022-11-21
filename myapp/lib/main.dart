// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/homepage.dart';
import 'package:myapp/login.dart';
import 'package:myapp/sharedPreference_auth.dart';
import 'package:myapp/signUp.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      key: UniqueKey(),
      debugShowCheckedModeBanner: false,
      title: "Login page",
      initialRoute: SaveUserAuth.getCredential() == null ||
              SaveUserAuth.getCredential() == 0
          ? LoginPage.path
          : HomePage.path,
      routes: {
        LoginPage.path: (context) => LoginPage(),
        SignUp.path: (context) => SignUp(),
        HomePage.path: (context) => HomePage(),
      },
    );
  }
}
