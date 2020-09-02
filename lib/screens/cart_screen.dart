import 'package:flutter/material.dart';
import 'package:learn_flutter/providers/cart.dart';
import 'package:learn_flutter/providers/orders.dart';
import 'package:learn_flutter/widgets/cart_item.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart!'),
      ),
      body: Column(
        children: [
          Card(
            margin: EdgeInsets.all(15),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total',
                    style: TextStyle(fontSize: 20),
                  ),
                  Spacer(),
                  Chip(
                    label: Text(
                      '\$${cart.totalAmount.toStringAsFixed(2)}',
                      style: TextStyle(
                          color: Theme.of(context)
                              .primaryTextTheme
                              .headline6
                              .color),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  FlatButton(
                      onPressed: () {
                        final orders =
                            Provider.of<Orders>(context, listen: false);
                        orders.addOrder(
                            cart.items.values.toList(), cart.totalAmount);
                        cart.clear();
                      },
                      child: Text('ORDER NOW'))
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
              child: ListView.builder(
            itemBuilder: (context, index) {
              final currentItem = cart.items.values.toList()[index];

              return CartItemWidget(
                  key: ValueKey(currentItem.id),
                  productId: cart.items.keys.toList()[index],
                  id: currentItem.id,
                  price: currentItem.price,
                  quantity: currentItem.quantity,
                  title: currentItem.title);
            },
            itemCount: cart.itemCount,
          ))
        ],
      ),
    );
  }
}
