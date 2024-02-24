import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:softec_app_dev/view/homepage.dart';
import 'package:softec_app_dev/view/onboard_page.dart';

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
                      child: Text(
                        "Create Account",
                        style: TextStyle(
                          fontSize: Get.width * 0.10,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
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
                          if (value!.trim().isEmpty || !value.trim().contains('@')) {
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
                          if (value!.trim().length < 6) {
                            return 'Password must be at least 6 characters long';
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
                  SizedBox(height:Get.width * 0.04),
                  Padding(
                    padding: const EdgeInsets.only(left: 33,right: 33),
                    child: DropdownButtonFormField<String>(
                      value: selectedRole,
                      hint: const Text('Choose Role'),
                      items: <String>['Fitness Enthusiast', 'Fitness Professional']
                          .map((String value) {
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
                  SizedBox(height: Get.width * 0.15),
                  GestureDetector(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        if (!tickMark) {
                          showCupertinoDialog(
                            context: context,
                            builder: (context) {
                              return CupertinoAlertDialog(
                                title: const Text(
                                    "Agree to Terms and Conditions"),
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
                          HomePage();
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
                          child: Text(
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
}
