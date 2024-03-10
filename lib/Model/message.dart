import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  String message;
  String receiverId;
  String senderEmail;
  String senderId;
  Timestamp timeStamp;

  Message({
    required this.message,
    required this.receiverId,
    required this.senderEmail,
    required this.senderId,
    required this.timeStamp,
  });

  // Convert Message object to a map
  Map<String, dynamic> toMap() {
    return {
      'message': message,
      'receiverId': receiverId,
      'senderEmail': senderEmail,
      'senderId': senderId,
      'timeStamp': timeStamp,
    };
  }
}
