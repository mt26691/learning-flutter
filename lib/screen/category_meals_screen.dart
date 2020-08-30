import 'package:flutter/material.dart';
import 'package:learn_flutter/models/meal.dart';
import 'package:learn_flutter/widgets/meal_item.dart';

import '../dummy_data.dart';

class CategoryMealScreen extends StatefulWidget {
  static const routeName = '/category-meals';

  final List<Meal> availableMeals;

  CategoryMealScreen(this.availableMeals);
  @override
  _CategoryMealScreenState createState() => _CategoryMealScreenState();
}

class _CategoryMealScreenState extends State<CategoryMealScreen> {
  String categoryTitle;
  List<Meal> displayedMeals;
  bool _loadedInitData = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    if (!_loadedInitData) {
      final routeArgs =
          ModalRoute.of(context).settings.arguments as Map<String, String>;
      categoryTitle = routeArgs['title'];
      final cateoryId = routeArgs['id'];
      displayedMeals = widget.availableMeals
          .where((meal) => meal.categories.contains(cateoryId))
          .toList();
      _loadedInitData = true;
    }
  }

  void _removeMeal(String mealId) {
    setState(() {
      displayedMeals.removeWhere((element) => element.id == mealId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          final currentCategory = displayedMeals[index];
          return MealItem(
            id: currentCategory.id,
            title: currentCategory.title,
            imageUrl: currentCategory.imageUrl,
            duration: currentCategory.duration,
            complexity: currentCategory.complexity,
            affordability: currentCategory.affordability,
            removeItem: _removeMeal,
          );
        },
        itemCount: displayedMeals.length,
      ),
    );
  }
}
