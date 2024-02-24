import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';

class Search extends StatelessWidget {
  const Search({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 36),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: Get.width * 0.12,
                      width: Get.width * 0.12,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20000),
                        image: const DecorationImage(
                          image: AssetImage("assets/images/dp.jpg"),
                        ),
                      ),
                    ),
                    SizedBox(width: Get.width * 0.02),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Veronica",
                              style: GoogleFonts.poppins(
                                fontSize: Get.width * 0.04,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(width: 5),
                            Text(
                              "@veronica",
                              style: GoogleFonts.poppins(
                                fontSize: Get.width * 0.035,
                                fontWeight: FontWeight.w300,
                                color: Colors.grey,
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: Get.height * 0.01),
                        Text(
                          "My house is complete with stylish furniture \nthat adds a touch of comfort.",
                          style: GoogleFonts.poppins(
                            fontSize: Get.width * 0.036,
                          ),
                        ),
                        SizedBox(height: Get.height * 0.02),
                        Container(
                          alignment: Alignment.centerLeft,
                          height: Get.height * 0.25,
                          width: Get.width * 0.7,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                            image: DecorationImage(
                              filterQuality: FilterQuality.high,
                              fit: BoxFit.cover,
                              image: AssetImage("assets/images/furniture.jpg"),
                            ),
                          ),
                        ),
                        SizedBox(height: Get.height * 0.02),
                        Text(
                          "8m",
                          style: GoogleFonts.poppins(
                            color: Colors.grey.withOpacity(0.8),
                            fontSize: Get.width * 0.04,
                          ),
                        ),
                        SizedBox(height: Get.height * 0.015),
                        Container(
                          width: Get.width * 0.7,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const Icon(LineIcons.thumbsUp),
                                  SizedBox(width: Get.width * 0.02),
                                  Text(
                                    "23",
                                    style: GoogleFonts.poppins(
                                      color: Colors.grey.withOpacity(0.7),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const Icon(Icons.chat),
                                  SizedBox(width: Get.width * 0.02),
                                  Text(
                                    "1",
                                    style: GoogleFonts.poppins(
                                        color: Colors.grey.withOpacity(0.7)),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const Icon(LineIcons.thumbsUp),
                                  SizedBox(width: Get.width * 0.02),
                                  Text(
                                    "16",
                                    style: GoogleFonts.poppins(
                                        color: Colors.grey.withOpacity(0.7)),
                                  ),
                                ],
                              ),
                              const Icon(LineIcons.share),
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              const Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
