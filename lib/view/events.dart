import 'package:flutter/material.dart';

class Events extends StatelessWidget {
  const Events({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Workout"),
      ),
      body: const Column(
        children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Workout Plan'),
                Text('See more')
              ],
            )
        ],
      ),
    );
  }
}
