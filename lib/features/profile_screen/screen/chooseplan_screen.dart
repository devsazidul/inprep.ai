import 'package:flutter/material.dart';
import 'package:inprep_ai/core/common/styles/global_text_style.dart';
import 'package:inprep_ai/features/profile_screen/widgets/plan_card_widget.dart';

class ChooseplanScreen extends StatelessWidget {
  const ChooseplanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Dynamic padding and spacing
    final padding = screenWidth * 0.04;
    final spacing = screenHeight * 0.02;
    final titleFontSize = screenWidth * 0.06;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(padding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Choose Your Plan",
                    style: getTextStyle(
                      color: const Color(0xff212121),
                      fontSize: titleFontSize,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(height: spacing),
                // Free Plan
                PlanCard(
                  planTitle: "Free Plan",
                  description:
                      "Lorem ipsum dolor sit amet consectetur. At \ninterdum euismod ac cras mauris. Maecenas \negestas cursus integer porttitor amet.",
                  price: "\$00",
                  priceSuffix: "/monthly",
                  features: [
                    "1 Free Mock Interview",
                    "Track up to 10 Jobs per month",
                    "Personalized Feedback",
                    "Access to AI Feedback 1 Interview",
                    "Progress Tracking",
                    "Recommendation for Improvement",
                  ],
                  priceColor: const Color(0xff37BB74),
                  buttonColor: const Color(0xff37BB74),
                  onPress: () {},
                ),
                SizedBox(height: spacing),
                // Premium Plan
                PlanCard(
                  planTitle: "Premium Plan",
                  description:
                      "Lorem ipsum dolor sit amet consectetur. At \ninterdum euismod ac cras mauris. Maecenas \negestas cursus integer porttitor amet.",
                  price: "\$19.99",
                  priceSuffix: "/monthly",
                  features: [
                    "10 Mock Interview",
                    "Unlimited Jobs Tracking",
                    "Access to AI Feedback 10 Interview",
                    "Generate Custom Mock Interview",
                    "Progress Tracking",
                    "Recommendation for Improvement",
                  ],
                  priceColor: const Color(0xff37BB74),
                  buttonColor: const Color(0xff37BB74),
                  onPress: () {},
                ),
                SizedBox(height: spacing),
                // Pay-Per-Interview
                PlanCard(
                  planTitle: "Pay-Per-Interview",
                  description:
                      "Lorem ipsum dolor sit amet consectetur. At \ninterdum euismod ac cras mauris. Maecenas \negestas cursus integer porttitor amet.",
                  price: "\$4.99",
                  priceSuffix: "/Per Interview",
                  features: [
                    "Unlimited Jobs Tracking",
                    "Personalized Feedback",
                    "Access to AI Feedback",
                    "Generate Custom Mock Interview",
                    "Progress Tracking",
                    "Recommendation for Improvement",
                  ],
                  priceColor: const Color(0xff37BB74),
                  buttonColor: const Color(0xff37BB74),
                  onPress: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
