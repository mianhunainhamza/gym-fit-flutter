import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Options extends StatelessWidget {
  const Options({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        ListTile(
          leading: Icon(CupertinoIcons.person),
          trailing: Icon(Icons.arrow_forward_ios_outlined),
          title: Text('Personal',style: GoogleFonts.aBeeZee(),),
        ),
        ListTile(
          leading: const Icon(CupertinoIcons.settings),
          trailing: const Icon(Icons.arrow_forward_ios_outlined),
          title: Text('General Settings',style: GoogleFonts.aBeeZee(),),
        ),
        ListTile(
          leading: const Icon(Icons.notifications_none_outlined),
          trailing: const Icon(Icons.arrow_forward_ios_outlined),
          title: Text('Notifications',style: GoogleFonts.aBeeZee(),),
        ),
        ListTile(
          leading: const Icon(Icons.help_outline),
          trailing: const Icon(Icons.arrow_forward_ios_outlined),
          title: Text('Help',style: GoogleFonts.aBeeZee(),),
        ),
      ],
    );
  }
}
