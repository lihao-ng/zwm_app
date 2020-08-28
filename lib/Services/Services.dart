import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';
import 'package:zwm_app/Models/Auth.dart';

class Services {
  final String HOST = DotEnv().env['APP_URL'];
  final String CLIENT_ID = DotEnv().env['API_CLIENT_ID'];
  final String CLIENT_SECRET = DotEnv().env['API_CLIENT_SECRET'];

  final Map<String, String> HEADERS = {
    "Content-Type": "application/json",
    "Accept": "application/json",
    "client-id": DotEnv().env['API_CLIENT_ID'],
    "client-secret": DotEnv().env['API_CLIENT_SECRET']
  };

  static void handle({Response response, Function valid, Function invalid}) {
    int statusCode = response.statusCode;

    switch (statusCode) {
      case 404:
        invalid('An unknown error has occured.');
        break;

      case 401:
        Auth.erase();
        break;

      case 200:
        valid(json.decode(response.body));
        break;

      default:
        invalid(json.decode(response.body)['message']);
        break;
    }
  }
}
