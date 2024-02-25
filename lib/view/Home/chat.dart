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

  Widget _buildUserList() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('Users').snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
        if (snapshot.hasError) {
          return const Text('Error');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Waiting...');
        }
        if (snapshot.hasData) {
          return ListView(
            children: snapshot.data!.docs
                .map<Widget>((doc) => _buildUserListItem(doc))
                .toList(),
          );
        }
        return ListView();
      },
    );
  }

  Widget _buildUserListItem(DocumentSnapshot? document) {
    if (document == null || !document.exists) {
      return SizedBox(); // Return an empty SizedBox if document is null or doesn't exist
    }

    final data = document.data() as Map<String, dynamic>?;

    if (data == null || _auth.currentUser?.email == data['email']) {
      return SizedBox(); // Return an empty SizedBox if data is null or current user's email matches
    }

    return ListTile(
      title: Text(
          data['name'] ?? ''), // Use empty string as default if name is null
      onTap: () {
        Get.to(ChatScreen(
          rUserId:
              data['uid'] ?? '', // Use empty string as default if uid is null
          rUserEmail: data['email'] ??
              '', // Use empty string as default if email is null
          rUserName:
              data['name'] ?? '', // Use empty string as default if name is null
        ));
      },
    );
  }
}
