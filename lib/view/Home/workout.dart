import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:softec_app_dev/view/Home/work_card.dart';
import '../../utils/colors.dart';

class WorkOutPage extends StatefulWidget {
  const WorkOutPage({Key? key}) : super(key: key);

  @override
  WorkOutPageState createState() => WorkOutPageState();
}

class WorkOutPageState extends State<WorkOutPage> {
  bool _isDataLoaded = false;
  final List<Map<String, dynamic>> _allEvents = [];

  @override
  void initState() {
    super.initState();
    fetchUserJoinedEvents();
  }

  Future<void> fetchUserJoinedEvents() async {
    User? user = FirebaseAuth.instance.currentUser;
    final currentUserUid = user?.uid;

    if (currentUserUid != null) {
      final eventsSnapshot = await FirebaseFirestore.instance.collection('events').get();

      _allEvents.clear();

      for (var eventDoc in eventsSnapshot.docs) {
        final eventData = eventDoc.data();
        if (eventData['joinedUsers'] != null && eventData['joinedUsers'].contains(currentUserUid)) {
          // _userJoinedEvents.add(eventData);
        } else {
          _allEvents.add(eventData);
        }

      setState(() {
        _isDataLoaded = true;
      });
    }
  }}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Plans",
          style: GoogleFonts.poppins(
            fontSize: Get.height * .03,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Expanded(
            child: _isDataLoaded
                ? RefreshIndicator(
              color: yellowDark,
              onRefresh: fetchUserJoinedEvents,
              child: ListView.builder(
                itemCount: _allEvents.length,
                itemBuilder: (context, index) {
                  final event = _allEvents[index];
                  return buildWorkCard(
                    false,
                    event['title'],
                    event['type'],
                    event['calories'].toString(),
                    event['time'].toString(),
                    event['body'],
                  );
                },
              ),
            )
                : Center(child: CircularProgressIndicator(color: yellowDark)),
          ),
        ],
      ),
    );
  }

  Widget buildWorkCard(
      bool isJoined, String title, String type, String calories, String time, String body) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: yellowColor.withOpacity(Random().nextDouble()),
            ),
            height: 220,
            width: Get.width - 40,
            child: WorkCard(
              function: fetchUserJoinedEvents,
              isJoined: isJoined,
              title: title,
              type: type,
              calories: calories,
              time: time,
              body: body,
            ),
          ),
        ),
      ],
    );
  }
}
