import 'package:flutter/material.dart';
import 'package:learn_flutter/providers/products.dart';
import 'package:provider/provider.dart';

import 'product_item.dart';

class ProductGrid extends StatelessWidget {
  const ProductGrid({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final products = productsData.items;

    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (context, index) {
        final currentProduct = products[index];
        // when you are using an existing object like this, you should use value
        return ChangeNotifierProvider.value(
            value: currentProduct, child: ProductItem());
      },
      itemCount: products.length,
    );
  }
}
