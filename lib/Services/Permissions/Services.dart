import 'package:flutter_dotenv/flutter_dotenv.dart';

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
}
