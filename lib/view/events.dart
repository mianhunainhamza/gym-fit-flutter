import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:softec_app_dev/utils/colors.dart';

class Events extends StatelessWidget {
  const Events({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text("Workout",style:
          GoogleFonts.poppins(fontSize: Get.height *.03,fontWeight: FontWeight.w600),),
        centerTitle: true,
      ),
      body: Column(
        children: [
            Padding(
              padding: const EdgeInsets.only(left: 20,right: 20,top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Workout Plan',style:
              GoogleFonts.poppins(fontSize: Get.height *.02,fontWeight: FontWeight.w600),),
                  Text('See more',style:
                    GoogleFonts.poppins(fontSize: Get.height *.018,fontWeight: FontWeight.w600,color: yellowColor),),
                ],
              ),
            )
        ],
      ),
    );
  }
}
