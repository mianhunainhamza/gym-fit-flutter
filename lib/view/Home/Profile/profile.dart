import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:softec_app_dev/utils/colors.dart';
import 'package:softec_app_dev/view/Home/Profile/Widgets/options.dart';
import 'package:softec_app_dev/view/Home/Profile/Widgets/status.dart';

class Profile extends StatelessWidget {
  const Profile ({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   elevation: 0.0,
      //   automaticallyImplyLeading: false,
      // ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: Get.height*0.02),
            Center(
              child: Text("Profile", style: GoogleFonts.poppins(
                  fontSize:Get.height*0.03,
                  fontWeight: FontWeight.bold
              ),),
            ),
              SizedBox(height: Get.height*0.03),
              Stack(
              children: [
               SizedBox(
                  height: Get.height * 0.16,
                 child:  ClipRRect(
                   borderRadius: BorderRadius.circular(100),
                   child: Image.asset('assets/images/trainer.jpg'),

                 ),
               ),

                Positioned(
                  right: 5,
                  bottom: 5,
                  child: Container(
                    height: Get.height * 0.04,
                    width: Get.width * 0.08,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(60)
                      ),
                      child: Center(child: Icon(Icons.edit,color: yellowColor,size: 20,))
                  ),

                ),

              ],
            ),
            SizedBox(height: Get.height*0.025),
            Text('UserName',
              style: GoogleFonts.poppins(fontSize: Get.height * 0.025, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: Get.height*0.01),
            Text('email',style: GoogleFonts.aBeeZee(fontSize: Get.height*0.02),),
            SizedBox(height: Get.height*0.03),
             Padding(
              padding: const EdgeInsets.only(left: 10,right: 25),
              child: SizedBox(
                  height: Get.height * 0.13,
                  child: const Status()),
            ),

            SizedBox(height: Get.height * 0.03),
            Padding(
              padding: const EdgeInsets.only(left: 23,right: 23),
              child: Container(
                  decoration:  BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(20)
                  ),
                  child: const Options()),
            )

          ],
        ),
      ),
    );
  }
}
