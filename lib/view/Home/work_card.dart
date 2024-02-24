import 'package:flutter/cupertino.dart';

class WorkCard extends StatelessWidget {
  const WorkCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset('assets/images/girl.png')
      ],
    );
  }
}
