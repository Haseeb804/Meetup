import 'package:flutter/material.dart';
import 'package:meetup/app_colors.dart';
import 'package:meetup/welcome_screen.dart';
import 'package:meetup/login_screen.dart';
import 'package:meetup/signup_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meetup App',
      debugShowCheckedModeBanner: false,

      // 1) Define a theme that uses our color palette
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.scaffoldBackground,
        primaryColor: AppColors.brown,
        textTheme: TextTheme(
          // Basic body text
          bodyMedium: TextStyle(color: AppColors.textColor),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.brown,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),

      // 2) Set initial route & named routes
      initialRoute: '/',
      routes: {
        '/': (context) => WelcomeScreen(),
        '/login': (context) => LoginScreen(),
        '/signup': (context) => SignUpScreen(),
      },
    );
  }
}
