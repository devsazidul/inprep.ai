import 'package:flutter/material.dart';
import 'package:inprep_ai/core/common/styles/global_text_style.dart';
import 'package:inprep_ai/core/common/widgets/custom_button.dart';
import 'package:inprep_ai/core/utils/constants/icon_path.dart';

class PlanCard extends StatelessWidget {
  final String planTitle;
  final String description;
  final String price;
  final String priceSuffix;
  final List<String> features;
  final Color priceColor;
  final Color buttonColor;
  final VoidCallback onPress;

  const PlanCard({
    super.key,
    required this.planTitle,
    required this.description,
    required this.price,
    required this.priceSuffix,
    required this.features,
    required this.priceColor,
    required this.buttonColor,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 528,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xffE0E0E1), width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              planTitle,
              style: getTextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: const Color(0xff3A4C67),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: getTextStyle(
                color: const Color(0xff676768),
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 18),
            Row(
              children: [
                Text(
                  price,
                  style: getTextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.w700,
                    color: priceColor,
                  ),
                ),
                Text(
                  priceSuffix,
                  style: getTextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xff174D31),
                  ),
                ),
              ],
            ),
            Text(
              "What's included",
              style: getTextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: const Color(0xff3A4C67),
              ),
            ),
            const SizedBox(height: 15),
            ...features.map(
              (feature) => Padding(
                padding: const EdgeInsets.only(bottom: 13.5),
                child: Row(
                  children: [
                    Image.asset(IconPath.checkbox),
                    const SizedBox(width: 8),
                    Text(
                      feature,
                      style: getTextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xff3A4C67),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 14),
            CustomButton1(
              title: "Get Started",
              onPress: onPress,
              backgroundColor: buttonColor,
              borderColor: Colors.transparent,
              textcolor: const Color(0xffffffff),
            ),
          ],
        ),
      ),
    );
  }
}
