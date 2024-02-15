import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/payment_history.dart';

class PaymentHistoryService {
  static Future<PaymentHistory?> getByPage(String token, int page) async {
    final url = Uri.parse(
        'https://back.intalim.uz/v2/api/get-payment-history?page=$page');
    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'bearer $token',
        },
      );
      if (response.statusCode == 200) {
        return PaymentHistory.fromJson(json.decode(response.body));
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
