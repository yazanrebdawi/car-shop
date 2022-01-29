// ignore_for_file: prefer_const_constructors, deprecated_member_use, use_key_in_widget_constructors, unnecessary_new, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/auth/auth.dart';
import 'package:shopapp/auth/auth_controller.dart';
import 'package:shopapp/homepage/homepage_contoller.dart';

import 'add_Car/add_Car_controler.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<AuthController>(
        create: (_) => AuthController(),
      ),
      ChangeNotifierProvider<HomePageController>(
        create: (_) => HomePageController(),
      ),
      ChangeNotifierProvider<AddProductController>(
        create: (_) => AddProductController(),
      ),
    ],
    child: Myapp(),
  ));
}

class Myapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primaryColor: Colors.orange[900],
          canvasColor: Color.fromRGBO(255, 238, 219, 1)),
      debugShowCheckedModeBanner: false,
      home: Auth(),
    );
  }
}
