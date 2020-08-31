import 'package:http/http.dart' as Http;
import 'package:zwm_app/Models/Auth.dart';
import 'package:zwm_app/Models/Offer.dart';
import 'package:zwm_app/Services/Services.dart';

class OfferServices extends Services {
  index({
    String type,
    int page,
    int limit = 10,
    Function onSuccess,
    Function onError,
  }) {
    // ?type=promo / accepting items
    Auth.getInstance(onInstance: (Auth auth) {
      HEADERS["Authorization"] = "Bearer ${auth.accessToken}";

      Http.get("$HOST/offers?type=$type&limit=$limit&page=$page",
              headers: HEADERS)
          .then((response) {
        Services.handle(
          response: response,
          valid: (responseBody) {
            Iterable responseItems = responseBody['data'];
            List<Offer> offers =
                responseItems.map((item) => Offer.fromJson(item)).toList();

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
