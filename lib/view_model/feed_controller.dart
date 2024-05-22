import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:softec_app_dev/Model/user_model.dart';

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
          time: doc['time'],
          userProfilePic: doc['userProfilePic'],
        );

        posts.add(post);
      }
    } catch (e) {
      print("Error: $e");
    }

    return posts;
  }

  Future<List<PostModel>> getUserPosts(String userEmail) async {
    FirebaseAuth auth = FirebaseAuth.instance;

    List<PostModel> posts = [];

    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('posts')
          .where('email', isEqualTo: auth.currentUser!.email.toString())
          .get();
      for (var doc in querySnapshot.docs) {
        PostModel post = PostModel(
          userName: doc['userName'],
          title: doc['title'],
          desc: doc['desc'],
          email: doc['email'],
          imageUrl: doc['imageUrl'],
          time: doc['time'],
          userProfilePic: doc['userProfilePic'],
        );

        posts.add(post);
      }
    } catch (e) {
      print("Error: $e");
    }

    return posts;
  }

  Future<List<UserModel>> getUsers() async {
    final CollectionReference usersRef =
        FirebaseFirestore.instance.collection('users');
    List<UserModel> users = [];

    try {
      QuerySnapshot querySnapshot = await usersRef.get();
      for (var doc in querySnapshot.docs) {
        UserModel user = UserModel(
          username: doc['name'],
          email: doc['title'],
          pass: doc['desc'],
          role: doc['email'],
          profilePicUrl: doc['profilePicUrl'],
        );
        users.add(user);
      }
    } catch (e) {
      print("Error: $e");
    }

    return users;
  }

  @override
  void onInit() {
    super.onInit();
    userType();
    getPosts();
    getUsers();
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
