import 'package:flutter/material.dart';
import 'Screens/screens.dart';
import 'Utils/utils.dart';

void main() {
  runApp(const PoliceApp());
}


class PoliceApp extends StatelessWidget {
  const PoliceApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: Colors.white
      ),
      home: const PoliceHomepage(),
      
    );
  }
}