import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:softec_app_dev/view_model/feed_controller.dart';

import '../../../../model/post.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({super.key});

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  final FeedController feedController = Get.put(FeedController());

  late Future<List<PostModel>> allPosts;
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
    allPosts = feedController.getUserPosts(auth.currentUser!.email!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: const Icon(Icons.arrow_back_ios_new),
        ),
        centerTitle: true,
        title: Text(
          "Your Posts",
          style: GoogleFonts.poppins(
            fontSize: Get.height * 0.03,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: FutureBuilder<List<PostModel>>(
        future: allPosts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No posts available'));
          } else {
            List<PostModel> posts = snapshot.data!;
            return GridView.custom(
              gridDelegate: SliverQuiltedGridDelegate(
                crossAxisCount: 4,
                mainAxisSpacing: 4,
                crossAxisSpacing: 4,
                repeatPattern: QuiltedGridRepeatPattern.inverted,
                pattern: const [
                  QuiltedGridTile(2, 2),
                  QuiltedGridTile(1, 1),
                  QuiltedGridTile(1, 1),
                  QuiltedGridTile(1, 2),
                ],
              ),
              childrenDelegate: SliverChildBuilderDelegate(
                (context, index) {
                  return Tile(
                    index: index,
                    postUrl: posts[index].imageUrl,
                  );
                },
                childCount: posts
                    .length, // Set the child count based on the length of the posts list
              ),
            );
          }
        },
      ),
    );
  }
}

class Tile extends StatelessWidget {
  final int index;
  final String postUrl;

  const Tile({super.key, required this.index, required this.postUrl});

  @override
  Widget build(BuildContext context) {
    return Image.network(
      postUrl,
      filterQuality: FilterQuality.high,
      fit: BoxFit.cover,
    );
  }
}
