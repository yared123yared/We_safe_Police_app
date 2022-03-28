import 'package:flutter/material.dart';


class PoliceHomepage extends StatefulWidget {
  const PoliceHomepage({ Key? key }) : super(key: key);

  @override
  State<PoliceHomepage> createState() => _PoliceHomepageState();
}

class _PoliceHomepageState extends State<PoliceHomepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      
    );
  }
}