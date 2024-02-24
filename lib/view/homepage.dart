import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: RefreshIndicator(
          displacement: Get.height * 0.1,
          edgeOffset: Get.height * 0.1,
          color: Colors.amber,
          onRefresh: refresh,
          child: SafeArea(
            child: SingleChildScrollView(
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(Get.width * 0.06),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Hello dude",
                                style: GoogleFonts.poppins(
                                    fontSize: Get.width * 0.088)),
                            const SizedBox(height: 5),
                            Text(
                              "Let's get workout.",
                              style: GoogleFonts.poppins(
                                fontSize: Get.width * 0.07,
                                color: Colors.amber,
                                fontWeight: FontWeight.w700,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: Get.width * 0.15,
                          width: Get.width * 0.15,
                          child: ClipRRect(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(20000),
                            ),
                            child: Image.asset(
                              "assets/images/dp.jpg",
                              filterQuality: FilterQuality.high,
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: Get.height * 0.03),
                    SizedBox(
                      width: Get.width,
                      height: Get.height * 0.2,
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return Row(
                            children: [
                              Container(
                                width: Get.width * 0.6,
                                decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  image: DecorationImage(
                                    filterQuality: FilterQuality.high,
                                    fit: BoxFit.fitHeight,
                                    image: AssetImage("assets/images/bg.jpg"),
                                  ),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "6 weeks",
                                              style: GoogleFonts.poppins(
                                                color: Colors.white,
                                                fontSize: Get.width * 0.035,
                                              ),
                                            ),
                                            Text(
                                              "Hand Muscles",
                                              style: GoogleFonts.poppins(
                                                color: Colors.white,
                                                fontSize: Get.width * 0.035,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Text(
                                              "\$12.22",
                                              style: GoogleFonts.poppins(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: Get.width * 0.035),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: Get.height * 0.015),
                                  ],
                                ),
                              ),
                              SizedBox(width: Get.width * 0.03),
                            ],
                          );
                        },
                      ),
                    ),
                    SizedBox(height: Get.height * 0.04),
                    Text(
                      "Featured Trainers",
                      style: GoogleFonts.poppins(
                        fontSize: Get.width * 0.06,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SizedBox(height: Get.height * 0.015),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: Get.height * 0.14,
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: 7,
                        itemBuilder: (context, index) {
                          return Row(
                            children: [
                              Column(
                                children: [
                                  Container(
                                    width: Get.width * 0.21,
                                    height: Get.width * 0.21,
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(2000)),
                                      image: DecorationImage(
                                        filterQuality: FilterQuality.high,
                                        fit: BoxFit.fitHeight,
                                        image: AssetImage(
                                            "assets/images/trainer.jpg"),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: Get.height * 0.015),
                                  Text(
                                    "Areeb",
                                    style: GoogleFonts.poppins(
                                      fontSize: Get.width * 0.04,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(width: Get.width * 0.025),
                            ],
                          );
                        },
                      ),
                    ),
                    SizedBox(height: Get.height * 0.025),
                    Text(
                      "Popular Courses",
                      style: GoogleFonts.poppins(
                        fontSize: Get.width * 0.06,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SizedBox(height: Get.height * 0.015),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: Get.height * 0.22,
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return Row(
                            children: [
                              Container(
                                width: Get.width * 0.35,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(Get.width * 0.04)),
                                  image: const DecorationImage(
                                    filterQuality: FilterQuality.high,
                                    fit: BoxFit.fitHeight,
                                    image:
                                        AssetImage("assets/images/course.jpg"),
                                  ),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        SizedBox(width: Get.width * 0.04),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "6 weeks",
                                              style: GoogleFonts.poppins(
                                                color: Colors.white,
                                                fontSize: Get.width * 0.035,
                                              ),
                                            ),
                                            Text(
                                              "Body Combat",
                                              style: GoogleFonts.poppins(
                                                color: Colors.white,
                                                fontSize: Get.width * 0.035,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: Get.height * 0.015),
                                  ],
                                ),
                              ),
                              SizedBox(width: Get.width * 0.035),
                            ],
                          );
                        },
                      ),
                    ),
                    SizedBox(height: Get.height * 0.03),
                    Text(
                      "Latest Videos",
                      style: GoogleFonts.poppins(
                        fontSize: Get.width * 0.06,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SizedBox(height: Get.height * 0.015),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: Get.height * 0.22,
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return Row(
                            children: [
                              Container(
                                width: Get.width * 0.45,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(Get.width * 0.04)),
                                  image: const DecorationImage(
                                    filterQuality: FilterQuality.high,
                                    fit: BoxFit.cover,
                                    image:
                                        AssetImage("assets/images/video.jpg"),
                                  ),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        SizedBox(width: Get.width * 0.035),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "2 weeks",
                                              style: GoogleFonts.poppins(
                                                color: Colors.white,
                                                fontSize: Get.width * 0.035,
                                              ),
                                            ),
                                            Text(
                                              "Zumba Fitness",
                                              style: GoogleFonts.poppins(
                                                color: Colors.white,
                                                fontSize: Get.width * 0.035,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: Get.height * 0.015),
                                  ],
                                ),
                              ),
                              SizedBox(width: Get.width * 0.035),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        bottomNavigationBar: Container(
          // decoration: BoxDecoration(
          //     border: Border(
          //         top: BorderSide(color: Colors.black.withOpacity(0.5)))),
          padding: EdgeInsets.fromLTRB(Get.width * 0.05, Get.width * 0.015,
              Get.width * 0.05, Get.width * 0.05),
          child: GNav(
              rippleColor:
                  Colors.amber.shade200, // tab button ripple color when pressed
              hoverColor: Colors.amber.shade400, // tab button hover color
              haptic: true, // haptic feedback
              tabBorderRadius: Get.width * 0.8,
              // tabActiveBorder: Border.all(
              //     color: Colors.amber, width: 1), // tab button border
              // tabBorder:
              //     Border.all(color: Colors.grey, width: 1), // tab button border
              // tabShadow: [
              //   BoxShadow(color: Colors.grey.withOpacity(0.5), blurRadius: 8)
              // ], // tab button shadow
              curve: Curves.fastOutSlowIn, // tab animation curves
              duration:
                  const Duration(milliseconds: 500), // tab animation duration
              gap: 8, // the tab button gap between icon and text
              color: Colors.black.withOpacity(0.3), // unselected icon color
              activeColor: Colors.black, // selected icon and text color
              iconSize: Get.width * 0.08, // tab button icon size

              padding: const EdgeInsets.symmetric(
                  horizontal: 20, vertical: 5), // navigation bar padding
              tabs: const [
                GButton(
                  icon: LineIcons.home,
                ),
                GButton(
                  icon: LineIcons.trophy,
                ),
                GButton(
                  icon: LineIcons.search,
                ),
                GButton(
                  icon: LineIcons.user,
                )
              ]),
        ));
  }
}
