import 'package:flutter/material.dart';
import 'package:learn_flutter/providers/products.dart';
import 'package:learn_flutter/screens/edit_product_screen.dart';
import 'package:learn_flutter/widgets/app_drawer.dart';
import 'package:learn_flutter/widgets/user_product_item.dart';
import 'package:provider/provider.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName = '/user-products';

  Future<void> _refreshProducts(BuildContext context) async {
    await Provider.of<Products>(context, listen: false)
        .fetchAndSetProducts(true);
  }

  @override
  Widget build(BuildContext context) {
    //final productsData = Provider.of<Products>(context);

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
      body: FutureBuilder(
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return RefreshIndicator(
            onRefresh: () => _refreshProducts(context),
            child: Consumer<Products>(
              builder: (context, productsData, child) {
                return Padding(
                  padding: EdgeInsets.all(8),
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      final currentProduct = productsData.items[index];
                      return Column(children: [
                        UserProductItem(
                            imageUrl: currentProduct.imageUrl,
                            title: currentProduct.title,
                            id: currentProduct.id),
                        Divider(),
                      ]);
                    },
                    itemCount: productsData.items.length,
                  ),
                );
              },
            ),
          );
        },
        future: _refreshProducts(context),
      ),
    );
  }
}
