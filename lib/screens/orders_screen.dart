import 'package:flutter/material.dart';
import 'package:learn_flutter/providers/orders.dart';
import 'package:learn_flutter/widgets/app_drawer.dart';
import 'package:learn_flutter/widgets/order_item.dart';
import 'package:provider/provider.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/order';

  @override
  Widget build(BuildContext context) {
    // final orderData = Provider.of<Orders>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('Your order'),
        ),
        drawer: AppDrawer(),
        body: FutureBuilder(
          builder: (context, dataSnapshot) {
            if (dataSnapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              if (dataSnapshot.error != null) {
                return Center(
                  child: Text('An Error Occured!'),
                );
              }
              return Consumer<Orders>(
                builder: (context, orderData, child) {
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      final currentOrder = orderData.orders[index];
                      return OrderitemWidget(
                        order: currentOrder,
                      );
                    },
                    itemCount: orderData.orders.length,
                  );
                },
              );
            }
          },
          future:
              Provider.of<Orders>(context, listen: false).fetchAndSetOrders(),
        ));
  }
}
