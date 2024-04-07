import 'package:chat_app_3/services/auth/auth_service.dart';
import 'package:chat_app_3/components/my_buttons.dart';
import 'package:chat_app_3/components/my_textfield.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/widgets.dart';

class LoginPage extends StatelessWidget {

  final TextEditingController _emailcontroller=TextEditingController();
  final TextEditingController _pwcontroller=TextEditingController();
  final void Function()? onTap;

   LoginPage({super.key,required this.onTap});

   void login(BuildContext context) async{
    final authService=AuthService();
    try{
      await authService.signInWithEmailPassword(_emailcontroller.text, _pwcontroller.text,);
    }
    catch(e){
      showDialog(context: context, builder:(context) => AlertDialog(
        title: Text(e.toString()),
      ),);
    }

   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Icon(
              Icons.message,
              size: 60,
              color: Theme.of(context).colorScheme.primary,
            ),

            const SizedBox(height: 50,),

            Text(
              "WELCOME BACK",
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 16,
              ),
              ),

            const SizedBox(height: 10,),

            MyTextFild(
              hintText: "Email",
              obscureText: false,
              controller: _emailcontroller,
              ),

            const SizedBox(height: 10,),

            MyTextFild(
              hintText: "Password",
              obscureText: true,
              controller: _pwcontroller,
              ),

              const SizedBox(height: 25,),

               MyButton(
                text:"Login",
                onTap:() => login(context),

               ),

               const SizedBox(height: 10,),

               Row(
                mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   Text(
                    "Not a member?",
                   style: TextStyle(color: Theme.of(context).colorScheme.primary),
                   ),
                   GestureDetector(
                    onTap: onTap,
                     child: const Text(
                      "Register now",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                      ),
                   )
                 ],
               ),

          ],
        ),
      ),
    );
  }
}