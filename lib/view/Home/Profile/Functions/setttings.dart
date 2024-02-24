import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool isObscure = true;
  bool isReadOnly = true;
  String buttonText = 'EDIT';

  // final emailController = TextEditingController();
  // final passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings',style: GoogleFonts.poppins(fontWeight: FontWeight.bold),),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(22.0),
        child: Column(
            children: [
              Align(
                  alignment: Alignment.topLeft,
                  child: Text('  UserName',
                    style: GoogleFonts.poppins(fontSize: 20,fontWeight: FontWeight.bold),)),

              SizedBox(height: Get.height * 0.02),

              // Username
              SizedBox(
                height: Get.height * 0.11,
                child: SizedBox(
                  height: Get.height * 0.1,
                  child: TextFormField(
                    readOnly: isReadOnly,
                    initialValue: 'Username',
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
                 // controller: emailController,
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

              Align(
                alignment: Alignment.centerLeft,
                child: Text('  Password',
                  style: GoogleFonts.poppins(fontSize: 20,fontWeight: FontWeight.bold),),
              ),

              SizedBox(height: Get.height * 0.02),

              // Password
              SizedBox(
                height: Get.height * 0.11,
                child: SizedBox(
                  height: Get.height * 0.1,
                  child: TextFormField(
                    //controller: passController,
                    readOnly: isReadOnly,
                    initialValue: 'ewewerewr',
                    obscureText: isObscure,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(CupertinoIcons.lock),
                      suffixIcon: GestureDetector(
                          onTap: (){
                            setState(() {
                              isObscure = !isObscure;
                            });
                          },
                          child: isObscure?
                          const Icon(Icons.visibility_off):
                          const Icon(Icons.visibility)),
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

              SizedBox(
                height: Get.height * .01 ,
              ),

              // Edit button
              GestureDetector(
                onTap: () {
                  setState(() {
                    if (isReadOnly == true) {
                      isReadOnly = false;
                      buttonText = 'SAVE';
                      isObscure = !isObscure;
                    } else {
                      isObscure = !isObscure;
                      isReadOnly = true;
                      buttonText = 'EDIT';
                    }
                  });
                },
                child: Container(
                    width: Get.width,
                    height: 55,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: const Color.fromRGBO(253, 215, 138, 1)),
                    child: Center(
                        child: Text(buttonText,
                            style: GoogleFonts.poppins(
                                fontSize: Get.height * 0.026,
                                fontWeight: FontWeight.bold)))
                ),
              ),
            ],
        ),
      )
    );
  }
}
