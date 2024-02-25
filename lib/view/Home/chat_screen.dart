import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:softec_app_dev/view/Home/chat_service.dart';

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
        title: Text(widget.rUserName),
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
          return const Text(
              'No messages'); // Handle case where there are no messages
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

    final String senderEmail = data['senderEmail'] ?? '';
    final String message = data['message'] ?? '';
    final String senderId = data['senderId'] ?? '';

    final bool isCurrentUserSender = senderId == _auth.currentUser!.uid;
    final Alignment alignment =
        isCurrentUserSender ? Alignment.centerRight : Alignment.centerLeft;

    return Container(
      alignment: alignment,
      child: Column(
        children: [

          Text(message),
        ],
      ),
    );
  }

  Widget buildMessageInput(receiver, user) {
    return Row(
      children: [
        Expanded(
            child: TextField(
          controller: messageController,
          decoration: const InputDecoration(hintText: 'Enter message'),
        )),
        IconButton(
            onPressed: () async {
              await sendMessage();
              print(
                  '------------------------------- User here-------------------------');
              print(receiver);
              print(user);
            },
            icon: const Icon(Icons.arrow_upward))
      ],
    );
  }
}
