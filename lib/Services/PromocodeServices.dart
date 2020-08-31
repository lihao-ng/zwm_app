import 'dart:convert';
import 'package:http/http.dart' as Http;

import 'package:zwm_app/Models/Auth.dart';
import 'package:zwm_app/Models/Promocode.dart';
import 'package:zwm_app/Services/Services.dart';

class PromocodeServices extends Services {
  redeem({
    int offerId,
    Function onSuccess,
    Function onError,
  }) {
    var body = jsonEncode({"offer_id": offerId});

    Auth.getInstance(onInstance: (Auth auth) {
      HEADERS["Authorization"] = "Bearer ${auth.accessToken}";

      Http.post("$HOST/promocode/redeem", headers: HEADERS, body: body)
          .then((response) {
        Services.handle(
          response: response,
          valid: (responseBody) {
            Promocode promocode = Promocode.fromJson(responseBody);

            onSuccess(promocode);
          },
          invalid: (message) {
            onError(message);
          },
        );
      });
    });
  }
}
