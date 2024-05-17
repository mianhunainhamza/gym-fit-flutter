import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:softec_app_dev/utils/colors.dart';

import 'chat_screen.dart';

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
        title: Text(
          'Chat',
          style: GoogleFonts.poppins(
            fontSize: Get.width * 0.06,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: _buildUserList(),
    );
  }

  Widget _buildUserList() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('users').snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
        if (snapshot.hasError) {
          return const Text('Error');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
              child: CircularProgressIndicator(
            color: yellowColor,
          ));
        }
        if (snapshot.hasData) {
          return ListView(
            children: snapshot.data!.docs
                .map((doc) => _buildUserListItem(doc))
                .toList(),
          );
        }
        return const Text('No User',style: TextStyle(color: Colors.black),);
      },
    );
  }

  Widget _buildUserListItem(DocumentSnapshot? document) {
    if (document == null || !document.exists) {
      return const SizedBox();
    }

    final data = document.data() as Map<String, dynamic>?;

    if (data == null || _auth.currentUser?.email == data['email']) {
      return const SizedBox();
    }

    return ListTile(
      title: Container(
        width: Get.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 13),
          child: Row(
            children: [
              const Icon(CupertinoIcons.profile_circled),
              const SizedBox(width: 10),
              Text(
                data['name'] ?? '',
                style: GoogleFonts.poppins(
                  fontSize: Get.width * 0.04,
                ),
              ),
            ],
          ),
        ),
      ),
      onTap: () {
        Get.to(
            ChatScreen(
              rUserId: data['uid'] ?? '',
              rUserEmail: data['email'] ?? '',
              rUserName: data['name'] ?? '',
            ),
            transition: Transition.cupertino);
      },
    );
  }
}
