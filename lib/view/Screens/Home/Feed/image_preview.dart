import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ImagePreview extends StatelessWidget {
  final String imageUrl;
  final String tag;

  const ImagePreview({super.key, required this.imageUrl, required this.tag});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: const Icon(Icons.arrow_back_ios_new),
        ),
        automaticallyImplyLeading: false,
      ),
      body: SizedBox(
        width: Get.width,
        height: Get.height,
        child: Hero(tag: tag, child: Image.network(imageUrl)),
      ),
    );
  }
}
