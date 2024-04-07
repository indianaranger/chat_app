
//import 'dart:js';

import 'package:chat_app_3/components/user_tile.dart';
import 'package:chat_app_3/pages/chat_page.dart';
import 'package:chat_app_3/services/auth/auth_service.dart';
import 'package:chat_app_3/components/my_drawer.dart';
import 'package:chat_app_3/services/auth/chat/chat_services.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
   HomePage({super.key});

  final ChatService _chatService=ChatService();
  final AuthService _authService=AuthService();

  void logout(){
    final _auth=AuthService();
    _auth.signOut();
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(   
        title:const Text("Home Page"),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey,
        elevation: 0,
        actions: [
          IconButton(onPressed: logout, icon: const Icon(Icons.logout))
      ],
      ),
      drawer: const MyDrawer(),
      body: _buildUserList(),
    );
  }

  Widget _buildUserList(){
    return StreamBuilder(stream: _chatService.getUsersStream(), builder: (context,snapshot){
      if(snapshot.hasError){
        return const Text("Error");
      }

      if(snapshot.connectionState==ConnectionState.waiting){
        return const Text("Loading");
      }

      return ListView(
        children: snapshot.data!.map<Widget>((userData)=>_buildUserListItem(userData,context)).toList(),
      );
    });
  }

  Widget _buildUserListItem(
    Map<String,dynamic> userData,BuildContext context){
      if(userData["email"]!=_authService.getCurrentUser()){
        return UserTile(
        text: userData["email"],
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatPage(
            receiverEmail: userData["email"],
            receiverID: userData["uid"],
          ),
          ),
          );
        },
      );
      }
      else{
        return Container();
      }
    }
  
}