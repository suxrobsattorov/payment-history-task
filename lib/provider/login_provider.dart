import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/login_request.dart';
import '../model/login_response.dart';
import '../service/login_service.dart';

class LoginProvider extends ChangeNotifier {
  LoginResponse? response;

  Future<LoginResponse?> login(LoginRequest request) async {
    await LoginService.fetch(request).then((value) {
      if (value != null) {
        response = value;
        notifyListeners();
      }
    });
    return response;
  }
}

final loginProvider = ChangeNotifierProvider(
  (ref) => LoginProvider(),
);
