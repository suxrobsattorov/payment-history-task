import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/search_data.dart';
import 'constants/base_url.dart';

class PaymentHistoryService {
  static Future<SearchData?> getByPage(
      String token, int page, String fio) async {
    final url = Uri.parse(
        '$baseUrl/school-payment/debtors-v2?page=$page&fio=$fio');
    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'bearer $token',
        },
      );
      if (response.statusCode == 200) {
        return SearchData.fromJson(json.decode(response.body));
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
