import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/login.dart';
import 'package:flutter_application_1/route.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SplashScreen();
}

class _SplashScreen extends State<SplashScreen> with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 4500));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
          Lottie.asset("assets/news.json",
              controller: _controller,
              onLoaded: (compos) {
            _controller
              ..forward().then((value) =>
                  Navigator.of(context).pushReplacement(createRoute5()));
          }),
          SizedBox(
            height: 10,
          ),
          Text(
            'Welcome',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          )
        ]),
      ),
    );
  }
}
