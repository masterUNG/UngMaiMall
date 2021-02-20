import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ungmaimall/states/add_data.dart';
import 'package:ungmaimall/states/authen.dart';
import 'package:ungmaimall/states/create_account.dart';
import 'package:ungmaimall/states/my_service.dart';

final Map<String, WidgetBuilder> map = {
  '/authen': (BuildContext context) => Authen(),
  '/createAccount': (BuildContext context) => CreateAccount(),
  '/myService': (BuildContext context) => MyService(),
  '/addData': (BuildContext context) => AddData(),
};

String iniRoute = '/authen';

Future<Null> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  String user = preferences.getString('user');
  print('user = $user');
  print('user ==>> $user');
  if (!(user?.isEmpty ?? true)) {
    iniRoute = '/myService';
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: map,
      initialRoute: iniRoute,
    );
  }
}
