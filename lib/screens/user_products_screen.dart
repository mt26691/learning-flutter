import 'package:flutter/material.dart';
import 'package:learn_flutter/providers/products.dart';
import 'package:learn_flutter/screens/edit_product_screen.dart';
import 'package:learn_flutter/widgets/app_drawer.dart';
import 'package:learn_flutter/widgets/user_product_item.dart';
import 'package:provider/provider.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName = '/user-products';

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your products'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(EditProductScreen.routeName);
            },
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: ListView.builder(
          itemBuilder: (context, index) {
            final currentProduct = productsData.items[index];
            return Column(children: [
              UserProductItem(
                imageUrl: currentProduct.imageUrl,
                title: currentProduct.title,
              ),
              Divider(),
            ]);
          },
          itemCount: productsData.items.length,
        ),
      ),
    );
  }
}
