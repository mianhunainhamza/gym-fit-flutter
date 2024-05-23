import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../model/post.dart';
import 'image_preview.dart';

Widget newFeed(Future<List<PostModel>> posts) {
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
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.width * 0.12,
                    width: MediaQuery.of(context).size.width * 0.12,
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: CircleAvatar(
                        backgroundColor: Colors.grey[200],
                      ),
                    ),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.015),
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
                                fontSize: MediaQuery.of(context).size.width * 0.04,
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
                                fontSize: MediaQuery.of(context).size.width * 0.035,
                                fontWeight: FontWeight.w300,
                                color: Colors.grey,
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.008),
                      Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Text(
                          'Description...',
                          style: GoogleFonts.poppins(
                            fontSize: MediaQuery.of(context).size.width * 0.032,
                          ),
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.015),
                      Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.25,
                          width: MediaQuery.of(context).size.width * 0.75,
                          color: Colors.grey[200],
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.015),
                      Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Text(
                          '12:00 AM 1/1/2000',
                          style: GoogleFonts.poppins(
                            color: Colors.grey.withOpacity(0.8),
                            fontSize: MediaQuery.of(context).size.width * 0.035,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
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
            return Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.width * 0.12,
                    width: MediaQuery.of(context).size.width * 0.12,
                    child: Container(
                      decoration: BoxDecoration(
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
                  SizedBox(width: MediaQuery.of(context).size.width * 0.015),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Flexible(
                              child: Text(
                                post.userName,
                                style: GoogleFonts.poppins(
                                  fontSize: MediaQuery.of(context).size.width * 0.04,
                                  fontWeight: FontWeight.w500,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Flexible(
                              child: Text(
                                "@${post.email.split('@').first}",
                                style: GoogleFonts.poppins(
                                  fontSize: MediaQuery.of(context).size.width * 0.035,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.grey,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.008),
                        Text(
                          post.desc,
                          style: GoogleFonts.poppins(
                            fontSize: MediaQuery.of(context).size.width * 0.032,
                          ),
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.015),
                        if (post.imageUrl.isNotEmpty)
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (c) => ImagePreview(
                                    imageUrl: post.imageUrl,
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              alignment: Alignment.centerLeft,
                              height: MediaQuery.of(context).size.height * 0.25,
                              width: MediaQuery.of(context).size.width * 0.75,
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
                          ),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.015),
                        Text(
                          post.time,
                          style: GoogleFonts.poppins(
                            color: Colors.grey.withOpacity(0.8),
                            fontSize: MediaQuery.of(context).size.width * 0.035,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        );
      }
    },
  );
}
