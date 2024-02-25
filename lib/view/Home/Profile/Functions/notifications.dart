import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:softec_app_dev/utils/colors.dart';


class NotificationSettings extends StatefulWidget {
  const NotificationSettings({super.key}) ;

  @override
  State<NotificationSettings> createState() => _NotificationSettingsState();
}

class _NotificationSettingsState extends State<NotificationSettings> {
  final List<bool> _isSelected = [false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notification',style: GoogleFonts.poppins(fontWeight: FontWeight.bold),),
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
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
             Expanded(
              child: Text(
                'Turn on Notifications',
                style: GoogleFonts.poppins(fontSize: 16),
              ),
            ),
            ToggleButtons(
              isSelected: _isSelected,
              onPressed: (index) {
                setState(() {
                  _isSelected[index] = !_isSelected[index];
                });
              },
              fillColor: Colors.transparent,
              borderRadius: BorderRadius.circular(10),
              borderColor: Colors.transparent,
              children: [
                LineIcon(
                  _isSelected[0] ? LineIcons.toggleOn : LineIcons.toggleOff,
                  size: 50,
                  color: yellowDark, // Change color as needed
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
