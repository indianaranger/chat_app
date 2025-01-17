//import 'package:flutter/foundation.dart';
//mport 'dart:js';

import 'package:chat_app_3/components/chat_bubble.dart';
import 'package:chat_app_3/components/my_textfield.dart';
import 'package:chat_app_3/services/auth/auth_service.dart';
import 'package:chat_app_3/services/auth/chat/chat_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  final String receiverEmail;
  final String receiverID;
  ChatPage({super.key,required this.receiverEmail,required this.receiverID});

  final TextEditingController _messageController= TextEditingController();

  final ChatService _chatService=ChatService();
  final AuthService _authService=AuthService();

  void sendMessage() async{
    if(_messageController.text.isNotEmpty){
      await _chatService.sendMessage(receiverID, _messageController.text);
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(   
        title:Text(receiverEmail),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey,
        elevation: 0,
        
      ),
      body: Column(
        children: [
          Expanded(
            child: _buildMessageList(),
        ),
        _buildUserInput(),

      ],),
    );
  }

  Widget _buildMessageList(){
    String senderID=_authService.getCurrentUser()!.uid;
    return StreamBuilder(stream: _chatService.getMessages(receiverID, senderID), builder: (context,snapshot){
      if(snapshot.hasError){
        return const Text("Error");

      }
      if(snapshot.connectionState==ConnectionState.waiting){
        return const Text("Loading...");
      }
      return ListView(
        children: snapshot.data!.docs.map((doc)=>_buildMessageItem(doc)).toList(),
      );
    }
    );
  }

  Widget _buildMessageItem(DocumentSnapshot doc){
    Map<String,dynamic> data =doc.data() as Map<String,dynamic>;

    bool isCurrentUser = data['senderID']==_authService.getCurrentUser()!.uid;

    var alignment=isCurrentUser? Alignment.centerRight : Alignment.centerLeft;

    return Container(
      alignment:alignment,
      child: Column(
        crossAxisAlignment: isCurrentUser? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          ChatBubble(
            message: data["message"],
            isCurrentUser: isCurrentUser),
          //Text(data['message']),
        ],
      ));
  }
    Widget _buildUserInput(){
      return Padding(
        padding: const EdgeInsets.only(bottom:50.0),
        child: Row(
          children: [
            Expanded(child: MyTextFild(
              controller: _messageController,
              hintText: "Type a message",
              obscureText: false,
            ),
            ),
        
            Container(
              decoration: const BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
              ),
              margin: const EdgeInsets.only(right: 25.0),
              child: IconButton(
                onPressed: sendMessage, 
                icon: const Icon(
                  Icons.arrow_upward,
                  color: Colors.white,
                  ),
                  ),
                  ),
          ],
        ),
      );
    }
}
