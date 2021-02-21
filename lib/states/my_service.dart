import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ungmaimall/bodys/show_graph.dart';
import 'package:ungmaimall/bodys/show_listview.dart';
import 'package:ungmaimall/models/user_model.dart';
import 'package:ungmaimall/utility/my_style.dart';

class MyService extends StatefulWidget {
  @override
  _MyServiceState createState() => _MyServiceState();
}

class _MyServiceState extends State<MyService> {
  UserModel userModel;
  Widget currentWidget = ShowListView();

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
      drawer: buildDrawer(context),
      body: currentWidget,
    );
  }

  Drawer buildDrawer(BuildContext context) {
    return Drawer(
      child: Stack(
        children: [
          Column(
            children: [
              buildUserAccountsDrawerHeader(),
              buildMenuShowListView(context),
              buildMenuGraph(context),
            ],
          ),
          buildSignOut(),
        ],
      ),
    );
  }

  ListTile buildMenuShowListView(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.home),
      title: Text('Show ListView'),
      subtitle: Text('คำอธิบาย ของ Title'),
      onTap: () {
        Navigator.pop(context);
        setState(() {
          currentWidget = ShowListView();
        });
      },
    );
  }

  ListTile buildMenuGraph(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.speaker_group_sharp),
      title: Text('Graph'),
      subtitle: Text('Demo Display Graphic'),
      onTap: () {
        Navigator.pop(context);
        setState(() {
          currentWidget = ShowGraph();
        });
      },
    );
  }

  UserAccountsDrawerHeader buildUserAccountsDrawerHeader() {
    return UserAccountsDrawerHeader(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/wall.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        currentAccountPicture: MyStyle().showLogo(),
        accountName:
            userModel == null ? null : MyStyle().titleH2(userModel.name),
        accountEmail: null);
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
