import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ungmaimall/models/show_product_model.dart';
import 'package:ungmaimall/utility/my_style.dart';

class ShowListView extends StatefulWidget {
  @override
  _ShowListViewState createState() => _ShowListViewState();
}

class _ShowListViewState extends State<ShowListView> {
  List<ShowProductModel> models = [];
  double screen;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readAllData();
  }

  Future<Null> readAllData() async {
    if (models.length != 0) {
      models.clear();
    }

    print('################ read All Data Work ###############');
    String path = 'https://www.androidthai.in.th/mmm/AllProductUng.php';
    await Dio().get(path).then((value) {
      // print('value = $value');
      for (var item in json.decode(value.data)) {
        ShowProductModel model = ShowProductModel.fromMap(item);
        setState(() {
          models.add(model);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    screen = MediaQuery.of(context).size.width;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/addData')
              .then((value) => readAllData());
        },
        child: Icon(Icons.add),
      ),
      body: models.length == 0
          ? MyStyle().showProgress()
          : ListView.builder(
                itemCount: models.length,
                itemBuilder: (context, index) => Card(color: index%2 == 0 ? Colors.white : MyStyle().lightColor,
                                  child: Column(
                    children: [
                      Row(
          children: [
            Container(
              width: screen * 0.5-5,
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MyStyle().titleH1(models[index].title),
              ),
            ),
            Container(
              width: screen * 0.5-5,
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CachedNetworkImage(
                    imageUrl: models[index].urlimage,
                    placeholder: (context, url) =>
                        MyStyle().showProgress(),
                    errorWidget: (context, url, error) =>
                        MyStyle().showLogo(),
                  ),
              ),
            )
          ],
                      ),
                      Padding(
          padding: const EdgeInsets.all(8.0),
          child: MyStyle().titleH3(models[index].detail),
                      )
                    ],
                  ),
                ),
              ),
    );
  }
}
