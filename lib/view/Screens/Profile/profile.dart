import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Widgets/options.dart';
import 'Widgets/status.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

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
            const _UserProfileInfo(),
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

class _UserProfileInfo extends StatelessWidget {
  const _UserProfileInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator(); // Show a loader while data is being fetched
        }

        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (!snapshot.hasData || !snapshot.data!.exists) {
          return const Text(
              'User data not found'); // Handle the case where user data doesn't exist
        }

        final userData = snapshot.data!.data() as Map<String, dynamic>;

        return Column(
          children: [
            SizedBox(
              height: Get.height * 0.16,
              width: Get.height * 0.16,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100000),
                // child: Image.asset('assets/images/trainer.jpg'),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100000),
                    border: Border.all(
                      color: Colors.grey,
                    ),
                  ),
                  child: const Icon(
                    Icons.camera_alt_outlined,
                    size: 32,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
            SizedBox(height: Get.height * 0.025),
            Text(
              userData['name'] ?? 'Name not found',
              style: GoogleFonts.poppins(
                fontSize: Get.height * 0.025,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: Get.height * 0.01),
            Text(
              userData['email'] ?? 'Email not found',
              style: GoogleFonts.aBeeZee(fontSize: Get.height * 0.02),
            ),
          ],
        );
      },
    );
  }
}
