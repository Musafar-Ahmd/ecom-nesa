import 'package:dio/dio.dart';
import 'package:ecom_nesa/modules/home/model/products_model.dart';
import 'package:ecom_nesa/modules/home/view/product_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../model/product_by_id.dart';

class HomeRepository {
  Future getProducts() async {
    try {
      EasyLoading.show();

      var dio = Dio();
      var response = await dio.request(
        'https://dummyjson.com/products',
        options: Options(
          method: 'GET',
        ),
      );

      if (response.statusCode == 200) {
        EasyLoading.dismiss();

        print(response.data);
        return ProductList.fromJson(response.data);
      } else {
        EasyLoading.dismiss();
        print(response.statusMessage);
      }
    } catch (e) {
      EasyLoading.dismiss();
      print("error $e");
    }
  }

  Future productById(int id) async {
    try {
      EasyLoading.show();

      var dio = Dio();
      var response = await dio.request(
        'https://dummyjson.com/products/$id',
        options: Options(
          method: 'GET',
        ),
      );

      if (response.statusCode == 200) {
        EasyLoading.dismiss();

        print(response.data);
        return ProductById.fromJson(response.data);
      } else {
        EasyLoading.dismiss();

        print(response.statusMessage);
      }
    } catch (e) {
      EasyLoading.dismiss();

      print("error $e");
    }
  }

  Future editProduct(int id, context, title, description, price) async {
    try {
      EasyLoading.show();

      var dio = Dio();
      var data = {'title': title, 'description': description, 'price': price};
      var response = await dio.request(
        'https://dummyjson.com/products/$id',
        options: Options(
          method: 'PUT',
        ),
      );

      if (response.statusCode == 200) {
        EasyLoading.dismiss();

        print(response.data);
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => ProductDetail(id: id)),
            (Route route) => false);
      } else {
        EasyLoading.dismiss();

        print(response.statusMessage);
      }
    } catch (e) {
      EasyLoading.dismiss();

      print("error $e");
    }
  }
}
