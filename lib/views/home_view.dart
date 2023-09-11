import 'package:flutter/material.dart';

import '../shared/payment_button.dart';
import '../shared/utils/subscription_process.dart';

class HomeView extends StatefulWidget {
  const HomeView({
    super.key,
  });

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter Stripe App')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PaymentButton(
              buttonTitle: "Subscribe",
              onPressed: () => init(),
            ),
          ],
        ),
      ),
    );
  }
}
