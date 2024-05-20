import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:softec_app_dev/utils/utils.dart';
import 'package:softec_app_dev/view/Screens/Authentication/verify_email.dart';
import 'package:softec_app_dev/view/Screens/OnBoard/onboard_page.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController numController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  bool userPassWrong = false;
  bool obscureText = true;
  bool userEmailWrong = false;
  bool userNameWrong = false;
  bool tickMark = false;
  String? selectedRole;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Get.to(() => const OnBoardPage(), transition: Transition.cupertino);
          },
          child: const Icon(Icons.arrow_back_ios_new),
        ),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(
                height: Get.height * 0.03,
              ),
              Column(
                children: [
                  Row(children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(
                            fontSize: Get.width * 0.10,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2,
                          ),
                          children: const [
                            TextSpan(
                              text: "Create ",
                              style: TextStyle(
                                  color: Color.fromRGBO(
                                      255, 220, 138, 1) // RGB color
                                  ),
                            ),
                            TextSpan(
                              text: "Account",
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ]),
                  SizedBox(height: Get.width * 0.08),
                  SizedBox(
                    width: Get.width * 0.9,
                    child: SizedBox(
                      height: 90,
                      child: TextFormField(
                        controller: nameController,
                        validator: (value) {
                          if (value!.trim().isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          prefixIcon: const Icon(CupertinoIcons.person),
                          labelText: 'User Name',
                          labelStyle: TextStyle(
                            fontSize: Get.width * 0.04,
                            color: Colors.black,
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                            borderSide: BorderSide(color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: Get.width * 0.04),
                  SizedBox(
                    width: Get.width * 0.9,
                    child: SizedBox(
                      height: 90,
                      child: TextFormField(
                        controller: emailController,
                        validator: (value) {
                          if (value!.trim().isEmpty ||
                              !value.trim().contains('@')) {
                            return 'Please enter a valid email address';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          labelText: 'Email',
                          labelStyle: TextStyle(
                            fontSize: Get.width * 0.04,
                            color: Colors.black,
                          ),
                          prefixIcon: const Icon(Icons.email_outlined),
                          focusedBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                            borderSide: BorderSide(color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: Get.width * 0.04),
                  SizedBox(
                    width: Get.width * 0.9,
                    child: SizedBox(
                      height: 90,
                      child: TextFormField(
                        controller: passController,
                        obscureText: obscureText,
                        validator: (value) {
                          if (value!.trim().length < 8) {
                            return 'Password must be at least 8 characters long';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          labelText: 'Password',
                          prefixIcon: const Icon(CupertinoIcons.lock),
                          labelStyle: TextStyle(
                            fontSize: Get.width * 0.04,
                            color: Colors.black,
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                obscureText = !obscureText;
                              });
                            },
                            child: Icon(
                              obscureText
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: Get.width * 0.04),
                  SizedBox(
                    height: Get.height * .1,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 33, right: 33),
                      child: DropdownButtonFormField<String>(
                        validator: (value) {
                          if (value == null) {
                            return "Choose a Role";
                          }
                          if (value.isEmpty) {
                            return "Choose a Role";
                          }
                          return null;
                        },
                        value: selectedRole,
                        hint: const Text('Choose Role'),
                        items: <String>[
                          'Fitness Enthusiast',
                          'Fitness Professional'
                        ].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedRole = value;
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: Get.width * 0.15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            tickMark = !tickMark;
                          });
                        },
                        child: tickMark
                            ? const Icon(CupertinoIcons.check_mark)
                            : const Icon(CupertinoIcons.square,
                                color: CupertinoColors.inactiveGray),
                      ),
                      const Text(" I've read and agree to "),
                      const Text(
                        "Terms & Conditions",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                      )
                    ],
                  ),

                  //
                  SizedBox(height: Get.width * 0.15),
                  GestureDetector(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          isLoading = true;
                        });
                        if (!tickMark) {
                          setState(() {
                            isLoading = false;
                          });
                          showCupertinoDialog(
                            context: context,
                            builder: (context) {
                              return CupertinoAlertDialog(
                                title:
                                    const Text("Agree to Terms and Conditions"),
                                actions: [
                                  CupertinoDialogAction(
                                    child: const Text("OK"),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        } else {
                          createUser(emailController.text, passController.text,
                              nameController.text, selectedRole);
                        }
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 20, left: 20),
                      child: Container(
                        width: Get.width,
                        height: 55,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: const Color.fromRGBO(253, 215, 138, 1),
                        ),
                        child: Center(
                          child: isLoading
                              ? const CircularProgressIndicator(
                                  color: Colors.black,
                                )
                              : Text(
                                  'CREATE ACCOUNT',
                                  style: GoogleFonts.poppins(
                                    fontSize: Get.height * 0.026,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        ),
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
  }

  Future<UserCredential?> createUser(email, pass, name, role) async {
    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: pass);
      User? user = userCredential.user;

      await user?.updateDisplayName(name);

      // Navigate to the email verification page
      Get.offAll(VerifyEmailPage(email: email),
          transition: Transition.cupertino);

      // Store user data in Firestore
      final cloud = FirebaseFirestore.instance;
      await cloud.collection('users').doc(user!.uid).set({
        'uid': user.uid,
        'email': email,
        'name': name,
        'role': role,
        'pass': pass,
        'profilePicUrl': '',
      });

      // Send email verification
      await user.sendEmailVerification();

      return userCredential;
    } on Exception catch (e) {
      setState(() {
        isLoading = false;
      });
      Utils().showMessage(context,"'Error ${e.toString()}", Colors.red);
      return null;
    }
  }
}
