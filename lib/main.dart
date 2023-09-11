import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:stripe_app/stripe_app.dart';

void main() async {
  await dotenv.load();
  Stripe.publishableKey = dotenv.env['STRIPE_PUBLISHABLE'] ?? '';
  runApp(const StripeApp());
}
