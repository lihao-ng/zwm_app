import 'package:http/http.dart' as Http;

import 'package:zwm_app/Models/Auth.dart';
import 'package:zwm_app/Models/Product.dart';

import 'package:zwm_app/Services/Services.dart';

class ProductServices extends Services {
  index({
    String search,
    int limit,
    Function onSuccess,
    Function onError,
  }) {
    Auth.getInstance(onInstance: (Auth auth) {
      HEADERS["Authorization"] = "Bearer ${auth.accessToken}";

      Http.get("$HOST/products/search?limit=$limit&search=$search",
              headers: HEADERS)
          .then((response) {
        Services.handle(
          response: response,
          valid: (responseBody) {
            Iterable responseItems = responseBody;
            List<Product> products =
                responseItems.map((item) => Product.fromJson(item)).toList();

            onSuccess(products);
          },
          invalid: (message) {
            onError(message);
          },
        );
      });
    });
  }
}
