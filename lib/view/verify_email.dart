import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:softec_app_dev/utils/colors.dart';
import 'package:softec_app_dev/view/Home/bottom_navigation.dart';

class VerifyEmailPage extends StatefulWidget {
  final String email;

  const VerifyEmailPage({
    Key? key,
    required this.email,
  }) : super(key: key);

  @override
  State<VerifyEmailPage> createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  @override
  Widget build(BuildContext context) {
    var mediaQuerySize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        // title: Text(
        //   'Verify Email',
        //   style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        // ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.5,
              child: Lottie.asset('assets/animations/reset.json'),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * .8,
              child: Text(
                'An email has been sent to ${widget.email}. Please verify your email to continue.',
                style: const TextStyle(fontSize: 15,fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            InkWell(
              onTap: () {
                sendVerification();
              },
              child: Container(
                decoration: BoxDecoration(
                  color: yellowColor,
                  borderRadius: BorderRadius.circular(15),
                ),
                alignment: Alignment.center,
                height: mediaQuerySize.width * 0.13,
                width: mediaQuerySize.width * 0.7,
                child:const Text(
                  "Resend Verification Email",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        backgroundColor: yellowColor,
        onPressed:()
        {
          Get.offAll(BottomNavigation(),transition: Transition.cupertino);
        },
      child: const Icon(Icons.login,color: Colors.black,),),
    );
  }
  Future<void> sendVerification() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null && !user.emailVerified) {
      try {
        await user.sendEmailVerification();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              "Email Sent",
              style: TextStyle(color: Colors.black),
            ),
            backgroundColor: Colors.white,
          ),
        );
      } catch (e)
      {
        print("Error sending verification email: $e");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              "Error sending verification email",
              style: TextStyle(color: Colors.black),
            ),
            backgroundColor: Colors.white,
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
         const SnackBar(
          content: Text(
            "User is already verified",
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
        ),
      );
    }
  }

}
