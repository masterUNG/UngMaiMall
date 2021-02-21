import 'dart:convert';

import 'package:charts_flutter/flutter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ungmaimall/models/bar_product_model.dart';
import 'package:ungmaimall/models/product_model.dart';
import 'package:ungmaimall/models/product_model_string.dart';

class ShowGraph extends StatefulWidget {
  @override
  _ShowGraphState createState() => _ShowGraphState();
}

class _ShowGraphState extends State<ShowGraph> {
  var data = [
    BarProductModel(product: '0', amount: 10),
    BarProductModel(product: '1', amount: 20),
    BarProductModel(product: '2', amount: 50),
    BarProductModel(product: '3', amount: 30),
  ];

  List<ProductModel> productModels = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readAllProduct();
  }

  Future<Null> readAllProduct() async {
    String path = 'https://www.androidthai.in.th/mmm/getAllProductUng.php';
    await Dio().get(path).then((value) {
      print('value = $value');
      for (var item in json.decode(value.data)) {
        ProductModelString productModelString =
            ProductModelString.fromMap(item);
        ProductModel productModel = ProductModel(
          product: int.parse(productModelString.product),
          amount: int.parse(productModelString.amount),
        );
        setState(() {
          productModels.add(productModel);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var series = [
      Series(
        seriesColor: Color(r: 252, g: 3, b: 252),
        id: 'idProduct',
        data: productModels,
        domainFn: (ProductModel model, index) => model.product,
        measureFn: (ProductModel model, index) => model.amount,
      ),
    ];

    var barSeries = [
      Series(
        id: 'idBar',
        data: data,
        domainFn: (BarProductModel model, index) => model.product,
        measureFn: (BarProductModel model, index) => model.amount,
      )
    ];

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: productModels.length == 0
            ? Center(child: CircularProgressIndicator())
            : BarChart(
                barSeries,
                animate: true,
              ),
      ),
    );
  }
}
