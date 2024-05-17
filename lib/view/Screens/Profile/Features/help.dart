import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_fonts/google_fonts.dart';

class Help extends StatelessWidget {
  const Help({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Terms and Conditions',style: GoogleFonts.poppins(fontWeight: FontWeight.bold),),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
      ),
      body:  Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Text('''
1. Introduction
   - Welcome to Flex Now (the "App"). These terms and conditions (the "Terms") govern your use of the App. By using the App, you agree to be bound by these Terms.

2. Use of the App
   - You must be at least 18 years old to use the App.
   - You agree to use the App for lawful purposes only and in a manner consistent with all applicable laws and regulations.

3. User Accounts
   - In order to access certain features of the App, you may be required to create a user account. You are responsible for maintaining the confidentiality of your account and password and for restricting access to your account.

4. Content
   - The content provided through the App, including but not limited to workout routines, exercise videos, and nutritional information, is for informational purposes only. Always consult with a qualified healthcare professional before beginning any exercise program or making any dietary changes.

5. Intellectual Property
   - All intellectual property rights in the App and its content are owned by or licensed to us. You may not use, reproduce, or distribute any content from the App without our prior written consent.

6. Privacy
   - We are committed to protecting your privacy. Please review our Privacy Policy [link to Privacy Policy] to understand how we collect, use, and disclose your personal information.

7. Disclaimer of Warranties
   - Flex Now is provided on an "as is" and "as available" basis, without any warranties of any kind, either express or implied. We do not warrant that Flex Now will be uninterrupted or error-free, or that any defects will be corrected.

8. **Limitation of Liability**
   - To the fullest extent permitted by law, we will not be liable for any indirect, incidental, special, consequential, or punitive damages arising out of or in connection with your use of Flex Now.

9. Indemnification
   - You agree to indemnify and hold us harmless from any claims, damages, liabilities, costs, or expenses (including attorney's fees) arising out of or in connection with your use of Flex Now or any breach of these Terms.

10. Governing Law
    - These Terms are governed by and construed in accordance with the laws of [Your Jurisdiction]. Any disputes arising out of or in connection with these Terms shall be subject to the exclusive jurisdiction of the courts of [Your Jurisdiction].

11. Changes to Terms
    - We reserve the right to modify or update these Terms at any time. Any changes will be effective immediately upon posting the revised Terms on Flex Now. Your continued use of Flex Now following the posting of the revised Terms constitutes acceptance of those changes.

12. Contact Us
    - If you have any questions or concerns about these Terms, please contact us at flexnow@gmail.com.


          ''',style: GoogleFonts.poppins(),
        ),
      ),
    ));
  }
}
