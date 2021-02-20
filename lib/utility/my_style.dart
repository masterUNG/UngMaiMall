import 'package:flutter/material.dart';

class MyStyle {
  Color darkColor = Colors.redAccent.shade700;
  Color primaryColor = Colors.blue.shade300;
  Color lightColor = Colors.grey;

  Widget titleH1(String string) => Text(
        string,
        style: TextStyle(
          color: darkColor,
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
      );

  Widget titleH2(String string) => Text(
        string,
        style: TextStyle(
          color: darkColor,
          fontWeight: FontWeight.w700,
          fontSize: 18,
        ),
      );

      Widget titleH2White(String string) => Text(
        string,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
          fontSize: 18,
        ),
      );

  Widget titleH3(String string) => Text(
        string,
        style: TextStyle(
          color: darkColor,
          fontSize: 14,
        ),
      );

  Widget showLogo() => Image(
        image: AssetImage('images/logo.png'),
      );

  MyStyle();
}
