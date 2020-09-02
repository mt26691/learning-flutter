import 'package:flutter/material.dart';
import 'package:learn_flutter/providers/cart.dart';
import 'package:learn_flutter/providers/orders.dart';
import 'package:learn_flutter/providers/products.dart';
import 'package:learn_flutter/screens/cart_screen.dart';
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
            return Products();
          },
        ),
        ChangeNotifierProvider.value(
          value: Cart(),
        ),
        ChangeNotifierProvider(
          create: (context) {
            return Orders();
          },
        ),
      ],
      child: MaterialApp(
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
        home: ProductsOverviewScreen(),
        routes: {
          ProductDetailScreen.routeName: (cxt) => ProductDetailScreen(),
          CartScreen.routeName: (cxt) => CartScreen(),
        },
      ),
    );
  }
}
