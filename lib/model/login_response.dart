class LoginResponse {
  int? status;
  String? accessToken;
  String? tokenType;
  int? expiresIn;

  LoginResponse({
    this.status,
    this.accessToken,
    this.tokenType,
    this.expiresIn,
  });

  LoginResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    accessToken = json['access_token'];
    tokenType = json['token_type'];
    expiresIn = json['expires_in'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['access_token'] = accessToken;
    data['token_type'] = tokenType;
    data['expires_in'] = expiresIn;
    return data;
  }
}
