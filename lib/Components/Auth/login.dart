import 'package:flutter/material.dart';

import 'package:zwm_app/Animations/FadeAnimation.dart';

import 'package:zwm_app/Components/Widgets/Buttons/PrimaryButton.dart';
import 'package:zwm_app/Components/Widgets/Buttons/SecondaryButton.dart';
import 'package:zwm_app/Components/Widgets/Inputs/InputField.dart';
import 'package:zwm_app/Services/AuthServices.dart';
import 'package:zwm_app/utils.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, String> _formData = {};

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    Size _size = MediaQuery.of(context).size;

    void onSubmit() {
      if (!_formKey.currentState.validate()) {
        return;
      }

      _formKey.currentState.save();

      processingDialog(context);

      AuthServices().login(
        email: _formData["email"],
        password: _formData["password"],
        onSuccess: () {
          Navigator.of(context).pushNamedAndRemoveUntil(
            '/nav',
            (Route<dynamic> route) => false,
          );
        },
        onError: (response) {
          Navigator.of(context).pop();
          errorAlert(
            context,
            title: "An error has occured!",
            body: response,
          );
        },
      );
    }

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                FadeAnimation(
                  1,
                  Container(
                    height: 0.35 * _size.height,
                    width: double.infinity,
                    child: Image.asset(
                      'assets/images/background4.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  child: Column(
                    children: <Widget>[
                      FadeAnimation(
                        1.5,
                        Text(
                          'Login',
                          style: Theme.of(context).textTheme.headline1,
                        ),
                      ),
                      SizedBox(height: 20),
                      FadeAnimation(
                        1.7,
                        InputField(
                          hintText: "Your email",
                          prefixIcon: Icon(Icons.mail),
                          saved: (String value) {
                            _formData['email'] = value;
                          },
                        ),
                      ),
                      SizedBox(height: 20),
                      FadeAnimation(
                        1.7,
                        InputField(
                          hintText: "Your password",
                          obscureText: true,
                          prefixIcon: Icon(Icons.lock),
                          saved: (String value) {
                            _formData['password'] = value;
                          },
                        ),
                      ),
                      SizedBox(height: 40),
                      FadeAnimation(
                        1.7,
                        primaryButton(
                          text: 'Login',
                          color: Theme.of(context).primaryColor,
                          style: Theme.of(context).textTheme.button,
                          onClick: () {
                            onSubmit();
                          },
                        ),
                      ),
                      SizedBox(height: 15),
                      FadeAnimation(
                        2,
                        secondaryButton(
                          text: 'Create Account',
                          color: _theme.primaryColor,
                          style: _theme.textTheme.button,
                          onClick: () {
                            Navigator.pushNamed(context, '/register');
                          },
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
