import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ImagePreview extends StatelessWidget {
  final String imageUrl;

  const ImagePreview({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      backgroundColor: Colors.black,
      body: SizedBox(
        width: Get.width,
        height: Get.height,
        child: Hero(tag: imageUrl, child: Image.network(imageUrl)),
      ),
    );
  }
}
