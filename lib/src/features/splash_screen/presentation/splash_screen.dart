import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  final int duration;
  final Widget navigateAfterSeconds;
  final Color backgroundColor;
  final Color loaderColor;
  final Image image;

  const SplashScreen({
    super.key,
    required this.duration,
    required this.navigateAfterSeconds,
    required this.backgroundColor,
    required this.loaderColor,
    required this.image,
  });

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _loadWidget();
  }

  @override
  dispose() {
    super.dispose();
  }

  _loadWidget() async {
    await Future.delayed(Duration(seconds: widget.duration));

    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => widget.navigateAfterSeconds),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.backgroundColor,
      body: Center(
        child: widget.image,
      ),
    );
  }
}
