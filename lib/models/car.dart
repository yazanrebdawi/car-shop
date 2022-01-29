// ignore_for_file: non_constant_identifier_names, deprecated_member_use, avoid_print, use_rethrow_when_possible

import 'package:flutter/cupertino.dart';

class Car {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;

  Car({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
  });
}
