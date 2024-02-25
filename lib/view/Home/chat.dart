import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:softec_app_dev/view/Home/chat_screen.dart';

class Chat extends StatefulWidget {
  const Chat({super.key});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
        centerTitle: true,
      ),
      body: _buildUserList(),
    );
  }
  Widget _buildUserList(){
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Users').snapshots(),
        builder: (context,snapshot){
          if (snapshot.hasError){
            return const Text('Error');
          }
          if (snapshot.connectionState == ConnectionState.waiting){
            return const Text('Waiting...');
          }
          return ListView(
            children: snapshot.data!.docs.map<Widget>((doc)=> _buildUserListItem(doc)).toList(),
          );
        }
    );
  }

  Widget _buildUserListItem(DocumentSnapshot document){
    Map<String,dynamic> data = document.data()! as Map<String,dynamic>;
    if (_auth.currentUser!.email != data['email']){
      return ListTile(
        title: Text(data['name']),
        onTap: (){
          Get.to( ChatScreen(rUserId: data['uid'], rUserEmail: data['email'], rUserName: data['name']));
        },
      );
    } else{
      return Container();
    }
  }
}
