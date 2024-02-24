import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:softec_app_dev/view/Home/achivements.dart';
import 'package:softec_app_dev/view/Home/homepage.dart';
import 'package:softec_app_dev/view/Home/profile.dart';
import 'package:softec_app_dev/view/Home/search.dart';

class BottomNavigation extends StatefulWidget {
  BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int selectedIndex = 0;

  List<Widget> list = [
    const HomePage(),
    const Achievements(),
    const Search(),
    const Profile()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Center(
        child: list.elementAt(selectedIndex),
      ),
      bottomNavigationBar: Container(
        // decoration: BoxDecoration(
        //     border: Border(
        //         top: BorderSide(color: Colors.black.withOpacity(0.5)))),
        padding: EdgeInsets.fromLTRB(Get.width * 0.05, Get.width * 0.015,
            Get.width * 0.05, Get.width * 0.05),
        child: GNav(
          rippleColor:
          Colors.amber.shade200, // tab button ripple color when pressed
          hoverColor: Colors.amber.shade400, // tab button hover color
          haptic: true, // haptic feedback
          tabBorderRadius: Get.width * 0.8,
          // tabActiveBorder: Border.all(
          //     color: Colors.amber, width: 1), // tab button border
          // tabBorder:
          //     Border.all(color: Colors.grey, width: 1), // tab button border
          // tabShadow: [
          //   BoxShadow(color: Colors.grey.withOpacity(0.5), blurRadius: 8)
          // ], // tab button shadow
          curve: Curves.fastOutSlowIn, // tab animation curves
          duration:
          const Duration(milliseconds: 500), // tab animation duration
          gap: 8, // the tab button gap between icon and text
          color: Colors.black.withOpacity(0.3), // unselected icon color
          activeColor: Colors.black, // selected icon and text color
          iconSize: Get.width * 0.08, // tab button icon size

          padding: const EdgeInsets.symmetric(
              horizontal: 20, vertical: 5), // navigation bar padding
          tabs: const [
            GButton(
              icon: LineIcons.home,
            ),
            GButton(
              icon: LineIcons.trophy,
            ),
            GButton(
              icon: LineIcons.search,
            ),
            GButton(
              icon: LineIcons.user,
            ),

          ],
          selectedIndex: selectedIndex,
          onTabChange: (index){
            setState(() {
              selectedIndex = index;
            });
          },
        ),
      )
    );

  }
}