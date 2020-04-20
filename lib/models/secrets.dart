import 'package:meta/meta.dart';
import 'dart:async' show Future;
import 'dart:convert' show json;
import 'package:flutter/services.dart' show rootBundle;

class Secret {
  final String appId;
  final String appToken;

  Secret({@required this.appId, @required this.appToken});

  factory Secret.fromJson(Map<String, dynamic> jsonMap) {
    return Secret(
      appId: jsonMap['sandbox_app_id'],
      appToken: jsonMap['sandbox_app_token'],
    );
  }
}

class SecretLoader {
  final String secretPath;

  SecretLoader({@required this.secretPath});

  Future<Secret> load() {
    return rootBundle.loadStructuredData<Secret>(this.secretPath,
        (jsonStr) async {
      final secret = Secret.fromJson(json.decode(jsonStr));
      return secret;
    });
  }
}
