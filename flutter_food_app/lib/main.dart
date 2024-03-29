import 'package:flutter/material.dart';

import './pages/auth.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.green,
        accentColor: Colors.green,
        buttonColor: Colors.green,
      ),
      debugShowCheckedModeBanner: false,
      home: AuthPage(),
    );
  }
}
