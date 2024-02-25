import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:google_fonts/google_fonts.dart';

class WorkCard extends StatelessWidget {
  final bool isJoined;
  final String title;
  final String calories;
  final String type;
  final String time;
  final String body;
  final Callback function;

  const WorkCard({super.key, required this.isJoined, required this.title, required this.calories, required this.type, required this.time, required this.body, required this.function});

  @override
  Widget build(BuildContext context) {
    String? userid = FirebaseAuth.instance.currentUser?.uid;
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 25, top: 10),
              child: SizedBox(
                width: Get.width,
                child: Text(
                  type.toString().toUpperCase(),
                  style: GoogleFonts.poppins(
                    color: Colors.black.withOpacity(.4),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25, top: 10),
              child: SizedBox(
                width: Get.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: Get.height * .027,
                      ),
                    ),
                    Text(
                      body,
                      style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: Get.height * .027,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 25),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        const Icon(CupertinoIcons.clock),
                        const SizedBox(width: 8),
                        Text(time.toString()),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          CupertinoIcons.flame,
                          color: Colors.deepOrange,
                        ),
                       const SizedBox(width: 8),
                        Text(calories.toString()),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        // Image
        Positioned(
          right: 0,
          top: 0,
          bottom: 0,
          child: Container(
            width: Get.width / 2, // Adjust the width as needed
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/girl.png'),
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
        if (isJoined) Positioned(
                right: 15,
                top: 10,
                child: GestureDetector(
                  onTap: ()
                  {
                    showCupertinoDialog(
                      context: context,
                      builder: (context) {
                        return CupertinoAlertDialog(
                          title: Text("Are you sure to leave?",style: GoogleFonts.poppins(fontSize: 17)),
                          actions: <Widget>[
                            CupertinoDialogAction(
                              child: Text('Cancel',style: GoogleFonts.poppins(color: Colors.black)),
                              onPressed: () {
                                Navigator.of(context).pop(); // Close the dialog
                              },
                            ),
                            CupertinoDialogAction(
                              child: Text('OK',style: GoogleFonts.poppins(color: Colors.red),),
                              onPressed: () {
                                Get.back();
                                removeFromJoined(function,userid!, title, body, time, calories);
                                Get.snackbar('Congratulation', 'You have successfully left the Event',duration: const Duration(seconds: 1));
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Icon(CupertinoIcons.delete)),
                ),
              ) else Positioned(
                right: 15,
                top: 10,
                child: GestureDetector(
                  onTap: ()
                  {
                    showCupertinoDialog(
                      context: context,
                      builder: (context) {
                        return CupertinoAlertDialog(
                          title: Text("Are you sure to Join?",style: GoogleFonts.poppins(fontSize: 17)),
                          actions: <Widget>[
                            CupertinoDialogAction(
                              child: Text('Cancel',style: GoogleFonts.poppins(color: Colors.black)),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            CupertinoDialogAction(
                              child: Text('OK',style: GoogleFonts.poppins(color: Colors.red),),
                              onPressed: () {
                                Get.back();
                                addToJoined(function,userid!, title, body, time, calories);
                                Get.snackbar('Congratulation', 'You have successfully join the Event',duration: const Duration(seconds: 1));
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Icon(CupertinoIcons.add_circled)),
                ),
              ),
      ],
    );
  }
  Future<void> removeFromJoined(
      VoidCallback function,
      String userUid,
      String title,
      String body,
      String time,
      String calories,
      ) async {
    print('remove');
    final eventsCollection = FirebaseFirestore.instance.collection('events');

    final querySnapshot = await eventsCollection
        .where('title', isEqualTo: title)
        .where('body', isEqualTo: body)
        .where('time', isEqualTo: time)
        .where('calories', isEqualTo: calories)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      final eventDocRef = querySnapshot.docs.first.reference;
      await eventDocRef.update({
        'joinedUsers': FieldValue.arrayRemove([userUid]),
      });
      function();
    }
  }


  Future<void> addToJoined(
      VoidCallback function,
      String userUid,
      String title,
      String body,
      String time,
      String calories,
      ) async {
    final eventsCollection = FirebaseFirestore.instance.collection('events');

    final querySnapshot = await eventsCollection
        .where('title', isEqualTo: title)
        .where('body', isEqualTo: body)
        .where('time', isEqualTo: time)
        .where('calories', isEqualTo: calories)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      final eventDocRef = querySnapshot.docs.first.reference;

      await eventDocRef.update({
        'joinedUsers': FieldValue.arrayUnion([userUid]),
      });

      function();
    }
  }
}
