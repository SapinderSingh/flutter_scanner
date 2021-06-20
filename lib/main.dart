import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scanner/home.dart';

List<CameraDescription>? cameras;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home: Home(
        cameras: cameras,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
