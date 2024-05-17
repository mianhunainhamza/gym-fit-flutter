import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:softec_app_dev/utils/colors.dart';
import 'package:softec_app_dev/view/Screens/LiveCall/live_screen.dart';
import 'package:uuid/uuid.dart';

class LiveSession extends StatelessWidget {
  const LiveSession({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            const Text('Live', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('live').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final liveSessions = snapshot.data!.docs;

          if (liveSessions.isEmpty) {
            return const Center(
                child: Text(
              'No Live Session',
              style: TextStyle(fontWeight: FontWeight.bold),
            ));
          }

          return ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: liveSessions.length,
            itemBuilder: (BuildContext context, int index) {
              final liveSession =
                  liveSessions[index].data() as Map<String, dynamic>;
              final sessionId = liveSession['sessionId'];
              final hostName = liveSession['hostName'];

              return Padding(
                padding: const EdgeInsets.all(10),
                child: SizedBox(
                  height: 230,
                  width: Get.width - 20,
                  child: Card(
                    color: Colors.yellow,
                    child: InkWell(
                      onTap: () {
                        // Navigate to the next page with session details
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LivePage(
                              liveID: sessionId,
                            ),
                          ),
                        );
                      },
                      child: Stack(
                        children: [
                          Image.asset(
                            'assets/images/thumbnail.png', // Default thumbnail
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Align(
                              alignment: Alignment.bottomRight,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.5),
                                  // Black color background with opacity
                                  borderRadius: BorderRadius.circular(
                                      10), // Rounded corners
                                ),
                                child: Text(
                                  "${hostName.split('@').first}",
                                  style: const TextStyle(
                                    color: Colors.white, // Text color
                                    fontSize: 12, // Adjust font size as needed
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(5),
        child: FloatingActionButton(
          shape: const CircleBorder(),
          backgroundColor: yellowColor,
          onPressed: () {
            User? user = FirebaseAuth.instance.currentUser;
            String? uid = user?.uid;
            FirebaseFirestore.instance
                .collection('users')
                .doc(uid)
                .get()
                .then((userData) {
              if (userData.exists) {
                final role = userData['role'];
                if (role == 'Fitness Professional') {
                  String uniqueLiveID = const Uuid().v4();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LivePage(
                                liveID: uniqueLiveID,
                                isHost: true,
                              )));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      backgroundColor: Colors.white,
                      duration: Duration(seconds: 2),
                      content: Text(
                        'Only Fitness Professionals can start a live session',
                        style: TextStyle(color: Colors.black),
                      )));
                }
              }
            });
          },
          child: const Icon(
            Icons.live_tv,
          ), // Replace with appropriate icon
        ),
      ),
    );
  }
}
