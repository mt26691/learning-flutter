import 'package:flutter/material.dart';
import 'package:learn_flutter/providers/auth.dart';
import 'package:learn_flutter/providers/cart.dart';
import 'package:learn_flutter/providers/product.dart';
import 'package:learn_flutter/screens/product_detail_screen.dart';
import 'package:provider/provider.dart';

class ProductItem extends StatelessWidget {
  // final String id;
  // final String title;
  // final String imageUrl;

  // const ProductItem({Key key, this.id, this.title, this.imageUrl})
  //     : super(key: key);

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);
    final authData = Provider.of<Auth>(context, listen: false);
    print('product rebuilt');
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              ProductDetailScreen.routeName,
              arguments: product.id,
            );
          },
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          // consumer let us notify the change withotu rebuild too much
          // you can exeprience with listen to true
          leading: Consumer<Product>(
            builder: (context, changedProduct, child) {
              return IconButton(
                icon: changedProduct.isFavorite
                    ? Icon(Icons.favorite)
                    : Icon(Icons.favorite_border),
                // label: child => it will take Text('Never changes')
                onPressed: () {
                  changedProduct.toggleFavoriteStatus(
                      authData.token, authData.userId);
                },
                color: Theme.of(context).accentColor,
              );
            },
            // this child will be used as child in builder me thod
            child: Text('Never changes'),
          ),
          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              cart.addItem(product.id, product.price, product.title);
              // make connection to nearest scaffod widget
              Scaffold.of(context).hideCurrentSnackBar();
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text('Added item to cart!'),
                duration: Duration(seconds: 2),
                action: SnackBarAction(
                  label: 'UNDO',
                  onPressed: () {
                    cart.removeSingleItem(product.id);
                  },
                ),
              ));
            },
            color: Theme.of(context).accentColor,
          ),
        ),
      ),
    );
  }
}
