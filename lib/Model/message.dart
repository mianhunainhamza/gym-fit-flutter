import 'package:cloud_firestore/cloud_firestore.dart';

class Message{
  final String senderId;
  final String senderEmail;
  final String receiverId;
  final String message;
  final Timestamp timeStamp;

  Message({
   required this.message,
   required this.receiverId,
   required this.senderEmail,
   required this.senderId,
   required this.timeStamp
});

  toMap() {
    return{

      'senderID': senderId,
    'senderEmail':senderEmail,
    'receiverID':receiverId,
    'message':message,
    'timeStamp':timeStamp,
  };
  }
}