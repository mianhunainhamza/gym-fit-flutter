import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:softec_app_dev/utils/colors.dart';

class Status extends StatelessWidget {
  const Status({super.key});

  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(CupertinoIcons.timer_fill,color: yellowDark,size: Get.height*0.025),
            Text('2h 30 min',style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 16 ),),
            Text('Total Time',style: GoogleFonts.aBeeZee(fontSize: 15 ),)
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(LineIcons.fire,color: yellowDark,size: Get.height*0.025),
            Text('7200',style: GoogleFonts.poppins(fontWeight: FontWeight.bold,fontSize: 16),),
            Text('Burned',style: GoogleFonts.aBeeZee(fontSize: 15 ),)
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(Icons.done_outline_sharp,color: yellowDark,size: Get.height*0.025,),
            Text('2',style: GoogleFonts.poppins(fontWeight: FontWeight.bold,fontSize: 16),),
            Text('Done',style: GoogleFonts.aBeeZee(fontSize: 15 ),)
          ],
        )
      ],
    );
  }
}
