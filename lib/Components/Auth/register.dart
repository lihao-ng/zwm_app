import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:zwm_app/Animations/FadeAnimation.dart';
import 'package:zwm_app/Components/Buttons/PrimaryButton.dart';
import 'package:zwm_app/Components/Inputs/InputField.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final genderController = TextEditingController();
  final passwordController = TextEditingController();
  final rePasswordController = TextEditingController();

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    genderController.dispose();
    passwordController.dispose();
    rePasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).accentColor,
        iconTheme: IconThemeData(
          color: Theme.of(context).primaryColor,
        ),
        title: Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            shape: BoxShape.circle,
          ),
          child: Icon(
            MaterialCommunityIcons.leaf,
            color: Theme.of(context).accentColor,
            size: 28,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              FadeAnimation(
                1,
                RichText(
                  text: TextSpan(
                    style: Theme.of(context).textTheme.headline1,
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
                  style: Theme.of(context).textTheme.caption,
                ),
              ),
              SizedBox(height: 25),
              FadeAnimation(
                1.5,
                InputField(
                  hintText: "Your first name",
                  controller: firstNameController,
                  prefixIcon:
                      Icon(MaterialCommunityIcons.format_letter_case_upper),
                ),
              ),
              SizedBox(height: 20),
              FadeAnimation(
                1.7,
                InputField(
                  hintText: "Your last name",
                  controller: lastNameController,
                  prefixIcon:
                      Icon(MaterialCommunityIcons.format_letter_case_lower),
                ),
              ),
              SizedBox(height: 20),
              FadeAnimation(
                1.9,
                InputField(
                  hintText: "Your email",
                  controller: emailController,
                  prefixIcon: Icon(Icons.mail),
                ),
              ),
              SizedBox(height: 20),
              FadeAnimation(
                2.1,
                InputField(
                  hintText: "Gender",
                  controller: genderController,
                  prefixIcon: Icon(MaterialCommunityIcons.gender_male_female),
                ),
              ),
              SizedBox(height: 20),
              FadeAnimation(
                2.3,
                InputField(
                  hintText: "Your password",
                  obscureText: true,
                  controller: passwordController,
                  prefixIcon: Icon(Icons.lock),
                ),
              ),
              SizedBox(height: 20),
              FadeAnimation(
                2.4,
                InputField(
                  hintText: "Re-type your password",
                  controller: rePasswordController,
                  prefixIcon: Icon(Icons.lock),
                ),
              ),
              SizedBox(height: 40),
              FadeAnimation(
                2.6,
                primaryButton(
                  text: 'Sign Up',
                  color: Theme.of(context).primaryColor,
                  style: Theme.of(context).textTheme.button,
                  onClick: () {
                    // emailController.text
                    // get value, register and request for auth

                    // Navigator.pushReplacementNamed(context, '/home');
                    Navigator.pushNamed(context, '/home');
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
