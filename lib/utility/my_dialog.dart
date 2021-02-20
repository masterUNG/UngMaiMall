import 'package:flutter/material.dart';
import 'package:ungmaimall/utility/my_style.dart';

Future<Null> normalDialog(
    BuildContext context, String title, String message) async {
  showDialog(
    context: context,
    builder: (context) => SimpleDialog(
      title: ListTile(
        leading: MyStyle().showLogo(),
        title: MyStyle().titleH2(title),
        subtitle: MyStyle().titleH3(message),
      ),children: [TextButton(onPressed: () => Navigator.pop(context), child: Text('OK'))],
    ),
  );
}
