import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';

class AuthController with ChangeNotifier {
  List<User> userList = [];

  Future<void> authantication(
      String email, String password, String urlSegment) async {
    String url =
        "https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=AIzaSyBeeQ1nt3nHA91QPNQ9sL9p0sUWWDsztzU";
    try {
      final res = await http.post(Uri.parse(url),
          body: jsonEncode({
            'email': email,
            'password': password,
            'returnSecureToken': true
          }));
      final resData = jsonDecode(res.body);
      if (resData['error'] != null) {
        throw '${resData['error']['massage']}';
      }
    } catch (error) {
      throw error;
    }
  }

  Future<void> singUp(String email, String password) async {
    return authantication(email, password, "signUp");
  }

  Future<void> logIn(String email, String password) async {
    return authantication(email, password, "signInWithPassword");
  }
}
