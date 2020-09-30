import 'package:http/http.dart' as Http;

import 'package:zwm_app/Models/Auth.dart';
import 'package:zwm_app/Models/Good.dart';

import 'package:zwm_app/Services/Services.dart';

class GoodServices extends Services {
  index({
    int id,
    Function onSuccess,
    Function onError,
  }) {
    Auth.getInstance(onInstance: (Auth auth) {
      HEADERS["Authorization"] = "Bearer ${auth.accessToken}";

      Http.get("$HOST/products/$id", headers: HEADERS).then((response) {
        Services.handle(
          response: response,
          valid: (responseBody) {
            Good good = Good.fromJson(responseBody);

            onSuccess(good);
          },
          invalid: (message) {
            onError(message);
          },
        );
      });
    });
  }
}
