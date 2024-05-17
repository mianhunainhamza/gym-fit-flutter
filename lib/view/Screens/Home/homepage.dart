import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:softec_app_dev/utils/colors.dart';
import 'package:softec_app_dev/view/Screens/Work/fetch_event.dart';
import '../../../model/post.dart';
import '../../../view_model/feed_controller.dart';
import 'Feed/new_Feed.dart';
import 'fetch_trainers.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FeedController feedController = Get.put(FeedController());
  late String? name = ' ';
  final List<Map<String, dynamic>> userJoinedEvents = [];
  final List<Map<String, dynamic>> allEvents = [];
  late Future<List<PostModel>> posts;

  @override
  void initState() {
    super.initState();
    getName();
    fetchUserJoinedEvents();
    posts = feedController.getPosts();
  }

  Future<void> refresh() async {
    getName();
    fetchUserJoinedEvents();
    posts = feedController.getPosts();
  }

  Future<void> getName() async {
    User? user = FirebaseAuth.instance.currentUser;
    setState(() {
      name = user?.displayName;
    });
  }

  Future<void> fetchUserJoinedEvents() async {
    User? user = FirebaseAuth.instance.currentUser;
    final currentUserUid = user?.uid;

    if (currentUserUid != null) {
      final eventsSnapshot = await FirebaseFirestore.instance.collection('events').get();

      userJoinedEvents.clear();
      allEvents.clear();

      for (var eventDoc in eventsSnapshot.docs) {
        final eventData = eventDoc.data();
        if (eventData['joinedUsers'] != null && eventData['joinedUsers'].contains(currentUserUid)) {
          setState(() {
            userJoinedEvents.add(eventData);
          });
        } else {
          setState(() {
            allEvents.add(eventData);
          });
        }
      }
    }
  }

  Widget trainerSkeleton() {
    return Container(
      margin: const EdgeInsets.only(right: 10.0),
      width: Get.width * 0.2,
      height: Get.height * 0.1,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4000.0),
        color: Colors.grey[200],
      ),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: const Center(
          child: SizedBox(
            width: 30,
            height: 30,
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        displacement: Get.height * 0.1,
        edgeOffset: Get.height * 0.1,
        color: Colors.amber,
        onRefresh: refresh,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Hello $name",
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500,
                                  fontSize: Get.width * 0.07)),
                          const SizedBox(height: 5),
                          Text(
                            "Let's get workout.",
                            style: GoogleFonts.poppins(
                              fontSize: Get.width * 0.07,
                              color: yellowDark,
                              fontWeight: FontWeight.w700,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: Get.width * 0.15,
                        width: Get.width * 0.15,
                        child: ClipRRect(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(20000),
                          ),
                          child: Image.asset(
                            "assets/images/dp.jpg",
                            filterQuality: FilterQuality.high,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: Get.height * 0.01),
            SizedBox(
              width: Get.width,
              height: Get.height * 0.31,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: allEvents.isEmpty ? 1 : allEvents.length,
                itemBuilder: (context, index) {
                  if (allEvents.isEmpty) {
                    return Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: buildWorkCardSkeleton(),
                    );
                  } else {
                    final event = allEvents[index];
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
                ,Padding(
                  padding:const  EdgeInsets.symmetric(horizontal: 15),
                  child: Divider(
                    thickness: 3,
                    color: yellowDark,
                  ),
                ),
                SizedBox(height: Get.height * 0.04),
                Padding(
                  padding:const  EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    "Featured Trainers",
                    style: GoogleFonts.poppins(
                      fontSize: Get.width * 0.06,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                SizedBox(height: Get.height * 0.018),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: Get.height * 0.15,
                    child: FutureBuilder<Map<String, String>>(
                      future: fetchProfessionalData(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: Row(
                              children: List.generate(4, (index) => trainerSkeleton()),
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else {
                          final Map<String, String> professionals = snapshot.data!;
                          return ListView.builder(
                            itemCount: snapshot.data!.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (BuildContext context, int index) {
                              return  Row(
                                children: [
                                  Column(
                                    children: [
                                      Container(
                                        width: Get.width * 0.21,
                                        height: Get.width * 0.21,
                                        decoration: const BoxDecoration(
                                          borderRadius:
                                          BorderRadius.all(Radius.circular(2000)),
                                          image: DecorationImage(
                                            filterQuality: FilterQuality.high,
                                            fit: BoxFit.fitHeight,
                                            image:
                                            AssetImage("assets/images/trainer.jpg"),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: Get.height * 0.015),
                                      Text(
                                        professionals.keys.elementAt(index),
                                        style: GoogleFonts.poppins(
                                          fontSize: Get.width * 0.04,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(width: Get.width * 0.025),
                                ],
                              );
                            },
                          );
                        }
                      },
                    ),
                  ),
                ),
                SizedBox(height: Get.height * 0.025),


                Padding(
                  padding:const  EdgeInsets.symmetric(horizontal: 15),
                  child: Divider(
                    thickness: 3,
                    color: yellowDark,
                  ),
                ),


                SizedBox(height: Get.height * 0.018),
                // Padding(
                //   padding:const  EdgeInsets.symmetric(horizontal: 15),
                //   child: Text(
                //     "Latest Videos",
                //     style: GoogleFonts.poppins(
                //       fontSize: Get.width * 0.06,
                //       fontWeight: FontWeight.w800,
                //     ),
                //   ),
                // ),
                // SizedBox(height: Get.height * 0.018),
                // Padding(
                //   padding:const  EdgeInsets.symmetric(horizontal: 15),
                //   child: SizedBox(
                //     width: MediaQuery.of(context).size.width,
                //     height: Get.height * 0.22,
                //     child: ListView.builder(
                //       physics: const BouncingScrollPhysics(),
                //       scrollDirection: Axis.horizontal,
                //       itemCount: 5,
                //       itemBuilder: (context, index) {
                //         return Row(
                //           children: [
                //             GestureDetector(
                //               child: Container(
                //                 width: Get.width * 0.45,
                //                 decoration: BoxDecoration(
                //                   borderRadius: BorderRadius.all(
                //                       Radius.circular(Get.width * 0.04)),
                //                   image: const DecorationImage(
                //                     filterQuality: FilterQuality.high,
                //                     fit: BoxFit.cover,
                //                     image: AssetImage("assets/images/video.jpg"),
                //                   ),
                //                 ),
                //                 child: Column(
                //                   mainAxisAlignment: MainAxisAlignment.end,
                //                   children: [
                //                     Row(
                //                       mainAxisAlignment: MainAxisAlignment.start,
                //                       children: [
                //                         SizedBox(width: Get.width * 0.035),
                //                         Column(
                //                           crossAxisAlignment:
                //                           CrossAxisAlignment.start,
                //                           children: [
                //                             Text(
                //                               "2 weeks",
                //                               style: GoogleFonts.poppins(
                //                                 color: Colors.white,
                //                                 fontSize: Get.width * 0.035,
                //                               ),
                //                             ),
                //                             Text(
                //                               "Zumba Fitness",
                //                               style: GoogleFonts.poppins(
                //                                 color: Colors.white,
                //                                 fontSize: Get.width * 0.035,
                //                               ),
                //                             ),
                //                           ],
                //                         ),
                //                       ],
                //                     ),
                //                     SizedBox(height: Get.height * 0.015),
                //                   ],
                //                 ),
                //               ),
                //             ),
                //             SizedBox(width: Get.width * 0.035),
                //           ],
                //         );
                //       },
                //     ),
                //   ),
                // ),
                // SizedBox(height: Get.height * 0.025),
                // Padding(
                //   padding:const  EdgeInsets.symmetric(horizontal: 15),
                //   child: Divider(
                //     thickness: 3,
                //     color: yellowDark,
                //   ),
                // ),
                SizedBox(height: Get.height * 0.018),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:const  EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        "Explore",
                        style: GoogleFonts.poppins(
                          fontSize: Get.width * 0.06,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: newFeed(posts),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
