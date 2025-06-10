import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:netflix/view/user/user_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);

    _controller.forward();

    _controller.addStatusListener((status) async {
      if (status.isCompleted) {
        Future.delayed(Duration(seconds: 2), () {
          if (mounted) {
            Navigator.pushReplacement(
              context,
              CupertinoPageRoute(builder: (context) => UserScreen()),
            );
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FadeTransition(
          opacity: _animation,
          child: Image.asset('assets/images/logo.png', width: 200, height: 200),
        ),
      ),
    );
  }
}
