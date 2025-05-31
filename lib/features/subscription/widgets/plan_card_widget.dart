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
  final String priceId;

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
    required this.priceId,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final padding = screenWidth * 0.04;
    final titleFontSize = screenWidth * 0.05;
    final descriptionFontSize = screenWidth * 0.035;
    final priceFontSize = screenWidth * 0.09;
    final priceSuffixFontSize = screenWidth * 0.04;
    final featureFontSize = screenWidth * 0.04;

    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: padding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xffE0E0E1), width: 1),
      ),
      child: Padding(
        padding: EdgeInsets.all(padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              planTitle,
              style: getTextStyle(
                fontSize: titleFontSize,
                fontWeight: FontWeight.w600,
                color: const Color(0xff3A4C67),
              ),
            ),
            SizedBox(height: padding / 2),
            Text(
              description,
              style: getTextStyle(
                color: const Color(0xff676768),
                fontSize: descriptionFontSize,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: padding),
            Row(
              children: [
                Text(
                  price,
                  style: getTextStyle(
                    fontSize: priceFontSize,
                    fontWeight: FontWeight.w700,
                    color: priceColor,
                  ),
                ),
                Text(
                  priceSuffix,
                  style: getTextStyle(
                    fontSize: priceSuffixFontSize,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xff174D31),
                  ),
                ),
              ],
            ),
            SizedBox(height: padding / 2),
            Text(
              "What's included",
              style: getTextStyle(
                fontSize: titleFontSize * 0.9,
                fontWeight: FontWeight.w600,
                color: const Color(0xff3A4C67),
              ),
            ),
            SizedBox(height: padding),
            ...features.map((feature) => Padding(
                  padding: EdgeInsets.only(bottom: padding * 0.8),
                  child: Row(
                    children: [
                      Image.asset(
                        IconPath.checkbox,
                        width: featureFontSize * 1.2,
                        height: featureFontSize * 1.2,
                      ),
                      SizedBox(width: padding / 2),
                      Expanded(
                        child: Text(
                          feature,
                          style: getTextStyle(
                            fontSize: featureFontSize,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xff3A4C67),
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
            SizedBox(height: padding),
            CustomButton1(
              title: "Get Started",
              onPress: onPress,
              backgroundColor: buttonColor,
              borderColor: Colors.transparent,
              textcolor:  Color(0xffffffff),
            ),
          ],
        ),
      ),
    );
  }
}
