import 'package:hive/hive.dart';

import 'login_response_hive.dart';

class LoginAdapter extends TypeAdapter<LoginResponseHive> {
  @override
  LoginResponseHive read(BinaryReader reader) {
    final status = reader.read() as int?;
    final accessToken = reader.read() as String?;
    final tokenType = reader.read() as String?;
    final expiresIn = reader.read() as int?;

    return LoginResponseHive(
      status: status,
      accessToken: accessToken,
      tokenType: tokenType,
      expiresIn: expiresIn,
    );
  }

  @override
  int get typeId => 0;

  @override
  void write(BinaryWriter writer, LoginResponseHive obj) {
    writer.write(obj.status);
    writer.write(obj.accessToken);
    writer.write(obj.tokenType);
    writer.write(obj.expiresIn);
  }
}
