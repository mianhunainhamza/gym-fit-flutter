import 'package:flutter/material.dart';

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
              //
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
                        color: const Color.fromRGBO(253, 220, 138, 1), // Set default color
                      ),
                      children: [
                        const TextSpan(
                          text: 'YOU READY TO ',
                        ),
                        TextSpan(
                          text: 'GET FIT',
                          style: TextStyle(color: Colors.black.withOpacity(.7)), // Set black color for "GET FIT"
                        ),
                      ],
                    ),
                  ),
                ),
              ),

            ],
          ),
          //image
          Container(
            decoration: const BoxDecoration(
            ),
              width: size.width,
              height: size.height-300,
              child: Image.asset('assets/images/girl.png',fit: BoxFit.fitHeight,)),
        ],
      ),
    );
  }
}
