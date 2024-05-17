import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:softec_app_dev/utils/colors.dart';
import 'chat_service.dart';

class ChatScreen extends StatefulWidget {
  final String rUserId;
  final String rUserName;
  final String rUserEmail;

  const ChatScreen(
      {super.key,
      required this.rUserId,
      required this.rUserEmail,
      required this.rUserName});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageController = TextEditingController();
  ChatService chatService = ChatService();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> sendMessage() async {
    if (messageController.text.isNotEmpty) {
      await chatService.sendMessage(widget.rUserId, messageController.text);
      messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.rUserName,style: const TextStyle(fontWeight: FontWeight.w500),),
      ),
      body: Column(
        children: [
          Expanded(child: buildMessageList()),
          buildMessageInput(
              widget.rUserId, _auth.currentUser?.uid ?? "No user id")
        ],
      ),
    );
  }

  Widget buildMessageList() {
    return StreamBuilder<QuerySnapshot>(
      stream: chatService.getMessage(
          widget.rUserId, _auth.currentUser?.uid ?? "No user id"),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Error');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Loading');
        }
        if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
          return const Center(
            child:  Text(
                'No messages'),
          ); // Handle case where there are no messages
        }
        return ListView(
          children: snapshot.data!.docs
              .map((document) => buildMessageItem(document))
              .toList(),
        );
      },
    );
  }

  Widget buildMessageItem(DocumentSnapshot document) {
    final Map<String, dynamic>? data = document.data() as Map<String, dynamic>?;

    if (data == null) {
      // If data is null, return an empty Container or any fallback widget
      return Container();
    }

    // final String senderEmail = data['senderEmail'] ?? '';
    final String message = data['message'] ?? '';
    final String senderId = data['senderId'] ?? '';
    final Timestamp time = data['timeStamp'] ?? '';

    final DateTime date = time.toDate();
    String formattedDateTime = DateFormat('hh:mm a').format(date);
    time.seconds;

    final bool isCurrentUserSender = senderId == _auth.currentUser!.uid;

    return isCurrentUserSender ?
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            decoration: BoxDecoration(
              color: yellowDark,
              borderRadius: BorderRadius.circular(8.0),
            ),
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  formattedDateTime,
                  style: GoogleFonts.poppins(
                    fontSize: Get.width * 0.025,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  message,
                  style: GoogleFonts.poppins(
                    fontSize: Get.width * 0.038,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ):Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(.3),
              borderRadius: BorderRadius.circular(8.0),
            ),
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  message,
                  style: GoogleFonts.poppins(
                    fontSize: Get.width * 0.038,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  formattedDateTime,
                  style: GoogleFonts.poppins(
                    fontSize: Get.width * 0.025,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildMessageInput(receiver, user) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 10, 5, 15),
      child: Row(
        children: [
          Expanded(
              child: TextField(
            controller: messageController,
            decoration: InputDecoration(
              hintText: 'Enter message',
              hintStyle: GoogleFonts.poppins(fontSize: Get.width * 0.04),
              border: InputBorder.none,
            ),
          )),
          IconButton(
              onPressed: () async {
                await sendMessage();
                print(
                    '------------------------------- User here-------------------------');
                print(receiver);
                print(user);
              },
              icon: const Icon(Icons.send))
        ],
      ),
    );
  }
}
