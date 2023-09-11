import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:stripe_app/shared/utils/api_service.dart';

// +++++++++++++++++++++++++++++++++++
// ++ STRIPE PAYMENT INITIALIZATION ++
// +++++++++++++++++++++++++++++++++++

Future<void> init() async {
  Map<String, dynamic> customer = await createCustomer();
  Map<String, dynamic> paymentIntent = await createPaymentIntent(
    customer['id'],
  );
  await createCreditCard(customer['id'], paymentIntent['client_secret']);
  Map<String, dynamic> customerPaymentMethods =
      await getCustomerPaymentMethods(customer['id']);

  await createSubscription(
    customer['id'],
    customerPaymentMethods['data'][0]['id'],
  );
}

// +++++++++++++++++++++
// ++ CREATE CUSTOMER ++
// +++++++++++++++++++++

Future<Map<String, dynamic>> createCustomer() async {
  final customerCreationResponse = await apiService(
    endpoint: 'customers',
    requestMethod: ApiServiceMethodType.post,
    requestBody: {
      'name': 'Gabriel Parada',
      'email': 'gparada@demo.com',
      'description': 'Flutter created',
    },
  );

  return customerCreationResponse!;
}

// ++++++++++++++++++++++++++
// ++ SETUP PAYMENT INTENT ++
// ++++++++++++++++++++++++++

Future<Map<String, dynamic>> createPaymentIntent(String customerId) async {
  final paymentIntentCreationResponse = await apiService(
    requestMethod: ApiServiceMethodType.post,
    endpoint: 'setup_intents',
    requestBody: {
      'customer': customerId,
      'automatic_payment_methods[enabled]': 'true',
    },
  );

  return paymentIntentCreationResponse!;
}

// ++++++++++++++++++++++++
// ++ CREATE CREDIT CARD ++
// ++++++++++++++++++++++++

Future<void> createCreditCard(
  String customerId,
  String paymentIntentClientSecret,
) async {
  await Stripe.instance.initPaymentSheet(
    paymentSheetParameters: SetupPaymentSheetParameters(
      primaryButtonLabel: 'Subscribe \$10.00',
      style: ThemeMode.light,
      merchantDisplayName: 'Flutter Stripe Store Demo',
      customerId: customerId,
      setupIntentClientSecret: paymentIntentClientSecret,
    ),
  );

  await Stripe.instance.presentPaymentSheet();
}

// +++++++++++++++++++++++++++++++++
// ++ GET CUSTOMER PAYMENT METHOD ++
// +++++++++++++++++++++++++++++++++

Future<Map<String, dynamic>> getCustomerPaymentMethods(
  String customerId,
) async {
  final customerPaymentMethodsResponse = await apiService(
    endpoint: 'customers/$customerId/payment_methods',
    requestMethod: ApiServiceMethodType.get,
  );

  return customerPaymentMethodsResponse!;
}

// +++++++++++++++++++++++++
// ++ CREATE SUBSCRIPTION ++
// +++++++++++++++++++++++++

Future<Map<String, dynamic>> createSubscription(
  String customerId,
  String paymentId,
) async {
  final subscriptionCreationResponse = await apiService(
    endpoint: 'subscriptions',
    requestMethod: ApiServiceMethodType.post,
    requestBody: {
      'customer': customerId,
      'items[0][price]': 'price_1NojJ1KrqRuPS2YbTpBkdn6O',
      'default_payment_method': paymentId,
    },
  );

  return subscriptionCreationResponse!;
}
