import 'dart:convert';

import 'package:http/http.dart' as Http;
import 'package:zwm_app/Models/Auth.dart';
import 'package:zwm_app/Models/Merchant.dart';
import 'package:zwm_app/Services/Services.dart';

class MerchantServices extends Services {
  index({
    List<String> categories,
    String search,
    int page,
    int limit = 10,
    Function onSuccess,
    Function onError,
  }) {
    var body = jsonEncode({
      "categories": categories,
      "search": search,
      "limit": limit,
      "page": page
    });

    Auth.getInstance(onInstance: (Auth auth) {
      HEADERS["Authorization"] = "Bearer ${auth.accessToken}";

      Http.post("$HOST/merchants", headers: HEADERS, body: body)
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
            print(message);
            onError(message);
          },
        );
      });
    });
  }

  show({
    int id,
    Function onSuccess,
    Function onError,
  }) {
    Auth.getInstance(onInstance: (Auth auth) {
      HEADERS["Authorization"] = "Bearer ${auth.accessToken}";

      Http.get("$HOST/merchants/$id", headers: HEADERS).then((response) {
        Services.handle(
          response: response,
          valid: (responseBody) {
            Merchant merchant = Merchant.fromJson(responseBody);

            onSuccess(merchant);
          },
          invalid: (message) {
            onError(message);
          },
        );
      });
    });
  }

  nearby({
    double lat,
    double lng,
    List<String> categories,
    Function onSuccess,
    Function onError,
  }) {
    var body = jsonEncode({
      "lat": lat,
      "lng": lng,
      "categories": categories,
    });

    Auth.getInstance(onInstance: (Auth auth) {
      HEADERS["Authorization"] = "Bearer ${auth.accessToken}";

      Http.post("$HOST/merchants/nearby", headers: HEADERS, body: body)
          .then((response) {
        Services.handle(
          response: response,
          valid: (responseBody) {
            Iterable responseItems = responseBody;
            List<Merchant> merchants =
                responseItems.map((item) => Merchant.fromJson(item)).toList();
            onSuccess(merchants);
          },
          invalid: (message) {
            print('err :' + message);
            onError(message);
          },
        );
      });
    });
  }
}
