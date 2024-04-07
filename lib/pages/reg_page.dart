
import 'package:chat_app_3/services/auth/auth_service.dart';
import 'package:chat_app_3/components/my_buttons.dart';
import 'package:chat_app_3/components/my_textfield.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/widgets.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController _emailcontroller=TextEditingController();
  final TextEditingController _pwcontroller=TextEditingController();
  final TextEditingController _confirmpwcontroller=TextEditingController();
  final void Function()? onTap;
   RegisterPage({super.key,required this.onTap});

   void register(BuildContext context){
    final _auth=AuthService();

    if(_pwcontroller.text==_confirmpwcontroller.text){
      try{
        _auth.signUpWithEmailPassword(_emailcontroller.text, _pwcontroller.text);
      }
      catch(e){
         showDialog(context: context, builder:(context) => AlertDialog(
        title: Text(e.toString()),
        ),
        );
      }
    }

    else{
      showDialog(context: context, builder:(context) => const AlertDialog(
        title: Text("Passwords dont match!"),
        ),
        );
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

              MyTextFild(
              hintText: "Confirm Password",
              obscureText: true,
              controller: _confirmpwcontroller,
              ),


              const SizedBox(height: 25,),

               MyButton(
                text:"Register",
                onTap:() => register(context),

               ),

               const SizedBox(height: 10,),

               Row(
                mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   Text(
                    "Already have an account?",
                   style: TextStyle(color: Theme.of(context).colorScheme.primary),
                   ),
                    GestureDetector(
                      onTap: onTap,
                      child: const Text(
                      "Let's login now",
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