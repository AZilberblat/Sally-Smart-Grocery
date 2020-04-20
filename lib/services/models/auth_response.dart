import 'package:meta/meta.dart';
import 'dart:convert';

class AuthResponse {
  final String accessToken;
  final String tokenType;
  final DateTime expiresAt;
  final String merchantId;
  final String refreshToken;

  AuthResponse({
    @required this.accessToken,
    @required this.tokenType,
    @required this.expiresAt,
    @required this.merchantId,
    @required this.refreshToken,
  });

  factory AuthResponse.fromRawJson(String str) =>
      AuthResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AuthResponse.fromJson(Map<String, dynamic> json) => AuthResponse(
        accessToken: json["access_token"],
        tokenType: json["token_type"],
        expiresAt: DateTime.parse(json["expires_at"]),
        merchantId: json["merchant_id"],
        refreshToken: json["refresh_token"],
      );

  Map<String, dynamic> toJson() => {
        "access_token": accessToken,
        "token_type": tokenType,
        "expires_at": expiresAt.toIso8601String(),
        "merchant_id": merchantId,
        "refresh_token": refreshToken,
      };
}
