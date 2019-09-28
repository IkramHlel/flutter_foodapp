import 'package:flutter/material.dart';

class User {
  final String id;
  final String email;

  User({@required this.id, @required this.email});

  String get getEmail {
    return email;
  }
}