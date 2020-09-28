import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:zwm_app/Components/Widgets/AppBar.dart';

import 'package:zwm_app/Components/Widgets/Buttons/PrimaryButton.dart';
import 'package:zwm_app/Components/Widgets/Inputs/InputField.dart';
import 'package:zwm_app/Models/Auth.dart';
import 'package:zwm_app/Services/AuthServices.dart';
import 'package:zwm_app/Utils/keys.dart';
import 'package:zwm_app/constants.dart';
import 'package:zwm_app/utils.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final Map<String, String> _formData = {};
  Auth _auth = Auth();

  double _height = MediaQuery.of(Keys.navKey.currentContext).size.height / 2.5;

  TabController _tabController;

  _loadAccount() {
    Auth.getInstance(onInstance: (Auth auth) {
      setState(() {
        _auth = auth;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _loadAccount();
    _tabController = new TabController(length: 2, vsync: this);

    _tabController.addListener(() {
      setState(() {
        if (_tabController.index == 0) {
          _height = MediaQuery.of(context).size.height / 2.5;
        } else {
          _height = 120;
        }
      });
    });
  }

  _onSubmit() {
    if (!_formKey.currentState.validate()) {
      return;
    }

    _formKey.currentState.save();

    processingDialog(context);

    // AuthServices().login(
    //   email: _formData["email"],
    //   password: _formData["password"],
    //   onSuccess: () {
    //     Navigator.of(context).pushNamedAndRemoveUntil(
    //       '/nav',
    //       (Route<dynamic> route) => false,
    //     );
    //   },
    //   onError: (response) {
    //     Navigator.of(context).pop();
    //     errorAlert(
    //       context,
    //       title: "An error has occured!",
    //       body: response,
    //     );
    //   },
    // );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    Size _size = MediaQuery.of(context).size;

    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: appBar(),
        body: _auth.accessToken != null
            ? SafeArea(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: paddingMid),
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 40),
                        Stack(
                          overflow: Overflow.visible,
                          children: [
                            SizedBox(
                              height: 170,
                              width: _size.width,
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    left: paddingMid,
                                    right: paddingMid,
                                    top: paddingMid,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            'Total Points: ',
                                            style: _theme.textTheme.caption
                                                .copyWith(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            _auth.totalPoints.toString(),
                                            style: _theme.textTheme.bodyText1
                                                .copyWith(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(height: spacingLarge),
                                      Padding(
                                        padding: EdgeInsets.only(left: 15),
                                        child: Text(
                                          _auth.firstName +
                                              ' ' +
                                              _auth.lastName,
                                          style: _theme.textTheme.headline3,
                                        ),
                                      ),
                                      SizedBox(height: spacingSmall),
                                      Padding(
                                        padding: EdgeInsets.only(left: 15),
                                        child: Text(
                                          'nglihao98@gmail.com',
                                          style:
                                              _theme.textTheme.caption.copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Center(
                                        child: DefaultTabController(
                                          length: 2,
                                          child: TabBar(
                                            controller: _tabController,
                                            isScrollable: true,
                                            labelColor: primaryColor,
                                            labelStyle: TextStyle(
                                                fontWeight: FontWeight.bold),
                                            unselectedLabelColor: captionColor,
                                            indicatorPadding: EdgeInsets.only(
                                                left: 30, right: 30),
                                            indicator: BoxDecoration(
                                              border: Border(
                                                bottom: BorderSide(
                                                  color: primaryColor,
                                                  width: 3.0,
                                                ),
                                              ),
                                            ),
                                            tabs: [
                                              Tab(
                                                text: 'Summary',
                                              ),
                                              Tab(
                                                text: 'Settings',
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: -30,
                              left: 25,
                              child: CircleAvatar(
                                radius: 40,
                                backgroundImage: AssetImage(
                                  'assets/images/home_bg.jpg',
                                ),
                              ),
                            ),
                          ],
                        ),
                        AnimatedContainer(
                          height: _height,
                          duration: Duration(milliseconds: 500),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(paddingLarge),
                              child: TabBarView(
                                controller: _tabController,
                                children: <Widget>[
                                  Center(
                                    child: ListView(
                                      children: [
                                        InputField(
                                          hintText: "Your first name",
                                          prefixIcon: Icon(
                                              MaterialCommunityIcons
                                                  .format_letter_case_upper),
                                          initialValue: _auth.firstName,
                                          saved: (String value) {
                                            _formData['first_name'] = value;
                                          },
                                        ),
                                        SizedBox(height: 20),
                                        InputField(
                                          hintText: "Your last name",
                                          initialValue: _auth.lastName,
                                          prefixIcon: Icon(
                                              MaterialCommunityIcons
                                                  .format_letter_case_lower),
                                          saved: (String value) {
                                            _formData['last_name'] = value;
                                          },
                                        ),
                                        SizedBox(height: 20),
                                        InputField(
                                          hintText: "Your password",
                                          obscureText: true,
                                          prefixIcon: Icon(Icons.lock),
                                          saved: (String value) {
                                            _formData['password'] = value;
                                          },
                                        ),
                                        SizedBox(height: 20),
                                        InputField(
                                          hintText: "Re-type your password",
                                          obscureText: true,
                                          prefixIcon: Icon(Icons.lock),
                                          saved: (String value) {
                                            _formData['password_confirmation'] =
                                                value;
                                          },
                                        ),
                                        SizedBox(height: spacingMid),
                                        primaryButton(
                                          text: 'Update',
                                          color: _theme.primaryColor,
                                          style: _theme.textTheme.button,
                                          onClick: () {
                                            _onSubmit();
                                          },
                                        ),
                                        SizedBox(height: spacingSmall)
                                      ],
                                    ),
                                  ),
                                  Center(
                                    child: primaryButton(
                                      text: 'Log Out',
                                      color: Colors.red[700],
                                      style: _theme.textTheme.button,
                                      onClick: () {
                                        Auth.erase();
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : Center(
                child: SpinKitPouringHourglass(
                  color: Theme.of(context).primaryColor,
                  size: 50.0,
                ),
              ));
  }
}
