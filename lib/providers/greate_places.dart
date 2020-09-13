import 'package:flutter/foundation.dart';
import 'package:learn_flutter/models/place.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [...items];
  }
}
