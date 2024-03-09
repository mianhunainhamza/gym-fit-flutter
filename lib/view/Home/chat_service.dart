import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:softec_app_dev/Model/message.dart';

class ChatService extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Future<void> sendMessage(String receiverId, String messages) async {
    final String? currentUserId = _firebaseAuth.currentUser?.uid;
    final String? currentUserEmail =
        _firebaseAuth.currentUser?.email.toString();
    final Timestamp timestamp = Timestamp.now();

    Message newMessage = Message(
        message: messages,
        receiverId: receiverId,
        senderEmail: currentUserEmail ?? "No email",
        senderId: currentUserId ?? "No id",
        timeStamp: timestamp);

    List<String?> ids = [currentUserId, receiverId];

    String chatRoomId = ids.join("_");
    print(chatRoomId);

    await firebaseFirestore
        .collection('chat_room')
        .doc('1')
        .collection('message')
        .add(newMessage.toMap());
  }
  // GCVkDmCgNyMhVwbtuFSXBAxpvWs2_AEQv0pEJrLTh4PHziOZBJkcE5243

  Stream<QuerySnapshot> getMessage(userId, otherUserId) {
    List<String> ids = [otherUserId, userId];
    String chatRoomId = ids.join("_");
    print(chatRoomId);

    return firebaseFirestore
        .collection('chat_room')
        .doc('1')
        .collection('message')
        .orderBy('timeStamp', descending: false)
        .snapshots();
  }
}
