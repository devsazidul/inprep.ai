import 'package:flutter/material.dart';
import 'package:inprep_ai/app.dart';
import 'package:inprep_ai/features/subscription/service/stripe_service.dart' show StripeService;

void main() async {
  runApp(const Inprepai());
   await StripeService.init();
}
