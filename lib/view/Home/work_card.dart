import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class WorkCard extends StatelessWidget {
  const WorkCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 25, top: 10),
              child: SizedBox(
                width: Get.width,
                child: Text(
                  'LOSE WEIGHT',
                  style: GoogleFonts.poppins(
                    color: Colors.black.withOpacity(.4),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25, top: 10),
              child: SizedBox(
                width: Get.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Day 1',
                      style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: Get.height * .027,
                      ),
                    ),
                    Text(
                      'Full Body',
                      style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: Get.height * .027,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 25),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Row(
                      children: [
                        Icon(CupertinoIcons.clock),
                        SizedBox(width: 8),
                        Text('30 min'),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Row(
                      children: [
                        Icon(CupertinoIcons.flame,color: Colors.deepOrange,),
                        SizedBox(width: 8),
                        Text('450 Kal'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        // Image
        Positioned(
          right: 0,
          top: 0,
          bottom: 0,
          child: Container(
            width: Get.width / 2, // Adjust the width as needed
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/girl.png'),
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
