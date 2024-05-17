import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:softec_app_dev/view/Screens/Work/work_card.dart';
import '../../../utils/colors.dart';

Widget buildWorkCard(
    fetchUserJoinedEvents,
    bool isJoined, String title, String type, String calories, String time, String body) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: yellowColor.withOpacity(Random().nextDouble()),
          ),
          height: 220,
          width: Get.width - 40,
          child: WorkCard(
            function: fetchUserJoinedEvents,
            isJoined: isJoined,
            title: title,
            type: type,
            calories: calories,
            time: time,
            body: body,
          ),
        ),
      ),
    ],
  );
}
Widget buildWorkCardSkeleton() {
  return Padding(
    padding: const EdgeInsets.all(20),
    child: Container(
      width: Get.width * 0.9,
      height: Get.height * 0.25,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.grey[200],
      ),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: const Center(
          child: SizedBox(
            width: 60,
            height: 60,
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    ),
  );
}