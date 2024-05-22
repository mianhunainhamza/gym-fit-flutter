// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:softec_app_dev/utils/colors.dart';
import '../../../utils/utils.dart';
import 'Widgets/options.dart';
import 'Widgets/status.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
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
                padding: const EdgeInsets.only(left: 23, right: 23, bottom: 18),
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
      ),
    );
  }
}

class _UserProfileInfo extends StatefulWidget {
  const _UserProfileInfo({Key? key}) : super(key: key);

  @override
  State<_UserProfileInfo> createState() => _UserProfileInfoState();
}

class _UserProfileInfoState extends State<_UserProfileInfo> {
  File? image;
  final imagePicker = ImagePicker();

  final firestore = FirebaseFirestore.instance;
  final storage = FirebaseStorage.instance;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .snapshots(),
      builder: (context, snapshot) {
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
              height: Get.height * 0.14,
              width: Get.height * 0.14,
              child: ClipRRect(
                // borderRadius: BorderRadius.circular(100000),
                // child: Image.asset('assets/images/trainer.jpg'),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      pickGalleryImage();
                      uploadProfilePic();
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100000),
                      border: Border.all(
                        color: Colors.grey,
                      ),
                    ),
                    child: userData['profilePicUrl'].toString().isNotEmpty
                        ? Image.network(
                            userData['profilePicUrl'],
                            fit: BoxFit.cover,
                            filterQuality: FilterQuality.high,
                          )
                        : const Icon(
                            Icons.add_a_photo_rounded,
                            size: 28,
                          ),
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

  Future pickGalleryImage() async {
    final pickedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedImage != null) {
        image = File(pickedImage.path);
        Utils().showMessage(
            context, "Image picked", Theme.of(context).colorScheme.secondary);
      } else {
        Utils().showMessage(context, "No image was picked",
            Theme.of(context).colorScheme.error);
      }
    });
  }

  void uploadProfilePic() async {
    if (image != null) {
      try {
        final userId = FirebaseAuth.instance.currentUser!.uid;
        final storageRef = storage.ref('/ProfileImages/$userId.jpg');

        // Attempt to delete the existing image, if it exists
        try {
          await storageRef.delete();
        } catch (e) {
          // If the image does not exist, we ignore the error and continue
          print('No existing image to delete, or another error occurred: $e');
        }

        // Upload the new image
        final uploadTask = storageRef.putFile(image!.absolute);

        Future.value(uploadTask).then((value) async {
          var newUrl = await storageRef.getDownloadURL();

          await firestore.collection('users').doc(userId).update({
            'profilePicUrl': newUrl,
          }).then((value) {
            Utils().showMessage(
              context,
              "Profile picture updated.",
              Colors.green,
            );
          }).onError((error, stackTrace) {
            Utils().showMessage(
                context,
                error.toString(),
                Theme.of(context).colorScheme.error
            );
          });
        }).onError((error, stackTrace) {
          Utils().showMessage(
              context,
              error.toString(),
              Theme.of(context).colorScheme.error
          );
        });
      } catch (e) {
        Utils().showMessage(
          context,
          "Sorry. We can't update your profile picture at the moment.",
          Theme.of(context).colorScheme.error,
        );
      }
    } else {
      Utils().showMessage(
          context,
          "Please select an image",
          Theme.of(context).colorScheme.error
      );
    }
  }

}
