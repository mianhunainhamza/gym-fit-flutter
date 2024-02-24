import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:softec_app_dev/view/signup_page.dart';

class OnBoardPage extends StatelessWidget {
  const OnBoardPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 40),
                child: SizedBox(
                  width: size.width,
                  height: 200,
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: size.height * 0.055,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromRGBO(253, 220, 138, 1),
                      ),
                      children: [
                        const TextSpan(
                          text: 'YOU READY TO ',
                        ),
                        TextSpan(
                          text: 'GET FIT',
                          style: TextStyle(color: Colors.black.withOpacity(.7)),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          // Image
          SizedBox(
            width: size.width,
            height: size.height - 300,
            child: Image.asset('assets/images/girl.png', fit: BoxFit.fitHeight,filterQuality: FilterQuality.high,),
          ),

          // Buttons
          Positioned(
            left: 60, // Adjust position according to your preference
            right: 60, // Adjust position according to your preference
            bottom: 20,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: size.width,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Container(
                    // width: (size.width - 200) / 2,
                    height: 50,
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(253, 215, 138, 1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        'L O G I N',
                        style: GoogleFonts.poppins(
                            fontSize: size.height * .026,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(const SignUpPage(),transition: Transition.cupertino);
                  },
                  child: Container(
                    // width: (size.width - 200) / 2,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Center(
                      child: Text(
                        "Don't Have an account? Register Now",
                        style: GoogleFonts.aBeeZee(
                            fontSize: size.height * .015,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
