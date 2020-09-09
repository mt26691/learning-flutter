import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:learn_flutter/model/http_exception.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product(
      {@required this.id,
      @required this.title,
      @required this.description,
      @required this.price,
      @required this.imageUrl,
      this.isFavorite = false});

  void _setFavValue(bool value) {
    isFavorite = value;
    notifyListeners();
  }

  Future<void> toggleFavoriteStatus(String token) async {
    final oldStatus = isFavorite;
    _setFavValue(!isFavorite);

    final url =
        'https://flutter-demo-b8867.firebaseio.com/products/${id}.json?auth=$token';
    try {
      final response = await http.patch(
        url,
        body: json.encode({
          'isFavorite': isFavorite,
        }),
      );

      if (response.statusCode >= 400) {
        throw HttpException('');
      }
    } catch (error) {
      _setFavValue(oldStatus);
      throw error;
    }
  }
}
