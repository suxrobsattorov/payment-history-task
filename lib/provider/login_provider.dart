import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

import '../hive/login_response_hive.dart';
import '../model/login_request.dart';
import '../model/login_response.dart';
import '../service/login_service.dart';

class LoginProvider extends ChangeNotifier {
  LoginResponse? response;
  var loginHive = Hive.box('login');

  Future<LoginResponse?> login(LoginRequest request) async {
    await LoginService.fetch(request).then((value) {
      if (value != null) {
        response = value;
        loginHive.add(
          LoginResponseHive(
              status: response!.status,
              accessToken: response!.accessToken,
              tokenType: response!.tokenType,
              expiresIn: response!.expiresIn),
        );
        notifyListeners();
      }
    });
    return response;
  }
}

final loginProvider = ChangeNotifierProvider(
  (ref) => LoginProvider(),
);
