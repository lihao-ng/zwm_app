import 'dart:convert';

import 'package:http/http.dart' as Http;
import 'package:zwm_app/Models/Auth.dart';
import 'package:zwm_app/Models/Guide.dart';
import 'package:zwm_app/Services/Services.dart';

class GuideServices extends Services {
  index({
    String search,
    String category,
    int page,
    int limit = 10,
    Function onSuccess,
    Function onError,
  }) {
    var body = jsonEncode({
      "search": search,
      "category": category,
      "limit": limit,
      "page": page,
    });

    Auth.getInstance(onInstance: (Auth auth) {
      HEADERS["Authorization"] = "Bearer ${auth.accessToken}";

      Http.post("$HOST/guides", headers: HEADERS, body: body).then((response) {
        Services.handle(
          response: response,
          valid: (responseBody) {
            Iterable responseItems = responseBody['data'];
            List<Guide> guides =
                responseItems.map((item) => Guide.fromJson(item)).toList();

            onSuccess(guides, responseBody['current_page']);
          },
          invalid: (message) {
            onError(message);
          },
        );
      });
    });
  }
}
