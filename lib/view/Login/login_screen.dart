import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        elevation: 0.0,
        leading: InkWell(
            onTap: (){Get.back();},
            child: const Icon(Icons.arrow_back_ios_new)),
      ),
      body:   Padding(
        padding: const EdgeInsets.only(right: 20,left: 20, top: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Align(
              alignment: Alignment.center,
              child: Text('Welcome to Health Life',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600
                ),),
            ),
            const SizedBox(height: 19,),

            // Email
            TextFormField(
              decoration: InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.always,
                hintText: 'Enter your email',
                prefixIcon: const Icon(CupertinoIcons.mail),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                )
              ),
            ),

            const SizedBox(height: 20,),

            // Password
            TextFormField(
              obscureText: true,
              decoration: InputDecoration(
                  hintText: 'Enter your password',
                  prefixIcon: const Icon(CupertinoIcons.lock),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  )
              ),
            ),
            const SizedBox(height: 16),

            // Forget Password
            const Align(
                alignment: Alignment.centerRight,
                child: Text('Forget Password?',style: TextStyle(
                  fontWeight: FontWeight.bold
                ),)
            ),

            const SizedBox(height: 18),

            // Sign in button
            InkWell(
              onTap: (){

              },
                child: Container(
                  width: Get.width,
                  height: 50,
                  decoration:  BoxDecoration(
                    borderRadius: BorderRadius.circular(20) ,
                      color:  const Color.fromRGBO(253, 215, 138, 1)

                  ),
                    child: const Center(child: Text('Sign In'))
                ),
            ),
            const SizedBox(height: 16,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don't have an account?"),

                // Navigate to SignUp
                InkWell(
                    onTap: (){

                    },
                    child: Text('Signup for free',style: TextStyle(fontWeight: FontWeight.bold),))
              ],
            )
          ],
        ),
      ) ,
    );
  }
}
