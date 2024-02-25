import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationSettings extends StatefulWidget {
  const NotificationSettings({super.key}) ;

  @override
  State<NotificationSettings> createState() => _NotificationSettingsState();
}

class _NotificationSettingsState extends State<NotificationSettings> {
  bool _notificationValue = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notification settings',style: GoogleFonts.poppins(fontWeight: FontWeight.bold),),
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
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
             Expanded(
              child: Text(
                'Notifications',
                style: GoogleFonts.poppins(fontSize: 16),
              ),
            ),
            Checkbox(
              value: _notificationValue,
              onChanged: (newValue) {
                setState(() {
                  _notificationValue = newValue!;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
