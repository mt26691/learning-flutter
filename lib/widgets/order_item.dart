import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:learn_flutter/providers/orders.dart';

class OrderitemWidget extends StatefulWidget {
  final OrderItem order;

  const OrderitemWidget({Key key, this.order}) : super(key: key);

  @override
  _OrderitemWidgetState createState() => _OrderitemWidgetState();
}

class _OrderitemWidgetState extends State<OrderitemWidget> {
  var _expanded = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      height:
          _expanded ? min(widget.order.products.length * 20.0 + 110, 200) : 95,
      child: Card(
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            ListTile(
              title: Text('\$${widget.order.amount}'),
              subtitle: Text(
                  DateFormat('dd/MM/yyyy hh:mm').format(widget.order.dateTime)),
              trailing: IconButton(
                icon: _expanded
                    ? Icon(Icons.expand_less)
                    : Icon(Icons.expand_more),
                onPressed: () {
                  setState(() {
                    _expanded = !_expanded;
                  });
                },
              ),
            ),
            AnimatedContainer(
                duration: Duration(milliseconds: 300),
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                height: _expanded
                    ? min(widget.order.products.length * 20.0 + 10, 200)
                    : 0,
                child: ListView(
                  children: widget.order.products.map((product) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          product.title,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${product.quantity} x \$${product.price.toStringAsFixed(2)}',
                          style: TextStyle(fontSize: 18, color: Colors.grey),
                        ),
                      ],
                    );
                  }).toList(),
                ))
          ],
        ),
      ),
    );
  }
}
