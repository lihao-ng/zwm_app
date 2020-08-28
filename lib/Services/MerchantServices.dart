import 'package:http/http.dart' as Http;
import 'package:zwm_app/Models/Auth.dart';
import 'package:zwm_app/Services/Services.dart';

class MerchantServices extends Services {
  index({
    Function onSuccess,
    Function onError,
  }) {
    // ?category=Plastic
    Auth.getInstance(onInstance: (Auth auth) {
      HEADERS["Authorization"] = "Bearer ${auth.accessToken}";

      Http.get("$HOST/guides", headers: HEADERS).then((response) {
        Services.handle(
          response: response,
          valid: (responseBody) {
            print(responseBody);

            onSuccess();
          },
          invalid: (message) {
            onError(message);
          },
        );
      });
    });
  }
}
