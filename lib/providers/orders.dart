import 'package:flutter/material.dart';
import 'package:learn_flutter/providers/cart.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:learn_flutter/model/http_exception.dart';

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];

  Orders(this.authToken, this.userId, this._orders);

  List<OrderItem> get orders {
    return [..._orders];
  }

  final String authToken;
  final String userId;

  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    final url =
        'https://flutter-demo-b8867.firebaseio.com/orders/$userId.json?auth=$authToken';

    final timeStamp = DateTime.now();

    try {
      final response = await http.post(
        url,
        body: json.encode({
          'amount': total,
          'dateTime': timeStamp.toIso8601String(),
          'products': cartProducts.map((cp) {
            return {
              'id': cp.id,
              'title': cp.title,
              'quantity': cp.quantity,
              'price': cp.price,
            };
          }).toList()
        }),
      );
      _orders.insert(
          0,
          OrderItem(
            id: json.decode(response.body)['name'],
            amount: total,
            dateTime: timeStamp,
            products: cartProducts,
          ));
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> fetchAndSetOrders() async {
    final url =
        'https://flutter-demo-b8867.firebaseio.com/orders/$userId.json?auth=$authToken';
    try {
      final response = await http.get(url);

      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }
      final List<OrderItem> loadedOrders = [];
      extractedData.forEach((orderId, orderData) {
        loadedOrders.add(OrderItem(
            id: orderId,
            amount: orderData['amount'],
            dateTime: DateTime.parse(orderData['dateTime']),
            products: (orderData['products'] as List<dynamic>)
                .map((item) => CartItem(
                      id: item['id'],
                      title: item['title'],
                      quantity: item['quantity'],
                      price: item['price'],
                    ))
                .toList()));
      });
      _orders = loadedOrders.reversed.toList();
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }
}

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem({
    @required this.id,
    @required this.amount,
    @required this.products,
    @required this.dateTime,
  });
}
