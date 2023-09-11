import 'package:flutter/material.dart';
import 'views/home_view.dart';

class StripeApp extends StatelessWidget {
  const StripeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xfff8f7ff),
      ),
      debugShowCheckedModeBanner: false,
      home: const HomeView(),
    );
  }
}
