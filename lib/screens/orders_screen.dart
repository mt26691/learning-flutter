import 'package:flutter/material.dart';
import 'package:learn_flutter/providers/orders.dart';
import 'package:learn_flutter/widgets/order_item.dart';
import 'package:provider/provider.dart';

class OrdersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your order'),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          final currentOrder = orderData.orders[index];
          return OrderitemWidget(
            order: currentOrder,
          );
        },
        itemCount: orderData.orders.length,
      ),
    );
  }
}
