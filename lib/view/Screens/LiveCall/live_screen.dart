import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:zego_uikit_prebuilt_live_streaming/zego_uikit_prebuilt_live_streaming.dart';

class LivePage extends StatefulWidget {
  final String liveID;
  final bool isHost;

  const LivePage({Key? key, required this.liveID, this.isHost = false}) : super(key: key);

  @override
  State<LivePage> createState() => _LivePageState();
}

class _LivePageState extends State<LivePage> {

  late String? userId;
  late String? userName;

  @override
  void initState() {
    super.initState();
    getUser();
    if (widget.isHost) {
      storeLiveSessionInfo();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ZegoUIKitPrebuiltLiveStreaming(
        appID: 1153874272,
        appSign: '97dfa67a28c646830aeeb8e1673d26a5d842a829fe3d747f379e30088ae149c7',
        userID: userId ?? "default",
        userName: '$userName',
        liveID: widget.liveID,
        config: widget.isHost
            ? ZegoUIKitPrebuiltLiveStreamingConfig.host()
            : ZegoUIKitPrebuiltLiveStreamingConfig.audience(),
      ),
    );
  }

  Future<void> getUser() async {
    User? user = FirebaseAuth.instance.currentUser;
    userId = user?.email!;
    userName = user?.displayName;
  }

  Future<void> storeLiveSessionInfo() async {
    try {
      await FirebaseFirestore.instance.collection('live').doc(widget.liveID).set({
        'hostName': userName,
        'hostId': userId,
        'sessionId': widget.liveID,
      });
      print('Live session info stored successfully');
    } catch (error) {
      print('Failed to store live session info: $error');
    }
  }

  @override
  void dispose() {
    if (widget.isHost) {
      deleteLiveSessionInfo();
    }
    super.dispose();
  }

  Future<void> deleteLiveSessionInfo() async {
    try {
      await FirebaseFirestore.instance.collection('live').doc(widget.liveID).delete();
      print('Live session info deleted successfully');
    } catch (error) {
      print('Failed to delete live session info: $error');
    }
  }
}
