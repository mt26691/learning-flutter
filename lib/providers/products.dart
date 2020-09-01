import 'package:flutter/material.dart';
import 'package:learn_flutter/model/product.dart';

class Products with ChangeNotifier {
  List<Product> _items = [];

  List<Product> get items {
    return [..._items];
  }

  addProduct(Product value) {
    _items.add(value);
    notifyListeners();
  }
}
