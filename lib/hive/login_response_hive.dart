import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class LoginResponseHive extends HiveObject {
  @HiveField(0)
  int? status;
  @HiveField(1)
  String? accessToken;
  @HiveField(2)
  String? tokenType;
  @HiveField(3)
  int? expiresIn;

  LoginResponseHive({
    required this.status,
    required this.accessToken,
    required this.tokenType,
    required this.expiresIn,
  });
}
