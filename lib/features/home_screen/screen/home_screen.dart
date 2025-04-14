import 'package:flutter/material.dart';
import 'package:inprep_ai/core/utils/constants/colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      body: Center(
        child: Text("Home Screen"),
      ),
    );
  }
}