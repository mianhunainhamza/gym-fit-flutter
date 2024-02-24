import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Future<void> refresh() {
      return Future.delayed(
        const Duration(
          seconds: 2,
        ),
      );
    }

    return Scaffold(
        body: RefreshIndicator(
          edgeOffset: 100,
          color: Colors.amber,
          onRefresh: refresh,
          child: SafeArea(
            child: SingleChildScrollView(
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(28),
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
                                style: GoogleFonts.poppins(fontSize: 22)),
                            const SizedBox(height: 5),
                            Text(
                              "Let's get workout.",
                              style: GoogleFonts.poppins(
                                fontSize: 22,
                                color: Colors.amber,
                                fontWeight: FontWeight.w700,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 55,
                          width: 55,
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
                    const SizedBox(height: 25),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 175,
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return Row(
                            children: [
                              Container(
                                width: 200,
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
                                              ),
                                            ),
                                            Text(
                                              "Hand Muscles",
                                              style: GoogleFonts.poppins(
                                                color: Colors.white,
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
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 15),
                            ],
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 36),
                    Text(
                      "Featured Trainers",
                      style: GoogleFonts.poppins(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 15),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 120,
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
                                    width: 85,
                                    height: 85,
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
                                  const SizedBox(height: 10),
                                  Text(
                                    "Areeb",
                                    style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(width: 15),
                            ],
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      "Popular Courses",
                      style: GoogleFonts.poppins(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 15),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 175,
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return Row(
                            children: [
                              Container(
                                width: 150,
                                decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  image: DecorationImage(
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
                                        const SizedBox(width: 15),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "6 weeks",
                                              style: GoogleFonts.poppins(
                                                color: Colors.white,
                                              ),
                                            ),
                                            Text(
                                              "Body Combat",
                                              style: GoogleFonts.poppins(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 15),
                            ],
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      "Latest Videos",
                      style: GoogleFonts.poppins(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 15),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 175,
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return Row(
                            children: [
                              Container(
                                width: 175,
                                decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  image: DecorationImage(
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
                                        const SizedBox(width: 15),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "6 weeks",
                                              style: GoogleFonts.poppins(
                                                color: Colors.white,
                                              ),
                                            ),
                                            Text(
                                              "Body Combat",
                                              style: GoogleFonts.poppins(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 15),
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
          decoration: BoxDecoration(
              border: Border(
                  top: BorderSide(color: Colors.black.withOpacity(0.5)))),
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: GNav(
              rippleColor:
                  Colors.amber.shade200, // tab button ripple color when pressed
              hoverColor: Colors.amber.shade400, // tab button hover color
              haptic: true, // haptic feedback
              tabBorderRadius: 15,
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
              iconSize: 24, // tab button icon size

              padding: const EdgeInsets.symmetric(
                  horizontal: 20, vertical: 5), // navigation bar padding
              tabs: const [
                GButton(
                  icon: LineIcons.home,
                  iconSize: 28,
                ),
                GButton(
                  icon: LineIcons.heart,
                  iconSize: 28,
                ),
                GButton(
                  icon: LineIcons.search,
                  iconSize: 28,
                ),
                GButton(
                  icon: LineIcons.user,
                  iconSize: 28,
                )
              ]),
        ));
  }
}
