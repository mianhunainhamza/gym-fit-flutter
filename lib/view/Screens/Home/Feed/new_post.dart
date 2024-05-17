import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:softec_app_dev/view/Screens/bottom_navigation.dart';
import '../../../../model/post.dart';
import '../../../../utils/colors.dart';
import '../../../../view_model/feed_controller.dart';

class NewPost extends StatefulWidget {
  const NewPost({Key? key}) : super(key: key);

  @override
  State<NewPost> createState() => _NewPostState();
}

class _NewPostState extends State<NewPost> {
  final FeedController feedController = Get.put(FeedController());

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  final TextEditingController imageUrlController = TextEditingController();

  File? _image;

  bool _uploading = false;

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
        title: const Text(
          'Add New Post',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  TextField(
                    controller: titleController,
                    decoration: const InputDecoration(
                      labelText: 'Title',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: descController,
                    maxLines: 4,
                    decoration: const InputDecoration(
                      labelText: 'Description',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () async {
                      XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
                      if (image != null) {
                        setState(() {
                          _image = File(image.path);
                          imageUrlController.text = image.path;
                        });
                      }
                    },
                    child: Container(
                      height: 350,
                      width: double.infinity,
                      color: Colors.grey[200],
                      child: _image != null
                          ? Image.file(
                        _image!,
                        fit: BoxFit.fitHeight,
                      )
                          : const Center(
                        child: Icon(
                          Icons.add_photo_alternate,
                          size: 50,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: ElevatedButton(
                  onPressed: ()
                  {
                    uploadPost();
                  },
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                    backgroundColor: MaterialStateProperty.all<Color>(_uploading ? Colors.grey : yellowColor),
                    minimumSize: MaterialStateProperty.all(Size(Get.width, 50.0)),
                  ),
                  child: Text(
                    _uploading ? 'UPLOADING...' : 'S U B M I T',
                    style: TextStyle(color: Colors.black, fontSize: Get.width * .046),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> uploadPost() async {
    setState(() {
      _uploading = true;
    });

    try {
      if (_image != null) {
        String fileName = DateTime.now().millisecondsSinceEpoch.toString();
        firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
            .ref()
            .child('images')
            .child('$fileName.jpg');

        // Upload image to Firebase Storage
        final uploadTask = ref.putFile(_image!);

        // Listen for state changes, errors, and completion of the upload.
        uploadTask.snapshotEvents.listen((firebase_storage.TaskSnapshot snapshot) {
          double progress = snapshot.bytesTransferred / snapshot.totalBytes;
          print('Upload progress: $progress');
        }, onError: (error) {
          // Handle any errors
          print('Error during upload: $error');
        });

        // Await upload completion
        final snapshot = await uploadTask.whenComplete(() {});

        // Get image download URL
        String imageUrl = await snapshot.ref.getDownloadURL();

        // Get current user
        User? user = FirebaseAuth.instance.currentUser;
        if (user == null) {
          throw 'User not authenticated';
        }

        // Get user name
        DocumentSnapshot<Map<String, dynamic>> snapshot1 = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
        String userName = snapshot1.data()?['name'];

        // Get post details
        String title = titleController.text.trim();
        String desc = descController.text.trim();
        if (title.isEmpty || desc.isEmpty) {
          throw 'Title and description cannot be empty';
        }

        // Create post object
        PostModel post = PostModel(
          userName: userName,
          title: title,
          desc: desc,
          email: user.email!,
          imageUrl: imageUrl,
          time: DateFormat('hh:mm a dd/MM/yyyy').format(DateTime.now()),
        );

        // Upload post to Firestore
        feedController.uploadPost(post);

        // Show success message
        Get.snackbar('Congratulations', 'Successfully Posted');

        // Clear text controllers
        titleController.clear();
        descController.clear();
        imageUrlController.clear();
        imageUrlController.clear();
      } else {
        // Show error message
        Get.snackbar('Error', 'Please select an image');
      }
    } catch (error) {
      // Show error message
      Get.snackbar('Error', 'Failed to upload post: $error');
    } finally {
      setState(() {
        _uploading = false;
      });
      Get.to(const BottomNavigation(),transition: Transition.cupertino);
    }
  }
}
