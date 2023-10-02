import 'package:flutter/material.dart';
import 'package:vinnerenflix/splash/splash_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

   return  GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
        print("Sii TAP");
      },
      child: MaterialApp(      
        debugShowCheckedModeBanner: false,
        title: 'Vinnerenflix',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
          useMaterial3: true,        
        ),
        home: const SplashView(),
      ),
    );

    
  }
}
