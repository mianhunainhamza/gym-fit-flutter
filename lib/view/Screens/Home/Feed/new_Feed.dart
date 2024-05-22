import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:softec_app_dev/Model/user_model.dart';
import '../../../../model/post.dart';
import 'image_preview.dart';

Widget newFeed(Future<List<PostModel>> posts, List<UserModel> users) {
  return FutureBuilder<List<PostModel>>(
    future: posts,
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: SizedBox(
                width: Get.width,
                height: Get.height,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: Get.width * 0.12,
                      width: Get.width * 0.12,
                      child: Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: CircleAvatar(
                          backgroundColor: Colors.grey[200],
                        ),
                      ),
                    ),
                    SizedBox(width: Get.width * 0.015),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Shimmer.fromColors(
                              baseColor: Colors.grey[300]!,
                              highlightColor: Colors.grey[100]!,
                              child: Text(
                                'Name',
                                style: GoogleFonts.poppins(
                                  fontSize: Get.width * 0.04,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Shimmer.fromColors(
                              baseColor: Colors.grey[300]!,
                              highlightColor: Colors.grey[100]!,
                              child: Text(
                                '@username',
                                style: GoogleFonts.poppins(
                                  fontSize: Get.width * 0.035,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.grey,
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: Get.height * 0.008),
                        Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Text(
                            'Description...',
                            style: GoogleFonts.poppins(
                              fontSize: Get.width * 0.032,
                            ),
                          ),
                        ),
                        SizedBox(height: Get.height * 0.015),
                        Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                            height: Get.height * 0.25,
                            width: Get.width * 0.75,
                            color: Colors.grey[200],
                          ),
                        ),
                        SizedBox(height: Get.height * 0.015),
                        Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Text(
                            '12:00 AM 1/1/2000',
                            style: GoogleFonts.poppins(
                              color: Colors.grey.withOpacity(0.8),
                              fontSize: Get.width * 0.035,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                )),
          ),
        );
      } else if (snapshot.hasError) {
        return Center(child: Text('Error: ${snapshot.error}'));
      } else {
        List<PostModel> postList = snapshot.data!;
        postList.sort((a, b) => b.time.compareTo(a.time));
        if (postList.isEmpty) {
          return const Center(
            child: Text(
              'No posts available.',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        }

        return Column(
          children: postList.map((post) {
            return Column(
              children: [
                Container(
                  width: Get.width,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: Get.width * 0.12,
                        width: Get.width * 0.12,
                        child: Container(
                          decoration: BoxDecoration(
                            // border: Border.all(
                            //   color: Colors.grey,
                            // ),
                            borderRadius: BorderRadius.circular(10000),
                          ),
                          child: post.userProfilePic.toString().isEmpty
                              ? const Icon(Icons.person)
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(10000),
                                  child: Image.network(
                                    post.userProfilePic,
                                    filterQuality: FilterQuality.high,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                        ),
                      ),
                      SizedBox(width: Get.width * 0.015),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                post.userName,
                                style: GoogleFonts.poppins(
                                  fontSize: Get.width * 0.04,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                "@${post.email.split('@').first}",
                                style: GoogleFonts.poppins(
                                  fontSize: Get.width * 0.035,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.grey,
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: Get.height * 0.008),
                          Text(
                            post.desc,
                            style: GoogleFonts.poppins(
                              fontSize: Get.width * 0.032,
                            ),
                          ),
                          SizedBox(height: Get.height * 0.015),
                          if (post.imageUrl.isNotEmpty)
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                    builder: (c) => ImagePreview(
                                      imageUrl: post.imageUrl,
                                      tag: post.imageUrl,
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                alignment: Alignment.centerLeft,
                                height: Get.height * 0.25,
                                width: Get.width * 0.75,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Hero(
                                  tag: post.imageUrl,
                                  child: Image.network(
                                    post.imageUrl,
                                  ),
                                ),
                              ),
                            )
                          else
                            Container(),
                          SizedBox(height: Get.height * 0.015),
                          Text(
                            post.time,
                            style: GoogleFonts.poppins(
                              color: Colors.grey.withOpacity(0.8),
                              fontSize: Get.width * 0.035,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            );
          }).toList(),
        );
      }
    },
  );
}
