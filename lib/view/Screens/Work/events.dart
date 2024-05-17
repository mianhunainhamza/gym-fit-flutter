import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:softec_app_dev/view/Screens/Work/work_card.dart';
import 'package:softec_app_dev/view/Screens/Work/workout.dart';
import '../../../utils/colors.dart';
import 'fetch_event.dart';

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
      final eventsSnapshot =
          await FirebaseFirestore.instance.collection('events').get();

      _userJoinedEvents.clear();
      _allEvents.clear();

      for (var eventDoc in eventsSnapshot.docs) {
        final eventData = eventDoc.data();
        if (eventData['joinedUsers'] != null &&
            eventData['joinedUsers'].contains(currentUserUid)) {
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
                  onTap: () {
                    Get.to(
                        () => WorkOutPage(
                              function: fetchUserJoinedEvents,
                            ),
                        transition: Transition.cupertino);
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
                      itemCount: _allEvents.isEmpty ? 1 : 1,
                      itemBuilder: (context, index) {
                        if (_allEvents.isEmpty) {
                          return Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: buildWorkCardSkeleton(),
                          );
                        } else {
                          final event = _allEvents.first;
                          return buildWorkCard(
                            fetchUserJoinedEvents,
                            false,
                            event['title'],
                            event['type'],
                            event['calories'].toString(),
                            event['time'].toString(),
                            event['body'],
                          );
                        }
                      },
                    ),
                  )
                : Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: buildWorkCardSkeleton(),
                  ),
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
                          fetchUserJoinedEvents,
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
                : Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: buildWorkCardSkeleton(),
                  ),
          ),
        ],
      ),
    );
  }
}
