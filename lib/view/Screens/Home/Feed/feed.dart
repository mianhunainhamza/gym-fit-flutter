import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:softec_app_dev/utils/colors.dart';
import 'package:softec_app_dev/view/Screens/LiveCall/live_sessions.dart';
import '../../../../model/post.dart';
import '../../../../view_model/feed_controller.dart';
import 'new_Feed.dart';
import 'new_post.dart';

class Feed extends StatefulWidget {
  const Feed({Key? key}) : super(key: key);

  @override
  State<Feed> createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  final FeedController feedController = Get.put(FeedController());
  late Future<List<PostModel>> posts;
  bool _isFirstBuild = true;
  bool _isProfessional =
     false;

  @override
  void initState() {
    super.initState();
    if (_isFirstBuild) {
      posts = feedController.getPosts();
      _isFirstBuild = false;
    }
    checkProfessionalStatus();
  }

  Future<void> checkProfessionalStatus() async {
    User? user = FirebaseAuth.instance.currentUser;
    String? uid = user?.uid;
    DocumentSnapshot<Map<String, dynamic>> userSnapshot =
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get();

    if (userSnapshot.exists) {
      String role = userSnapshot.data()?['role'] ?? '';
      setState(() {
        _isProfessional = role == 'Fitness Professional';
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      displacement: Get.height * 0.1,
      edgeOffset: Get.height * 0.1,
      color: Colors.amber,
      onRefresh: () async {
        setState(() {
          posts = feedController.getPosts();
        });
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            actions: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: GestureDetector(
                  onTap: () {
                    Get.to(const LiveSession(),
                        transition: Transition.cupertino);
                  },
                  child: Icon(Icons.live_tv, color: yellowDark),
                ),
              ),
            ],
          ),
          body: SingleChildScrollView(child: newFeed(posts)),
          floatingActionButton: _isProfessional
              ? Padding(
                  padding: const EdgeInsets.only(left: 10, bottom: 5),
                  child: FloatingActionButton(
                    backgroundColor: yellowColor,
                    shape: const CircleBorder(),
                    child: const Icon(Icons.add_to_photos_outlined),
                    onPressed: () {
                      Get.to(const NewPost(), transition: Transition.cupertino);
                    },
                  ),
                )
              : const SizedBox(),
        ),
      ),
    );
  }
}
