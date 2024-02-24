import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:softec_app_dev/view/homepage.dart';
import 'package:softec_app_dev/view/sign_up_page.dart';
import 'package:softec_app_dev/view_model/login_controller.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   automaticallyImplyLeading: false,
      //   elevation: 0.0,
      //   leading: InkWell(
      //       onTap: () {
      //         Get.back();
      //       },
      //       child: const Icon(Icons.arrow_back_ios_new)),
      // ),
      body: Padding(
        padding: const EdgeInsets.only(right: 20, left: 20, top: 20),
        child: Form(
          key: controller.key.value,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: Get.height * 0.06,),
                SizedBox(
                    height: Get.height * .35,
                    child: Lottie.asset('assets/animations/dumble.json')),

                 Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Welcome to Health Life',
                    style: GoogleFonts.poppins(fontSize: Get.height * 0.034, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: Get.height * .05 ,
                ),

                // Email
                SizedBox(
                  height: Get.height * 0.11,
                  child: SizedBox(
                    height: Get.height * 0.1,
                    child: TextFormField(
                      validator: (text) {
                        if (text == null) {
                          return 'Null';
                        }
                        if (text.isEmpty) {
                          return 'Required Field';
                        }
                        if (!text.contains('@gmail.com')) {
                          return 'Invalid Email';
                        }
                        return null;
                      },
                      controller: controller.emailController.value,
                      decoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        hintText: 'Enter your email',
                        prefixIcon: const Icon(CupertinoIcons.mail),
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(
                  height: Get.height * .01 ,
                ),

                // Password
                SizedBox(
                    height: Get.height * 0.11,
                  child: SizedBox(
                    height: Get.height * 0.1,
                    child: TextFormField(
                      validator: (text) {
                        if (text == null) {
                          return 'Null';
                        }
                        if (text.isEmpty) {
                          return 'Required Field';
                        }
                        if (text.length < 8) {
                          return 'Password Invalid';
                        }
                        return null;
                      },
                      controller: controller.passController.value,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Enter your password',
                        prefixIcon: const Icon(CupertinoIcons.lock),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),
                ),


                // Forget Password
                const Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'Forget Password?',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),

                SizedBox(
                  height: Get.height * .03 ,
                ),

                // Sign in button
                GestureDetector(
                  onTap: () async {
                    if(controller.key.value.currentState!.validate()){
                      String email = controller.emailController.value.text;
                      String pass = controller.passController.value.text;
                      await  _signUpWithEmailAndPassword(email,pass);
                      print('Success');
                    }
                  },
                  child: Container(
                      width: Get.width,
                      height: 55,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: const Color.fromRGBO(253, 215, 138, 1)),
                      child: Center(
                          child: Text('L O G I N',
                              style: GoogleFonts.poppins(
                                  fontSize: Get.height * 0.026,
                                  fontWeight: FontWeight.bold)))
                  ),
                ),
                 SizedBox(
                  height: Get.height * 0.04,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account?"),

                    // Navigate to SignUp
                    InkWell(
                        onTap: () {
                          Get.to(const SignupPage(),transition: Transition.cupertino);
                        },
                        child: const Text(
                          '  Register Now',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _signUpWithEmailAndPassword(email,pass) async {
    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      await auth.signInWithEmailAndPassword(email: email, password: pass);
      Get.to(const HomePage());
    } on Exception catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }
}
