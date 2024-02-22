import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

import '../hive/login_response_hive.dart';
import '../model/login_request.dart';
import '../model/login_response.dart';
import '../service/login_service.dart';

class LoginProvider extends StateNotifier<LoginResponse?> {
  var loginHive = Hive.box('login');

  String? _token;
  DateTime? _expiryDate;
  Timer? _autoLogoutTimer;

  LoginProvider(super.state);

  bool get isAuth {
    return _token != null;
  }

  String? get token {
    if (_expiryDate != null &&
        DateTime.parse(_expiryDate!.toString()).isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return null;
  }

  Future<LoginResponse?> login(LoginRequest request) async {
    if (loginHive.length > 0) {
      for (int i = 0; i < loginHive.length; i++) {
        loginHive.deleteAt(i);
      }
    }

    await LoginService.fetch(request).then((value) {
      if (value != null) {
        state = value;
        _expiryDate = DateTime.now().add(
          Duration(seconds: state!.expiresIn!),
        );
        _token = state!.accessToken;
        loginHive.add(
          LoginResponseHive(
            status: state!.status,
            accessToken: _token,
            tokenType: state!.tokenType,
            expiresIn: _expiryDate,
          ),
        );
        _autoLogout();
      }
    });

    return state;
  }

  Future<bool> autoLogin() async {
    if (loginHive.values.toList().cast().isEmpty) {
      return false;
    }

    LoginResponseHive hive = loginHive.values.toList().cast()[0];

    if (hive.expiresIn!.isBefore(DateTime.now())) {
      return false;
    }

    _token = hive.accessToken;
    _expiryDate = hive.expiresIn;
    _autoLogout();

    return true;
  }

  void logout() async {
    _token = null;
    _expiryDate = null;

    if (loginHive.length > 0) {
      for (int i = 0; i < loginHive.length; i++) {
        loginHive.deleteAt(i);
      }
    }

    if (_autoLogoutTimer != null) {
      _autoLogoutTimer!.cancel();
      _autoLogoutTimer = null;
    }
  }

  void _autoLogout() {
    if (_autoLogoutTimer != null) {
      _autoLogoutTimer!.cancel();
    }

    final timeToExpiry = _expiryDate!.difference(DateTime.now()).inSeconds;
    _autoLogoutTimer = Timer(Duration(seconds: timeToExpiry), logout);
  }
}

final loginProvider = StateNotifierProvider(
  (ref) => LoginProvider(null),
);
