import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:softec_app_dev/utils/colors.dart';
import 'package:softec_app_dev/view/Screens/Home/Feed/image_preview.dart';
import 'package:softec_app_dev/view/Screens/Home/Feed/new_post.dart';
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
  bool isDeleting = false;
  Set<int> selectedPosts = Set<int>();

  @override
  void initState() {
    allPosts = feedController.getUserPosts();
    super.initState();
  }

  void _toggleDeleteMode() {
    if (isDeleting) {
      if (selectedPosts.isNotEmpty) {
        _showDeleteConfirmationDialog();
      } else {
        setState(() {
          isDeleting = false;
        });
      }
    } else {
      setState(() {
        isDeleting = true;
      });
    }
  }

  void _showDeleteConfirmationDialog() {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Text('Delete Posts'),
          content: const Text('Are you sure you want to delete the selected posts?'),
          actions: [
            CupertinoDialogAction(
              isDefaultAction: true,
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            CupertinoDialogAction(
              isDestructiveAction: true,
              child: const Text('Delete'),
              onPressed: () async {
                Navigator.of(context).pop();
                await _deleteSelectedPosts();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _deleteSelectedPosts() async {
    for (int index in selectedPosts) {
      await feedController.deletePost(index);
    }
    setState(() {
      selectedPosts.clear();
      isDeleting = false;
    });
    // Refresh the posts list after deletion
    allPosts = feedController.getUserPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: GestureDetector(
              onTap: _toggleDeleteMode,
              child: Icon(
                isDeleting ? CupertinoIcons.check_mark : CupertinoIcons.delete,
              ),
            ),
          )
        ],
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
            fontSize: 28,
            fontWeight: FontWeight.w600,
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
                    isDeleting: isDeleting,
                    isSelected: selectedPosts.contains(index),
                    onSelect: () {
                      setState(() {
                        if (selectedPosts.contains(index)) {
                          selectedPosts.remove(index);
                        } else {
                          selectedPosts.add(index);
                        }
                      });
                    },
                  );
                },
                childCount: posts.length,
              ),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: yellowDark,
        onPressed: () {
          Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (c) => const NewPost(),
            ),
          );
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}

class Tile extends StatelessWidget {
  final int index;
  final String postUrl;
  final bool isDeleting;
  final bool isSelected;
  final VoidCallback onSelect;

  const Tile({
    super.key,
    required this.index,
    required this.postUrl,
    required this.isDeleting,
    required this.isSelected,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: postUrl,
      child: GestureDetector(
        onTap: isDeleting ? onSelect : () {
          Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (c) => ImagePreview(
                imageUrl: postUrl,
              ),
            ),
          );
        },
        child: Stack(
          children: [
            Image.network(
              postUrl,
              filterQuality: FilterQuality.high,
              fit: BoxFit.cover, // Ensure the image fits the tile properly
              width: double.infinity,
              height: double.infinity,
            ),
            if (isDeleting)
              Positioned(
                top: 8,
                right: 8,
                child: Icon(
                  isSelected ? CupertinoIcons.check_mark_circled_solid : CupertinoIcons.circle,
                  color: yellowDark,
                  size: 30,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
