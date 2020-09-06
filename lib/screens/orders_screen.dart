import 'package:flutter/material.dart';
import 'package:learn_flutter/providers/orders.dart';
import 'package:learn_flutter/widgets/app_drawer.dart';
import 'package:learn_flutter/widgets/order_item.dart';
import 'package:provider/provider.dart';

class OrdersScreen extends StatefulWidget {
  static const routeName = '/order';

  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  var _isLoading = false;
  @override
  void initState() {
    Future.delayed(Duration.zero).then((_) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Orders>(context, listen: false)
          .fetchAndSetOrders()
          .then((value) {
        setState(() {
          _isLoading = false;
        });
      });
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your order'),
      ),
      drawer: AppDrawer(),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
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
