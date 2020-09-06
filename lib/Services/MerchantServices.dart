import 'dart:convert';

import 'package:http/http.dart' as Http;
import 'package:zwm_app/Models/Auth.dart';
import 'package:zwm_app/Models/Merchant.dart';
import 'package:zwm_app/Services/Services.dart';

class MerchantServices extends Services {
  index({
    String category,
    int page,
    int limit = 10,
    Function onSuccess,
    Function onError,
  }) {
    Auth.getInstance(onInstance: (Auth auth) {
      HEADERS["Authorization"] = "Bearer ${auth.accessToken}";

      Http.get("$HOST/merchants?category=$category&limit=$limit&page=$page",
              headers: HEADERS)
          .then((response) {
        Services.handle(
          response: response,
          valid: (responseBody) {
            Iterable responseItems = responseBody['data'];
            List<Merchant> merchants =
                responseItems.map((item) => Merchant.fromJson(item)).toList();

            onSuccess(merchants, responseBody['current_page']);
          },
          invalid: (message) {
            onError(message);
          },
        );
      });
    });
  }

  nearby({
    int lat,
    int lng,
    String categories,
    Function onSuccess,
    Function onError,
  }) {
    var body = jsonEncode({"lat": lat, "lng": lng, "categories": categories});

    Auth.getInstance(onInstance: (Auth auth) {
      HEADERS["Authorization"] = "Bearer ${auth.accessToken}";

      Http.post("$HOST/merchants/nearby", headers: HEADERS, body: body)
          .then((response) {
        Services.handle(
          response: response,
          valid: (responseBody) {
            Iterable responseItems = responseBody['data'];
            List<Merchant> offers =
                responseItems.map((item) => Merchant.fromJson(item)).toList();

            onSuccess(offers, responseBody['current_page']);
          },
          invalid: (message) {
            onError(message);
          },
        );
      });
    });
  }
}
