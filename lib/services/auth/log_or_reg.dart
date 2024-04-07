import 'package:chat_app_3/pages/login_page.dart';
import 'package:chat_app_3/pages/reg_page.dart';
import 'package:flutter/material.dart';

class LoginOrReg extends StatefulWidget {
  const LoginOrReg({super.key});

  @override
  State<LoginOrReg> createState() => _LoginOrRegState();
}

class _LoginOrRegState extends State<LoginOrReg> {

  bool showLoginPage=true; 

  void togglePages(){
    setState(() {
      showLoginPage=!showLoginPage;
    });
  }
  @override
  Widget build(BuildContext context) {
    if(showLoginPage){
      return LoginPage(
        onTap: togglePages,
      );
      
    }
    else{
      return RegisterPage(
        onTap: togglePages,
      );
    }
  }
}