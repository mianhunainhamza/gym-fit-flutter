import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:softec_app_dev/view/onboard_page.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              Get.to(const OnBoardPage(),transition: Transition.cupertino);
            },
            child: const Icon(Icons.arrow_back_ios_new)),
        automaticallyImplyLeading: false,
      ),
      //body part
      body: Stack(
        children: [
        ],
      ),
    );
  }
}
