import 'package:chat_app_3/services/auth/log_or_reg.dart';
import 'package:chat_app_3/pages/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if(snapshot.hasData){ 
            return  HomePage();
          }
         
        else {
          return const LoginOrReg();
        }
        }
      ),
    );
  }
}