import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Authentication/login_screen.dart';
import '../Features//help.dart';
import '../Features/notifications.dart';
import '../Features/setttings.dart';
import '../Features/statistics.dart';

class Options extends StatelessWidget {
  const Options({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      children: [
        ListTile(
          onTap: (){
            Get.to(const Statistics(),transition: Transition.cupertino);
          },
          leading: const Icon(CupertinoIcons.person),
          trailing: const Icon(Icons.arrow_forward_ios_outlined),
          title: Text('Statistics',style: GoogleFonts.aBeeZee(),),
        ),
        ListTile(
          onTap: (){
            Get.to(const Settings(),transition: Transition.cupertino);
          },
          leading: const Icon(CupertinoIcons.settings),
          trailing: const Icon(Icons.arrow_forward_ios_outlined),
          title: Text('General Settings',style: GoogleFonts.aBeeZee(),),
        ),
        ListTile(
          onTap: (){
            Get.to(const NotificationSettings(),transition: Transition.cupertino);
          },
          leading: const Icon(Icons.notifications_none_outlined),
          trailing: const Icon(Icons.arrow_forward_ios_outlined),
          title: Text('Notifications',style: GoogleFonts.aBeeZee(),),
        ),
        ListTile(
          onTap: (){
            Get.to(const Help(),transition: Transition.cupertino);
          },
          leading: const Icon(Icons.help_outline),
          trailing: const Icon(Icons.arrow_forward_ios_outlined),
          title: Text('Terms and Conditions',style: GoogleFonts.aBeeZee(),),
        ),
        ListTile(
          onTap: (){
            logOut(context);
          },
          leading: const Icon(CupertinoIcons.power),
          trailing: const Icon(Icons.arrow_forward_ios_outlined),
          title: Text('Log Out',style: GoogleFonts.aBeeZee(),),
        )
      ],
    );
  }

  void logOut(BuildContext context) {
    showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text("Sure want to logout?", style: GoogleFonts.poppins(fontSize: 17)),
          actions: <Widget>[
            CupertinoDialogAction(
              child: Text('Cancel', style: GoogleFonts.poppins(color: Colors.black)),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            CupertinoDialogAction(
              child: Text('OK', style: GoogleFonts.poppins(color: Colors.red)),
              onPressed: () async {
                FirebaseAuth auth = FirebaseAuth.instance;
                await auth.signOut();

                // Clear the login state
                final prefs = await SharedPreferences.getInstance();
                await prefs.setBool('isLoggedIn', false);

                // Navigate to login screen
                Get.offAll(() => LoginScreen(), transition: Transition.cupertino);
              },
            ),
          ],
        );
      },
    );
  }
}
