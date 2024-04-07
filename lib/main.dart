
//import 'dart:js';

import 'package:chat_app_3/services/auth/auth_gate.dart';
//import 'package:chat_app_3/auth/log_or_reg.dart';
import 'package:chat_app_3/firebase_options.dart';
//import 'package:chat_app_3/pages/login_page.dart';
//import 'package:chat_app_3/pages/reg_page.dart';
//import 'package:chat_app_3/themes/light_mode.dart';
import 'package:chat_app_3/themes/theme_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    ChangeNotifierProvider(
      create:(context)=>ThemeProvider(),
      child: const MyApp(),
      ),
    );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:  const AuthGate(),
      theme: Provider.of<ThemeProvider>(context).themeData,

    );
  }
}