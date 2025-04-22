import 'package:flutter/material.dart';
import 'package:inprep_ai/features/profile_setup.dart/screen.dart/about_me.dart';
import 'package:inprep_ai/features/profile_setup.dart/screen.dart/experience.dart';

// ignore: use_key_in_widget_constructors
class ProfileSlider extends StatelessWidget {
  final ValueNotifier<int> currentPageNotifier = ValueNotifier<int>(0);
  final PageController pageController = PageController();
  final int totalPages = 3;

  void nextPage() {
    if (currentPageNotifier.value < totalPages - 1) {
      currentPageNotifier.value++;
      pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            children: [
              ValueListenableBuilder<int>(
              valueListenable: currentPageNotifier,
              builder: (context, currentPage, child) {
                return Row(
                  children: List.generate(totalPages, (index) {
                    return Expanded(
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 4.0),
                        height: 5.0,
                        decoration: BoxDecoration(
                          color: index <= currentPage ? Colors.green : Colors.grey[300],
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                    );
                  }),
                );
              },
            ),
            SizedBox(height: 20),
            Expanded(
              child: PageView(
                controller: pageController,
                physics: NeverScrollableScrollPhysics(),
                onPageChanged: (index) {
                  currentPageNotifier.value = index;
                },
                children: [
                  AboutMe(),
                  Experience(),
                  Container(),
                ],
              ),
            ),
            ],
          ),
          )
        ),
    );
  }
}