import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:softec_app_dev/Model/user_model.dart';

Future<List<UserModel>> fetchUsers() async {
  List<UserModel> users = [];

  final usersSnapshot =
      await FirebaseFirestore.instance.collection('users').get();

  for (var userDoc in usersSnapshot.docs) {
    final userData = userDoc.data();
    // if (userData['joinedUsers'] != null &&
    //     userData['joinedUsers'].contains()) {

    // } else {

    // }
    UserModel user = UserModel(
      username: userData['name'],
      pass: userData['pass'],
      email: userData['email'],
      role: userData['role'],
      profilePicUrl: userData['profilePicUrl'],
    );

    users.add(user);
  }

  return users;
}
