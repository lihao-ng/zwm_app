import 'dart:convert';
import 'package:http/http.dart' as Http;
import 'package:zwm_app/Models/Auth.dart';
import 'package:zwm_app/Services/Permissions/Services.dart';

class AuthServices extends Services {
  register({
    String email,
    String password,
    Function onSuccess,
    Function onError,
  }) {
    var body = jsonEncode({"email": email, "password": password});

    Http.post("$HOST/register", headers: HEADERS, body: body).then((response) {
      int statusCode = response.statusCode;
      var responseBody = jsonDecode(response.body);
      if (statusCode == 200) {
        token(
          grantType: "password",
          email: email,
          password: password,
          onSuccess: onSuccess,
          onError: onError,
        );
        return;
      }
      onError(responseBody);
    });
  }

  login({String email, String password, Function onSuccess, Function onError}) {
    token(
      email: email,
      password: password,
      onSuccess: onSuccess,
      onError: onError,
    );
  }

  token({
    String grantType,
    String email,
    String password,
    Function onSuccess,
    Function onError,
  }) {
    var body = jsonEncode({
      "email": email,
      "password": password,
    });

    Http.post("$HOST/login", headers: HEADERS, body: body).then((response) {
      int statusCode = response.statusCode;
      var responseBody = json.decode(response.body);

      if (statusCode == 200) {
        Auth auth = Auth.fromJson(responseBody);
        auth.save();

        onSuccess();
        return;
      }

      onError(responseBody['message']);
    });
  }
}
