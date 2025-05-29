import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inprep_ai/features/subscription/components/get_started_button.dart'
    show GetStartedButton;
import 'package:inprep_ai/features/subscription/controller/subscription_controller.dart'
    show SubscriptionController;
import 'package:inprep_ai/features/subscription/service/stripe_service.dart'
    show StripeService;

class SubscriptionList extends StatelessWidget {
  SubscriptionList({super.key});
  final SubscriptionController controller = Get.find<SubscriptionController>();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size.width * 0.05;
    return Expanded(
      child: ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: controller.subscriptionList.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          final subscription = controller.subscriptionList[index];
          return Padding(
            padding: EdgeInsets.only(bottom: 15),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFE0E0E1)),
              ),
              child: Padding(
                padding: EdgeInsets.only(
                  top: 20,
                  bottom: 20,
                  left: size,
                  right: size,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      subscription["name"],
                      style: GoogleFonts.poppins(
                        color: Color(0xFF3A4C67),
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      subscription["description"],
                      textAlign: TextAlign.justify,
                      style: GoogleFonts.poppins(
                        color: Color(0xFF676768),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Text(
                          "\$${subscription['price']}",
                          style: GoogleFonts.poppins(
                            color: Color(0xFF37B874),
                            fontSize: 36,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          "/${subscription['limit']}",
                          style: GoogleFonts.poppins(
                            color: Color(0xFF174D31),
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Text(
                      "What’s included",
                      style: GoogleFonts.poppins(
                        color: Color(0xFF3A4C67),
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 15),
                    ...List.generate(
                      (subscription['included'] as List).length,
                      (i) => Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/check.png',
                              width: 24,
                              height: 24,
                            ),
                            SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                "${subscription['included'][i]}",

                                style: GoogleFonts.poppins(
                                  color: Color(0xFF3A4C67),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    GetStartedButton(
                      title: "Get Started",
                      ontap: () {
                        final price = double.parse(
                          subscription['price'].toString(),
                        );
                        debugPrint("Price being passed: $price");

                        StripeService.makePayment(price, "usd");
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
