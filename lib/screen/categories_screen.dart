import 'package:flutter/material.dart';
import 'package:learn_flutter/dummy_data.dart';
import 'package:learn_flutter/widgets/category_item.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Deli Meal'),
      ),
      body: GridView(
        padding: const EdgeInsets.all(25),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          // if the screen width is 500, then we will have 2 items (500/200)
          // if the screen width is 300, then we will have 1 item(300/200)
          maxCrossAxisExtent: 200,
          childAspectRatio: 1.5,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        children: DUMMY_CATEGORIES.map((category) {
          return CategoryItem(
            color: category.color,
            title: category.title,
            id: category.id,
          );
        }).toList(),
      ),
    );
  }
}
