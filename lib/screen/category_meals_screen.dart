import 'package:flutter/material.dart';
import 'package:learn_flutter/widgets/meal_item.dart';

import '../dummy_data.dart';

class CategoryMealScreen extends StatelessWidget {
  static const routeName = '/category-meals';
  // final String categoryId;
  // final String categoryTitle;

  // CategoryMealScreen({@required this.categoryId, @required this.categoryTitle});

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    final categoryTitle = routeArgs['title'];
    final cateoryId = routeArgs['id'];

    final cateogryMeals = DUMMY_MEALS
        .where((meal) => meal.categories.contains(cateoryId))
        .toList();
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          final currentCategory = cateogryMeals[index];
          return MealItem(
              id: currentCategory.id,
              title: currentCategory.title,
              imageUrl: currentCategory.imageUrl,
              duration: currentCategory.duration,
              complexity: currentCategory.complexity,
              affordability: currentCategory.affordability);
        },
        itemCount: cateogryMeals.length,
      ),
    );
  }
}
