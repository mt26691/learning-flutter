import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:learn_flutter/providers/products.dart';
import 'package:learn_flutter/widgets/product_grid.dart';
import 'package:provider/provider.dart';

enum FilterOptions {
  Favorites,
  All,
}

class ProductsOverviewScreen extends StatefulWidget {
  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var _showOnlyFavorite = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('My Shop'),
          actions: [
            PopupMenuButton(
              onSelected: (FilterOptions selectedValue) {
                print('selected value = ${selectedValue.toString()}');

                if (selectedValue == FilterOptions.Favorites) {
                  // only favorites items
                  setState(() {
                    _showOnlyFavorite = true;
                  });
                } else {
                  // all items
                  setState(() {
                    _showOnlyFavorite = false;
                  });
                }
              },
              itemBuilder: (context) {
                return [
                  PopupMenuItem(
                      child: Text('Only Favorites'),
                      value: FilterOptions.Favorites),
                  PopupMenuItem(
                      child: Text('Show All'), value: FilterOptions.All),
                ];
              },
              icon: Icon(Icons.more_vert),
            )
          ],
        ),
        body: ProductGrid(
          showFavorite: _showOnlyFavorite,
        ));
  }
}
