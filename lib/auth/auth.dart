// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables, constant_identifier_names, prefer_final_fields, unused_field, unused_element, must_be_immutable, deprecated_member_use, unrelated_type_equality_checks, missing_return, curly_braces_in_flow_control_structures

import 'package:provider/provider.dart';
import 'package:shopapp/auth/auth_controller.dart';
import 'package:shopapp/homepage/homePage.dart';
import 'package:toast/toast.dart';

import 'FeadAnimation.dart';
import 'package:flutter/material.dart';

class Auth extends StatefulWidget {
  @override
  State<Auth> createState() => _AuthState();
}

enum AuthMode { Singup, Singin }

class _AuthState extends State<Auth> {
  final GlobalKey<FormState> _formstyle = GlobalKey();
  AuthMode _authMode = AuthMode.Singin;
  Map<String, String> _authData = {'email': '', 'password': ''};

  var _isLoading = false;

  final _passwordController = TextEditingController();

  void _switchAuthMode() {
    if (_authMode == AuthMode.Singin) {
      setState(() {
        _authMode = AuthMode.Singup;
      });
    } else {
      setState(() {
        _authMode = AuthMode.Singin;
      });
    }
  }

  void _showDailog(String massage) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: Text('An Error Occurred'),
              content: Text(massage),
              actions: [
                FlatButton(
                    child: Text('Ok'), onPressed: () => Navigator.of(ctx).pop())
              ],
            ));
  }

  Future<void> sub() async {
    _formstyle.currentState.save();

    if (!_formstyle.currentState.validate())
      return;
    else {
      try {
        if (_authMode == AuthMode.Singin) {
          await Provider.of<AuthController>(context, listen: false)
              .logIn(_authData['email'], _authData['password']);
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => MyHomePage()));
        } else {
          await Provider.of<AuthController>(context, listen: false)
              .singUp(_authData['email'], _authData['password']);
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => MyHomePage()));
        }
      } catch (error) {
        _showDailog(error);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              gradient: LinearGradient(begin: Alignment.topCenter, colors: [
            Colors.orange[900],
            Colors.orange[800],
            Colors.orange[400]
          ])),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 80,
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    FadeAnimation(
                        1,
                        Image.asset(
                          'asset/images/car3.png',
                          color: Theme.of(context).canvasColor,
                        )),
                    SizedBox(
                      height: 10,
                    ),
                    FadeAnimation(
                        1.3,
                        Text(
                          "Welcome Back",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        )),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(60),
                          topRight: Radius.circular(60))),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.all(30),
                      child: Form(
                        key: _formstyle,
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              height: 10,
                            ),
                            FadeAnimation(
                              1.4,
                              AnimatedContainer(
                                duration: Duration(milliseconds: 300),
                                // height: _authMode == AuthMode.Singin ? 140 : 220,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                          color:
                                              Color.fromRGBO(225, 95, 27, .3),
                                          blurRadius: 20,
                                          offset: Offset(0, 10))
                                    ]),
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                              color: Colors.grey[200]),
                                        ),
                                      ),
                                      child: TextFormField(
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        validator: (val) {
                                          if (val.isEmpty ||
                                              !val.contains('@')) {
                                            return 'Ivalid Email';
                                          }
                                          return null;
                                        },
                                        onSaved: (val) {
                                          _authData['email'] = val;
                                        },
                                        decoration: InputDecoration(
                                          hintText: "Email or Phone number",
                                          hintStyle:
                                              TextStyle(color: Colors.grey),
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.grey[200]))),
                                      child: TextFormField(
                                        controller: _passwordController,
                                        obscureText: true,
                                        validator: (val) {
                                          if (val.isEmpty || val.length < 8) {
                                            return 'Password Valide';
                                          }
                                          return null;
                                        },
                                        onSaved: (val) {
                                          _authData['password'] = val;
                                        },
                                        decoration: InputDecoration(
                                            hintText: "Password",
                                            hintStyle:
                                                TextStyle(color: Colors.grey),
                                            border: InputBorder.none),
                                      ),
                                    ),
                                    if (_authMode == AuthMode.Singup)
                                      AnimatedContainer(
                                        duration: Duration(milliseconds: 300),
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            border: Border(
                                                bottom: BorderSide(
                                                    color: Colors.grey[200]))),
                                        child: TextFormField(
                                          obscureText: true,
                                          validator: (val) {
                                            if (val !=
                                                _passwordController.text) {
                                              return 'Password Valide';
                                            }
                                            return null;
                                          },
                                          onSaved: (val) {
                                            _authData['password'] = val;
                                          },
                                          decoration: InputDecoration(
                                              hintText: "Confirm Password",
                                              hintStyle:
                                                  TextStyle(color: Colors.grey),
                                              border: InputBorder.none),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            FadeAnimation(
                                1.5,
                                FlatButton(
                                  onPressed: () {},
                                  child: Text(
                                    "Forgot Password?",
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                )),
                            SizedBox(
                              height: 20,
                            ),
                            FadeAnimation(
                                1.6,
                                GestureDetector(
                                  onTap: sub,
                                  child: Container(
                                    height: 50,
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 50),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        color: Colors.orange[900]),
                                    child: Center(
                                      child: Text(
                                        _authMode == AuthMode.Singin
                                            ? 'LogIN'
                                            : 'SingUp',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                )),
                            SizedBox(
                              height: 20,
                            ),
                            FadeAnimation(
                                1.5,
                                FlatButton(
                                  onPressed: _switchAuthMode,
                                  child: Text(
                                    '${_authMode == AuthMode.Singin ? 'SingUp' : 'LogIn'}  Instead',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                )),
                            SizedBox(
                              height: 20,
                            ),
                            FadeAnimation(
                                1.7,
                                Text(
                                  "Continue with social media",
                                  style: TextStyle(color: Colors.grey),
                                )),
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: FadeAnimation(
                                      1.8,
                                      GestureDetector(
                                        onTap: () {},
                                        child: Icon(
                                          Icons.facebook,
                                          size: 65,
                                          color: Colors.blue,
                                        ),
                                      )),
                                ),
                                SizedBox(
                                  width: 30,
                                ),
                                Expanded(
                                  child: FadeAnimation(
                                      1.9,
                                      GestureDetector(
                                          onTap: () {},
                                          child: Image.asset(
                                              'asset/images/googlelogo.png'))),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
