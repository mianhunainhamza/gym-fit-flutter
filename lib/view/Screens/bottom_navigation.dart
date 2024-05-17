import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:softec_app_dev/utils/colors.dart';
import 'package:softec_app_dev/view/Screens/Work/events.dart';
import 'Chat/chat.dart';
import 'Home/Feed/feed.dart';
import 'Home/homepage.dart';
import 'Profile/profile.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int selectedIndex = 0;

  List<Widget> list = [
    const HomePage(),
    const Events(),
    const Chat(),
    const Feed(),
    const Profile()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: list.elementAt(selectedIndex),
        ),
        bottomNavigationBar: Container(
          padding: EdgeInsets.fromLTRB(Get.width * 0.05, Get.width * 0.015,
              Get.width * 0.05, Get.width * 0.05),
          child: GNav(
            rippleColor: Colors.amber.shade200,
            hoverColor: Colors.amber.shade400,
            haptic: true,
            tabBorderRadius: Get.width * 0.8,
            curve: Curves.fastOutSlowIn,
            duration: const Duration(milliseconds: 500),
            gap: 8,
            color: Colors.black.withOpacity(0.3),
            activeColor: yellowDark,
            iconSize: Get.width * 0.07,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            tabs: const [
              GButton(
                icon: LineIcons.home,
              ),
              GButton(
                icon: LineIcons.dumbbell,
              ),
              GButton(
                icon: Icons.people_outline,
              ),
              GButton(
                icon: LineIcons.newspaper,
              ),
              GButton(
                icon: LineIcons.user,
              ),
            ],
            selectedIndex: selectedIndex,
            onTabChange: (index) {
              setState(() {
                selectedIndex = index;
              });
            },
          ),
        ));
  }
}
