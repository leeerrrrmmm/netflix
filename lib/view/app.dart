import 'package:flutter/material.dart';
import 'package:netflix/view/splash/splash_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Color(0xff121212),
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey,
        ),
      ),
      home: SplashScreen(),
    );
  }
}
