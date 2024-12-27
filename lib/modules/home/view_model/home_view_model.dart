import 'package:ecom_nesa/modules/home/model/product_by_id.dart';
import 'package:ecom_nesa/modules/home/model/products_model.dart';
import 'package:ecom_nesa/modules/home/repository/home_repository.dart';
import 'package:flutter/material.dart';

class HomeViewModel extends ChangeNotifier {
  final HomeRepository _repository = HomeRepository();

  ProductList? productsList;
  List<Products> products = [];
  ProductById? productById;

  Future getProducts() async {
    await _repository.getProducts().then((value) {
      productsList = value;
    });
    notifyListeners();
  }

  Future getProductsByID(id) async {
    await _repository.productById(id).then((value) {
      productById = value;
    });
    notifyListeners();
  }

  Future updateProduct(id, context, title, description, price) async {
    await _repository
        .editProduct(id, context, title, description, price)
        .then((value) {});
    notifyListeners();
  }
}
