import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

enum ApiServiceMethodType {
  get,
  post,
}

const baseUrl = 'https://api.stripe.com/v1';
final Map<String, String> requestHeaders = {
  'Content-Type': 'application/x-www-form-urlencoded',
  'Authorization': 'Bearer ${dotenv.env['STRIPE_PRIVATE_KEY']}',
};

Future<Map<String, dynamic>?> apiService({
  required ApiServiceMethodType requestMethod,
  required String endpoint,
  Map<String, dynamic>? requestBody,
}) async {
  final requestUrl = '$baseUrl/$endpoint';

  // +++++++++++++++++
  // ++ GET REQUEST ++
  // +++++++++++++++++

  if (requestMethod == ApiServiceMethodType.get) {
    try {
      final requestResponse = await http.get(
        Uri.parse(requestUrl),
        headers: requestHeaders,
      );

      return json.decode(requestResponse.body);
    } catch (err) {
      debugPrint("Error: $err");
    }
  }

  // ++++++++++++++++++
  // ++ POST REQUEST ++
  // ++++++++++++++++++

  try {
    final requestResponse = await http.post(
      Uri.parse(requestUrl),
      headers: requestHeaders,
      body: requestBody,
    );

    return json.decode(requestResponse.body);
  } catch (err) {
    debugPrint("Error: $err");
  }
  return null;
}
