import 'package:flutter/material.dart';

// Colors
const kPrimaryColor = Color(0xFF6F35A5);
const kPrimaryLightColor = Color(0xFFF1E6FF);
const kIconColor = Color(0xffA3A3A3);

// ignore: constant_identifier_names
const BASE_URL = 'https://we-safe-development.herokuapp.com/';

MaterialColor createMaterialColor(Color color) {
  List strengths = <double>[.05];
  final swatch = <int, Color>{};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  for (var strength in strengths) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  }
  return MaterialColor(color.value, swatch);
}

class DateFormaterClass {

  static final List<String> months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec'
  ];

  static String formatDate(String dateString) {
    DateTime _dateTime = DateTime.parse(dateString); 
    late String _day;
    if(_dateTime.day < 10){
      _day = '0${_dateTime.day}';
    }else{
      _day = '${_dateTime.day}';
    }
    return '${months[_dateTime.month - 1]} $_day, ${_dateTime.year}';
  }

}


