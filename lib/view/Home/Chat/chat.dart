import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:softec_app_dev/utils/colors.dart';
import 'package:softec_app_dev/view/Home/Chat/chat_screen.dart';

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
            fontSize: Get.width * 0.07,
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
      stream: FirebaseFirestore.instance.collection('Users').snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
        if (snapshot.hasError) {
          return const Text('Error');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(color: yellowColor,);
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
      return const SizedBox();
    }

    final data = document.data() as Map<String, dynamic>?;

    if (data == null || _auth.currentUser?.email == data['email']) {
      return const SizedBox();
    }

    return ListTile(
      title: Card(
        elevation: 5,
        child: Container(
          width: Get.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: yellowColor,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16),
            child: Row(
              children: [
                const Icon(Icons.chat_bubble_outline),
                const SizedBox(width: 10),
                Text(
                  data['name'] ?? '',
                  style: GoogleFonts.poppins(
                    fontSize: Get.width * 0.05,
                  ),
                ),
              ],
            ),
          ),
        ),
      ), // Use empty string as default if name is null
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
