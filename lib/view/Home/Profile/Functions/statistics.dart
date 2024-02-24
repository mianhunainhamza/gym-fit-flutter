import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pedometer/pedometer.dart';

class Statistics extends StatefulWidget {
  const Statistics({super.key});


  @override
  _StatisticsState createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> {
  late Stream<StepCount> _stepCountStream;
  int _steps = 0;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  /// Handle step count changed
  void onStepCount(StepCount event) {
    setState(() {
      _steps = event.steps;
    });
  }

  /// Handle the error
  void onStepCountError(error) {
    print("Pedometer error: $error");
  }

  Future<void> initPlatformState() async {
    // Init streams
    _stepCountStream = Pedometer.stepCountStream;

    // Listen to streams and handle errors
    _stepCountStream.listen(onStepCount).onError(onStepCountError);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Step Counter'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Steps Count:',
              style: TextStyle(fontSize: 20),
            ),
            Text(
              '$_steps',
              style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

