import 'package:flutter/material.dart';
import 'package:learn_flutter/providers/auth.dart';
import 'package:learn_flutter/providers/cart.dart';
import 'package:learn_flutter/providers/orders.dart';
import 'package:learn_flutter/providers/products.dart';
import 'package:learn_flutter/screens/auth_screen.dart';
import 'package:learn_flutter/screens/cart_screen.dart';
import 'package:learn_flutter/screens/edit_product_screen.dart';
import 'package:learn_flutter/screens/orders_screen.dart';
import 'package:learn_flutter/screens/user_products_screen.dart';
import 'package:provider/provider.dart';
import 'package:learn_flutter/screens/products_overview_screen.dart';

import 'screens/product_detail_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // when create new object, we should use ChangeNotifierProvider
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) {
            return Auth();
          },
        ),
        ChangeNotifierProxyProvider<Auth, Products>(
          create: null,
          update: (context, auth, previousProducts) {
            return Products(auth.token,
                previousProducts == null ? [] : previousProducts.items);
          },
        ),
        ChangeNotifierProvider.value(
          value: Cart(),
        ),
        ChangeNotifierProxyProvider<Auth, Orders>(
          create: (context) {
            return Orders('', []);
          },
          update: (context, auth, previousOrders) {
            return Orders(auth.token,
                previousOrders != null ? [] : previousOrders.orders);
          },
        ),
      ],
      child: Consumer<Auth>(
        builder: (context, authData, child) {
          return MaterialApp(
            title: 'My Shop',
            theme: ThemeData(
              // This is the theme of your application.
              //
              // Try running your application with "flutter run". You'll see the
              // application has a blue toolbar. Then, without quitting the app, try
              // changing the primarySwatch below to Colors.green and then invoke
              // "hot reload" (press "r" in the console where you ran "flutter run",
              // or simply save your changes to "hot reload" in a Flutter IDE).
              // Notice that the counter didn't reset back to zero; the application
              // is not restarted.
              primarySwatch: Colors.purple,
              accentColor: Colors.deepOrange,
              fontFamily: 'Lato',
              // This makes the visual density adapt to the platform that you run
              // the app on. For desktop platforms, the controls will be smaller and
              // closer together (more dense) than on mobile platforms.
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            home: authData.isAuthenticated
                ? ProductsOverviewScreen()
                : AuthScreen(),
            routes: {
              ProductDetailScreen.routeName: (cxt) => ProductDetailScreen(),
              CartScreen.routeName: (cxt) => CartScreen(),
              OrdersScreen.routeName: (cxt) => OrdersScreen(),
              UserProductsScreen.routeName: (cxt) => UserProductsScreen(),
              EditProductScreen.routeName: (cxt) => EditProductScreen(),
            },
          );
        },
      ),
    );
  }
}
