import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:payment_history_task/provider/login_provider.dart';

import '../model/payment_history.dart';
import 'constants/base_url.dart';

class PaymentHistoryService {
  static Future<PaymentHistory?> getByPage(String token, int page,
      {String? fio}) async {
    String searchParam = '';
    if (fio != null) {
      searchParam = '&fio=$fio';
    }
    final url =
        Uri.parse('$baseUrl/get-payment-history?page=$page$searchParam');
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
