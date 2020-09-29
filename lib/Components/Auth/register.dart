import 'package:flutter/material.dart';

import 'package:flutter_icons/flutter_icons.dart';
import 'package:zwm_app/Animations/FadeAnimation.dart';

import 'package:zwm_app/Components/Widgets/Buttons/PrimaryButton.dart';
import 'package:zwm_app/Components/Widgets/Inputs/InputField.dart';
import 'package:zwm_app/Components/Widgets/AppBar.dart';
import 'package:zwm_app/Services/AuthServices.dart';
import 'package:zwm_app/constants.dart';
import 'package:zwm_app/utils.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, String> _formData = {};

  @override
  void dispose() {
    super.dispose();
  }

  void onSubmit() {
    if (!_formKey.currentState.validate()) {
      return;
    }

    _formKey.currentState.save();

    processingDialog(context);

    AuthServices().register(
      lastName: _formData["first_name"],
      firstName: _formData["last_name"],
      email: _formData["email"],
      gender: _formData["gender"],
      password: _formData["password"],
      passwordConfirmation: _formData["password_confirmation"],
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

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);

    return Scaffold(
      appBar: appBar(),
      backgroundColor: accentColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(30),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                FadeAnimation(
                  1,
                  RichText(
                    text: TextSpan(
                      style: _theme.textTheme.headline1,
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Sign ',
                        ),
                        TextSpan(
                          text: 'Up',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 5),
                FadeAnimation(
                  1.3,
                  Text(
                    'Help the environment while you earn!',
                    style: _theme.textTheme.caption,
                  ),
                ),
                SizedBox(height: 25),
                FadeAnimation(
                  1.5,
                  InputField(
                    hintText: "Your first name",
                    prefixIcon:
                        Icon(MaterialCommunityIcons.format_letter_case_upper),
                    saved: (String value) {
                      _formData['first_name'] = value;
                    },
                  ),
                ),
                SizedBox(height: 20),
                FadeAnimation(
                  1.7,
                  InputField(
                    hintText: "Your last name",
                    prefixIcon:
                        Icon(MaterialCommunityIcons.format_letter_case_lower),
                    saved: (String value) {
                      _formData['last_name'] = value;
                    },
                  ),
                ),
                SizedBox(height: 20),
                FadeAnimation(
                  1.9,
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
                  2.1,
                  DropdownButtonFormField(
                    value: _formData['gender'] == null
                        ? _formData['gender'] = 'Male'
                        : _formData['gender'],
                    onSaved: (value) {
                      setState(() {
                        _formData['gender'] = value;
                      });
                    },
                    onChanged: (value) {
                      setState(() {
                        _formData['gender'] = value;
                      });
                    },
                    onTap: () {
                      FocusManager.instance.primaryFocus.unfocus();
                    },
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: captionColor, width: 1.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: primaryColor, width: 1.0),
                      ),
                      prefixIcon:
                          Icon(MaterialCommunityIcons.gender_male_female),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: paddingLarge),
                      border: InputBorder.none,
                    ),
                    items: [
                      DropdownMenuItem<String>(
                        child: Text("Male"),
                        value: 'Male',
                      ),
                      DropdownMenuItem<String>(
                        child: Text("Female"),
                        value: 'Female',
                      )
                    ],
                  ),
                ),
                SizedBox(height: 20),
                FadeAnimation(
                  2.3,
                  InputField(
                    hintText: "Your password",
                    obscureText: true,
                    prefixIcon: Icon(Icons.lock),
                    saved: (String value) {
                      _formData['password'] = value;
                    },
                  ),
                ),
                SizedBox(height: 20),
                FadeAnimation(
                  2.4,
                  InputField(
                    hintText: "Re-type your password",
                    obscureText: true,
                    prefixIcon: Icon(Icons.lock),
                    saved: (String value) {
                      _formData['password_confirmation'] = value;
                    },
                  ),
                ),
                SizedBox(height: 40),
                FadeAnimation(
                  2.6,
                  primaryButton(
                    text: 'Sign Up',
                    color: _theme.primaryColor,
                    style: _theme.textTheme.button,
                    onClick: () {
                      onSubmit();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
