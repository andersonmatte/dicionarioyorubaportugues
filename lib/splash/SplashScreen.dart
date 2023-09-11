import 'dart:async';

import 'package:flutter/material.dart';

import '../home/AlphabetGridViewApp.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<SplashScreen> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  startSplashScreen() async {
    var duration = const Duration(seconds: 3);
    return Timer(duration, () {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => AlphabetGridViewApp()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            "assets/images/map-nigeria.png",
          ),
          const Center(
            child: Text(
              "DICIONÁRIO YORÙBÁ",
              style: TextStyle(
                color: Color(0xFF008751),
                fontWeight: FontWeight.bold,
                fontSize: 14,
                fontFamily: 'Roboto',
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    startSplashScreen();
  }
}
