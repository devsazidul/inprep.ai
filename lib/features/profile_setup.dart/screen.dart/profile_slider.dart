import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inprep_ai/core/common/widgets/custom_button.dart';
import 'package:inprep_ai/features/personalized_interviewers/view/personalized_interviewer_screen.dart'
    show PersonalizedInterviewerScreen;
import 'package:inprep_ai/features/profile_setup.dart/screen.dart/about_me.dart';
import 'package:inprep_ai/features/profile_setup.dart/screen.dart/education_cirtificate.dart';
import 'package:inprep_ai/features/profile_setup.dart/screen.dart/experience.dart';

// ignore: use_key_in_widget_constructors
class ProfileSlider extends StatelessWidget {
  final ValueNotifier<int> currentPageNotifier = ValueNotifier<int>(0);
  final PageController pageController = PageController();
  final int totalPages = 3;
  final ValueNotifier<List<String>> selectedSkillsNotifier =
      ValueNotifier<List<String>>([]);

  void nextPage(BuildContext context) {
    if (currentPageNotifier.value < totalPages - 1) {
      // Move to the next slide
      currentPageNotifier.value++;
      pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Get.to(PersonalizedInterviewerScreen());
    }
  }

  void addSkill(String skill) {
    if (!selectedSkillsNotifier.value.contains(skill)) {
      selectedSkillsNotifier.value = [...selectedSkillsNotifier.value, skill];
    }
  }

  void removeSkill(String skill) {
    selectedSkillsNotifier.value =
        selectedSkillsNotifier.value.where((s) => s != skill).toList();
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
                          height: 2.0,
                          decoration: BoxDecoration(
                            color:
                                index <= currentPage
                                    ? Colors.green
                                    : Colors.grey[300],
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
                    AboutMe(
                      selectedSkillsNotifier: selectedSkillsNotifier,
                      onAddSkill: addSkill,
                      onRemoveSkill: removeSkill,
                    ),
                    Experience(),
                    EducationCertificate(),
                  ],
                ),
              ),
              SizedBox(height: 10),
              CustomButton1(
                title: "Continure",
                textcolor: Color(0xffffffff),
                backgroundColor: Color(0xff37BB74),
                onPress: () => nextPage(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
