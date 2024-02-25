import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:softec_app_dev/view/Home/work_card.dart';
import 'package:softec_app_dev/view/Home/workout.dart';

import '../../utils/colors.dart';

class Events extends StatefulWidget {
  const Events({Key? key}) : super(key: key);

  @override
  EventsState createState() => EventsState();
}

class EventsState extends State<Events> {
  bool _isDataLoaded = false;
  final List<Map<String, dynamic>> _userJoinedEvents = [];
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

      _userJoinedEvents.clear();
      _allEvents.clear();

      for (var eventDoc in eventsSnapshot.docs) {
        final eventData = eventDoc.data();
        if (eventData['joinedUsers'] != null && eventData['joinedUsers'].contains(currentUserUid)) {
          _userJoinedEvents.add(eventData);
        } else {
          _allEvents.add(eventData);
        }
      }

      setState(() {
        _isDataLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Workout",
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
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Workout Plan',
                  style: GoogleFonts.poppins(
                    fontSize: Get.height * .023,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                GestureDetector(
                  onTap: ()
                  {
                    Get.to(() => WorkOutPage(function: fetchUserJoinedEvents,),transition: Transition.cupertino);
                  },
                  child: Text(
                    'See more',
                    style: GoogleFonts.poppins(
                      fontSize: Get.height * .018,
                      fontWeight: FontWeight.w600,
                      color: yellowDark,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: _isDataLoaded
                ? RefreshIndicator(
              color: yellowDark,
              onRefresh: fetchUserJoinedEvents,
              child: ListView.builder(
                itemCount: _allEvents.isEmpty ? 0 : 1,
                itemBuilder: (context, index) {
                  // Check if _allEvents is not empty before accessing the first item
                  if (_allEvents.isNotEmpty) {
                    final event = _allEvents.first;
                    return buildWorkCard(
                      false,
                      event['title'],
                      event['type'],
                      event['calories'].toString(),
                      event['time'].toString(),
                      event['body'],
                    );
                  } else {
                    // If _allEvents is empty, return a placeholder widget or null
                    return  Text('No New Plan',
                    style: GoogleFonts.poppins()); // or return null;
                  }
                },
              ),

            )
                : Center(child: CircularProgressIndicator(color: yellowDark)),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Text(
              'Your Plans',
              style: GoogleFonts.poppins(
                fontSize: Get.height * .023,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: _isDataLoaded
                ? RefreshIndicator(
              color: yellowDark,
              onRefresh: fetchUserJoinedEvents,
              child: ListView.builder(
                itemCount: _userJoinedEvents.length,
                itemBuilder: (context, index) {
                  final event = _userJoinedEvents[index];
                  return buildWorkCard(
                    true,
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
