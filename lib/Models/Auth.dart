import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zwm_app/Utils/keys.dart';

class Auth {
  String accessToken, expiresAt, firstName, lastName, code, qrCode, email;
  int userId, totalPoints, currentPoints;

  Auth({
    this.accessToken,
    this.expiresAt,
    this.userId,
    this.firstName,
    this.lastName,
    this.email,
    this.totalPoints,
    this.currentPoints,
    this.code,
    this.qrCode,
  });

  Auth.fromJson(Map<String, dynamic> data)
      : this.accessToken = data['access_token'],
        this.expiresAt = data['expires_at'],
        this.userId = data['user_id'],
        this.firstName = data['first_name'],
        this.lastName = data['last_name'],
        this.email = data['email'],
        this.totalPoints = data['total_points'],
        this.currentPoints = data['current_points'],
        this.code = data['code'],
        this.qrCode = data['qr_code'];

  save() async {
    final prefs = await SharedPreferences.getInstance();

    prefs.setString('access_token', accessToken);
    prefs.setString('expires_at', expiresAt);
    prefs.setInt('user_id', userId);
    prefs.setString('first_name', firstName);
    prefs.setString('last_name', lastName);
    prefs.setString('email', email);
    prefs.setInt('total_points', totalPoints);
    prefs.setInt('current_points', currentPoints);
    prefs.setString('code', code);
    prefs.setString('qr_code', qrCode);
  }

  void getToken({String type = "access_token", Function onValue}) {
    SharedPreferences.getInstance().then((instance) {
      onValue(instance.getString(type));
    });
  }

  static void updateAccount({firstName, lastName}) async {
    final prefs = await SharedPreferences.getInstance();

    prefs.setString('first_name', firstName);
    prefs.setString('last_name', lastName);
  }

  static void updatePoints({totalPoints, currentPoints}) async {
    final prefs = await SharedPreferences.getInstance();

    prefs.setInt('total_points', totalPoints);
    prefs.setInt('current_points', currentPoints);
  }

  static void getInstance({Function onInstance}) async {
    final prefs = await SharedPreferences.getInstance();

    String accessToken = prefs.getString("access_token");
    String expiresAt = prefs.getString("expires_at");
    int userId = prefs.getInt("user_id");
    String firstName = prefs.getString("first_name");
    String lastName = prefs.getString("last_name");
    String email = prefs.getString("email");
    int totalPoints = prefs.getInt("total_points");
    int currentPoints = prefs.getInt("current_points");
    String code = prefs.getString("code");
    String qrCode = prefs.getString("qr_code");

    Auth auth = Auth(
        accessToken: accessToken,
        expiresAt: expiresAt,
        userId: userId,
        firstName: firstName,
        lastName: lastName,
        email: email,
        totalPoints: totalPoints,
        currentPoints: currentPoints,
        code: code,
        qrCode: qrCode);

    onInstance(auth);
  }

  static void erase() {
    SharedPreferences.getInstance().then((instance) {
      instance.clear();

      Keys.navKey.currentState.pushNamedAndRemoveUntil(
        '/login',
        (Route<dynamic> route) => false,
      );
    });
  }
}
