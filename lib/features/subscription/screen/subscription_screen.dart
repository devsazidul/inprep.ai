import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inprep_ai/features/subscription/controller/subscription_controller.dart' show SubscriptionController;
import 'package:inprep_ai/features/subscription/widgets/subscription_list.dart' show SubscriptionList;

class SubscriptionScreen extends StatelessWidget {
   SubscriptionScreen({super.key});

  final SubscriptionController controller = Get.put(SubscriptionController()); 
  
  
  
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size.width * 0.03;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
          left: size, 
          right: size, 
          top: 65, 
          bottom: 15, 
        ),
        child: Center(
          child: Column(
            children: [
              Text("Choose Your Plan", 
                style: GoogleFonts.poppins(
                  fontSize: 24, 
                  color: Color(0xFF212121), 
                  fontWeight: FontWeight.w600,
                ),
              ), 
              SizedBox(
                height: 20,
              ), 
              SubscriptionList(), 
            ],
          ),
        ),
      ),
    );
  }
}