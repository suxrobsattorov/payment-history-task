import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:payment_history_task/model/login_request.dart';

import '../model/login_response.dart';
import '../model/payment_history.dart';

class PaymentHistoryService {
  static Future<PaymentHistory?> fetch(LoginResponse loginResponse) async {
    final url = Uri.parse('https://back.intalim.uz/v2/api/get-payment-history');
    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization':
              '${loginResponse.tokenType} ${loginResponse.accessToken}',
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

  static Future<PaymentHistory?> getByPage(
      LoginResponse loginResponse, int page) async {
    final url = Uri.parse(
        'https://back.intalim.uz/v2/api/get-payment-history?page=$page');
    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization':
              '${loginResponse.tokenType} ${loginResponse.accessToken}',
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
