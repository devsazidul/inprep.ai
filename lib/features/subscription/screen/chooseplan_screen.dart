// ignore_for_file: unnecessary_string_interpolations, unnecessary_to_list_in_spreads

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inprep_ai/core/common/styles/global_text_style.dart';
import 'package:inprep_ai/features/subscription/controller/subscription_controller.dart';
import 'package:inprep_ai/features/subscription/service/stripe_service.dart';
import 'package:inprep_ai/features/subscription/widgets/plan_card_widget.dart';

class ChooseplanScreen extends StatelessWidget {
  ChooseplanScreen({super.key});

  final SubscriptionController controller = Get.put(SubscriptionController());

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final padding = screenWidth * 0.04;
    final spacing = screenHeight * 0.02;
    final titleFontSize = screenWidth * 0.06;

    return Scaffold(
      body: SafeArea(
        child: Obx(() {
          if (controller.plans.isEmpty) {
            // Removed CircularProgressIndicator — you can show a message or just an empty box:
            return const SizedBox.shrink();
            // Or, if you want, show a message instead:
            // return Center(child: Text('No plans available.'));
          }

          return SingleChildScrollView(
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
                ...controller.plans.map((plan) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: spacing),
                    child: PlanCard(
                      planTitle: plan.name,
                      description: plan.description,
                      price: '\$${plan.priceMonthly.toStringAsFixed(2)}',
                      priceSuffix: '${plan.priceLabel}',
                      features: plan.features,
                      priceColor: const Color(0xff37BB74),
                      buttonColor: const Color(0xff37BB74),
                      onPress: () {
                        StripeService.makePayment(plan.priceMonthly, "usd");
                      },
                    ),
                  );
                }).toList(),
              ],
            ),
          );
        }),
      ),
    );
  }
}

