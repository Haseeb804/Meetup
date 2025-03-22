import 'package:flutter/material.dart';
import 'package:meetup/app_colors.dart';
import 'dashboard.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Heading
                Text(
                  "LETS MEETUP",
                  style: textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.brown, // override if needed
                  ),
                ),
                const SizedBox(height: 5),

                // Subtitle
                Text(
                  "Let Us Make your Event spark\nLet be connected",
                  textAlign: TextAlign.center,
                  style: textTheme.bodyMedium?.copyWith(
                    color: AppColors.textColor.withOpacity(0.8),
                  ),
                ),
                const SizedBox(height: 10),
                const Divider(thickness: 1),

                // Section Title
                Text(
                  "Discover & Manage Events Easily",
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.brown,
                  ),
                ),
                const SizedBox(height: 5),

                // Description
                Text(
                  "Create, explore, and stay updated on events with just a few taps!\nFind venues, details, and more – all in one place.",
                  textAlign: TextAlign.center,
                  style: textTheme.bodyMedium?.copyWith(
                    color: AppColors.textColor.withOpacity(0.8),
                  ),
                ),
                const SizedBox(height: 20),

                // Get Started Button
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "/login");
                  },
                  child: const Text("GET STARTED >",style: TextStyle(color: Colors.white),),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
