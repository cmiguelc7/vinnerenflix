import 'package:flutter/material.dart';
import 'package:vinnerenflix/home/home_view.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    splashTransition();
    super.initState();
  }

  void splashTransition() async {
    await Future.delayed(const Duration(seconds: 3));
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (BuildContext context) => HomeView(),
        ),
        (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.red,
      backgroundColor: const Color.fromRGBO(233, 233, 233, 1),
      body: Center(
        child: SizedBox(
          width: 200,
          child: Image.asset('assets/icon.png'),
        ),
      ),
    );
  }
}
