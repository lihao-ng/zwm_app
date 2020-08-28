import 'dart:convert';
import 'package:http/http.dart' as Http;
import 'package:zwm_app/Models/Auth.dart';
import 'package:zwm_app/Services/Services.dart';

class AuthServices extends Services {
  register({
    String firstName,
    String lastName,
    String email,
    String gender,
    String password,
    String passwordConfirmation,
    Function onSuccess,
    Function onError,
  }) {
    var body = jsonEncode({
      "first_name": firstName,
      "last_name": lastName,
      "email": email,
      "gender": gender,
      "password": password,
      "password_confirmation": passwordConfirmation,
    });

    Http.post("$HOST/register", headers: HEADERS, body: body).then((response) {
      Services.handle(
        response: response,
        valid: (responseBody) {
          Auth auth = Auth.fromJson(responseBody);
          auth.save();

          onSuccess();
        },
        invalid: (message) {
          onError(message);
        },
      );
    });
  }

  login({String email, String password, Function onSuccess, Function onError}) {
    var body = jsonEncode({
      "email": email,
      "password": password,
    });

    Http.post("$HOST/login", headers: HEADERS, body: body).then((response) {
      Services.handle(
        response: response,
        valid: (responseBody) {
          Auth auth = Auth.fromJson(responseBody);
          auth.save();

          onSuccess();
        },
        invalid: (message) {
          onError(message);
        },
      );
    });
  }
}