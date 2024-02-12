import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:payment_history_task/model/login_request.dart';

import '../model/login_response.dart';

class LoginService {
  static Future<LoginResponse?> fetch(LoginRequest request) async {
    final url = Uri.parse('https://back.intalim.uz/v2/api/login');
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(
          {
            'username': request.username,
            'password': request.password,
          },
        ),
      );
      if (response.statusCode == 200) {
        return LoginResponse.fromJson(json.decode(response.body));
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
