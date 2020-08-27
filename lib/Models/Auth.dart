import 'package:json_annotation/json_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

@JsonSerializable()
class Auth {
  String accessToken;

  String expiresAt;

  int userId;
  String firstName;

  String lastName;

  Auth({
    this.accessToken,
    this.expiresAt,
    this.userId,
    this.firstName,
    this.lastName,
  });

  Auth.fromJson(Map<String, dynamic> data)
      : accessToken = data['access_token'],
        this.expiresAt = data['expires_at'],
        this.userId = data['user_id'],
        this.firstName = data['first_name'],
        this.lastName = data['last_name'];

  Future save() async {
    final prefs = await SharedPreferences.getInstance();

    prefs.setString('access_token', accessToken);
    prefs.setString('expires_at', expiresAt);
    prefs.setInt('user_id', userId);
    prefs.setString('first_name', firstName);
    prefs.setString('last_name', lastName);
  }

  void getToken({String type = "access_token", Function onValue}) {
    SharedPreferences.getInstance().then((instance) {
      onValue(instance.getString(type));
    });
  }

  static void getInstance({Function onInstance}) async {
    final prefs = await SharedPreferences.getInstance();

    String accessToken = prefs.getString("access_token");
    String expiresAt = prefs.getString("expires_at");
    int userId = prefs.getInt("user_id");
    String firstName = prefs.getString("first_name");
    String lastName = prefs.getString("last_name");

    Auth auth = Auth(
      accessToken: accessToken,
      expiresAt: expiresAt,
      userId: userId,
      firstName: firstName,
      lastName: lastName,
    );

    onInstance(auth);
  }

  static void erase({Function done}) {
    SharedPreferences.getInstance().then((instance) {
      instance.remove("access_token");
      instance.remove("refresh_token");
      instance.remove("expires_in");
      done();
    });
  }
}
