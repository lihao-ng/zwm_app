import 'package:flutter/material.dart';

import 'package:zwm_app/Animations/FadeAnimation.dart';

import 'package:zwm_app/Components/Widgets/Buttons/PrimaryButton.dart';
import 'package:zwm_app/Components/Widgets/Buttons/SecondaryButton.dart';
import 'package:zwm_app/Components/Widgets/Inputs/InputField.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              FadeAnimation(
                1,
                Container(
                  height: 0.35 * size.height,
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
                        controller: emailController,
                        prefixIcon: Icon(Icons.mail),
                      ),
                    ),
                    SizedBox(height: 20),
                    FadeAnimation(
                      1.7,
                      InputField(
                        hintText: "Your password",
                        obscureText: true,
                        controller: passwordController,
                        prefixIcon: Icon(Icons.lock),
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
                          // emailController.text
                          // get value and request for auth

                          Navigator.pushReplacementNamed(context, '/nav');
                          // Navigator.pushNamed(context, '/nav');
                        },
                      ),
                    ),
                    SizedBox(height: 15),
                    FadeAnimation(
                      2,
                      secondaryButton(
                        text: 'Create Account',
                        color: Theme.of(context).primaryColor,
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
    );
  }
}
