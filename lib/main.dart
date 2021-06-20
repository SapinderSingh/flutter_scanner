import 'package:flutter/material.dart';
import 'package:flutter_scanner/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.white),
      home: Home(),
      debugShowCheckedModeBanner: false,
    );
  }
}
