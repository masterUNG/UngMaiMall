import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ungmaimall/models/user_model.dart';
import 'package:ungmaimall/utility/my_dialog.dart';
import 'package:ungmaimall/utility/my_style.dart';

class Authen extends StatefulWidget {
  @override
  _AuthenState createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  double screen;
  bool passwordBool = true;
  String user, password;

  @override
  Widget build(BuildContext context) {
    screen = MediaQuery.of(context).size.width;
    return Scaffold(
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 50,
          ),
          MyStyle().titleH3('Non Account ?'),
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, '/createAccount');
            },
            child: Text('Create Account'),
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildLogo(),
            MyStyle().titleH1('Ung Mai Mall'),
            buildUser(),
            buildPassword(),
            buildLogin(),
          ],
        ),
      ),
    );
  }

  Container buildLogin() {
    return Container(
      margin: EdgeInsets.only(top: 8),
      width: screen * 0.6,
      child: ElevatedButton(
        onPressed: () {
          print('user = $user, password = $password');
          if ((user?.isEmpty ?? true) || (password?.isEmpty ?? true)) {
            normalDialog(context, 'Have Space ?', 'Please Fill Every Blank');
          } else {
            checkAuthentication();
          }
        },
        child: Text('Login'),
      ),
    );
  }

  Future<Null> checkAuthentication() async {
    String path =
        'https://www.androidthai.in.th/mmm/getUserWhereUserUng.php?isAdd=true&user=$user';
    await Dio().get(path).then((value) async {
      if (value.toString() == 'null') {
        normalDialog(context, 'User False', 'No $user in my Database');
      } else {
        for (var item in json.decode(value.data)) {
          UserModel model = UserModel.fromMap(item);
          if (password == model.password) {
            SharedPreferences preferences =
                await SharedPreferences.getInstance();
            preferences.setString('user', user);

            Navigator.pushNamedAndRemoveUntil(
                context, '/myService', (route) => false);
          } else {
            normalDialog(
                context, 'Password False', 'Please Try Again Password False');
          }
        }
      }
    });
  }

  Container buildUser() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      width: screen * 0.6,
      child: TextField(
        onChanged: (value) => user = value.trim(),
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.account_box_outlined,
            color: MyStyle().darkColor,
          ),
          labelStyle: TextStyle(color: MyStyle().darkColor),
          labelText: 'User :',
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: MyStyle().darkColor)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: MyStyle().lightColor)),
        ),
      ),
    );
  }

  Container buildPassword() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      width: screen * 0.6,
      child: TextField(
        onChanged: (value) => password = value.trim(),
        obscureText: passwordBool,
        decoration: InputDecoration(
          suffixIcon: IconButton(
            icon: Icon(
              Icons.remove_red_eye_rounded,
              color: MyStyle().darkColor,
            ),
            onPressed: () {
              setState(() {
                passwordBool = !passwordBool;
              });
            },
          ),
          prefixIcon: Icon(
            Icons.lock_outline,
            color: MyStyle().darkColor,
          ),
          labelStyle: TextStyle(color: MyStyle().darkColor),
          labelText: 'Password :',
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: MyStyle().darkColor)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: MyStyle().lightColor)),
        ),
      ),
    );
  }

  Container buildLogo() {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      width: screen * 0.25,
      child: MyStyle().showLogo(),
    );
  }
}
