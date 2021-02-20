import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ungmaimall/models/user_model.dart';
import 'package:ungmaimall/utility/my_style.dart';

class MyService extends StatefulWidget {
  @override
  _MyServiceState createState() => _MyServiceState();
}

class _MyServiceState extends State<MyService> {
  UserModel userModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    findUserLogin();
  }

  Future<Null> findUserLogin() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String user = preferences.getString('user');
    String path =
        'https://www.androidthai.in.th/mmm/getUserWhereUserUng.php?isAdd=true&user=$user';
    await Dio().get(path).then((value) {
      print('value = $value');
      for (var item in json.decode(value.data)) {
        setState(() {
          userModel = UserModel.fromMap(item);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Service'),
      ),
      drawer: Drawer(
        child: Stack(
          children: [
            UserAccountsDrawerHeader(
                accountName: userModel == null
                    ? null
                    : MyStyle().titleH2White(userModel.name),
                accountEmail: null),
            buildSignOut(),
          ],
        ),
      ),
    );
  }

  Widget buildSignOut() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ListTile(
          leading: Icon(
            Icons.exit_to_app,
            size: 36,
            color: Colors.white,
          ),
          tileColor: MyStyle().darkColor,
          title: MyStyle().titleH2White('Sign Out'),
          onTap: () async {
            Navigator.pop(context);
            SharedPreferences preferences =
                await SharedPreferences.getInstance();
            preferences.clear();
            Navigator.pushNamedAndRemoveUntil(
                context, '/authen', (route) => false);
          },
        ),
      ],
    );
  }
}
