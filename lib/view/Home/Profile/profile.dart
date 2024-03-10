import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:softec_app_dev/utils/colors.dart';
import 'package:softec_app_dev/view/Home/Profile/Widgets/options.dart';
import 'package:softec_app_dev/view/Home/Profile/Widgets/status.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String username = "Loading...";
  String email = "Loading...";

  @override
  void initState() {
    super.initState();
    print('init');
    loadUserData();
  }

  Future<Map<String,dynamic>?> getUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
          .instance.collection('Users')
          .doc(user.uid).get();
      if (snapshot.exists) {
        //print(snapshot.data()?['name']);
        return snapshot.data();
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  Future<void> loadUserData() async {
    Map<String, dynamic>? userData = await getUserData();
    setState(() {
      username = userData?['name'];
      email = userData?['email'];
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: Get.height * 0.02),
            Center(
              child: Text(
                "Profile",
                style: GoogleFonts.poppins(
                  fontSize: Get.height * 0.03,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: Get.height * 0.03),
            Stack(
              children: [
                SizedBox(
                  height: Get.height * 0.16,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.asset('assets/images/trainer.jpg'),
                  ),
                ),
                Positioned(
                  right: 5,
                  bottom: 5,
                  child: Container(
                    height: Get.height * 0.04,
                    width: Get.width * 0.08,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(60),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.edit,
                        color: yellowColor,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: Get.height * 0.025),
            Text(
              username,
              style: GoogleFonts.poppins(
                fontSize: Get.height * 0.025,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: Get.height * 0.01),
            Text(
              email,
              style: GoogleFonts.aBeeZee(fontSize: Get.height * 0.02),
            ),
            SizedBox(height: Get.height * 0.03),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 25),
              child: SizedBox(
                height: Get.height * 0.13,
                child: const Status(),
              ),
            ),
            SizedBox(height: Get.height * 0.03),
            Padding(
              padding: const EdgeInsets.only(left: 23, right: 23),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Options(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
