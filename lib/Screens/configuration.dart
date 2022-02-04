import 'package:flutter/material.dart';

Color primaryGreen = Color(0xff416d6d);
List<BoxShadow> shadowList = [
  BoxShadow(color: Colors.grey[300], blurRadius: 30, offset: Offset(0, 10))
];

List<Map> categories = [
  {
    'name': 'Vetements',
    'iconPath': 'assets/colthe_cat.png',
    'background': Color(0xFFE5CBC8)
  },
  {
    'name': 'Alimentation',
    'iconPath': 'assets/colthe_cat.png',
    'background': Color(0xFFB9D5BC)
  },
  {
    'name': 'Mobile',
    'iconPath': 'assets/phones_cat.png',
    'background': Color(0xFFA8C0D6)
  },
  {
    'name': 'Accessoires',
    'iconPath': 'assets/phrmacat.png',
    'background': Color(0xFF4D97C4)
  },
  {
    'name': 'Pharmacie',
    'iconPath': 'assets/accessoire_cat.png',
    'background': Color(0xFFD9C6A8)
  }
];

final kHintTextStyle = TextStyle(
  color: Colors.white54,
  fontFamily: 'Montserrat',
);

final kLabelStyle = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.bold,
  fontFamily: 'Montserrat',
);

final kBoxDecorationStyle = BoxDecoration(
  color: Color(0xFF6CA8F1),
  borderRadius: BorderRadius.circular(10.0),
  boxShadow: [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 6.0,
      offset: Offset(0, 2),
    ),
  ],
);
