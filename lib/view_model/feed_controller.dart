import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../model/post.dart';

class FeedController extends GetxController {
  RxBool checkUser = false.obs;

  final CollectionReference postsRef =
  FirebaseFirestore.instance.collection('posts');
  final CollectionReference userRef =
  FirebaseFirestore.instance.collection('users');

  void uploadPost(PostModel post) {
    try {
      // Set uploading status to true
      uploading = true;

      // Upload post to Firestore
      postsRef.add(post.toJson());

      // Set uploading status to false after upload completes
      uploading = false;
    } catch (e) {
      // Set uploading status to false if upload fails
      uploading = false;
      throw e; // Re-throw the error for handling in UI
    }
  }


  Future<void> userType() async {
    try {
      User? currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        DocumentSnapshot userSnapshot =
        await userRef.doc(currentUser.uid).get();
        if (userSnapshot.exists) {
          Map<String, dynamic> userData =
          userSnapshot.data() as Map<String, dynamic>;
          String? role = userData['role'];
          if (role == 'Fitness Professional') {
            checkUser = true.obs;
            print(checkUser);
          }
        }
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<List<PostModel>> getPosts() async {
    List<PostModel> posts = [];

    try {
      QuerySnapshot querySnapshot = await postsRef.get();
      for (var doc in querySnapshot.docs) {
        PostModel post = PostModel(
            userName: doc['userName'],
            title: doc['title'],
            desc: doc['desc'],
            email: doc['email'],
            imageUrl: doc['imageUrl'],
            time: doc['time']);
        posts.add(post);
      }
    } catch (e) {
      print("Error: $e");
    }

    return posts;
  }

  @override
  void onInit() {
    super.onInit();
    userType();
    getPosts();
    print("Feed Controller");
  }

  // Properties to track uploading status and progress
  RxBool _uploading = false.obs;
  double _uploadProgress = 0.0;

  bool get uploading => _uploading.value;

  set uploading(bool value) => _uploading.value = value;

  double get uploadProgress => _uploadProgress;

  set uploadProgress(double value) => _uploadProgress = value;
}
