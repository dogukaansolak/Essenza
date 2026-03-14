import 'package:flutter/foundation.dart';
import '../models/perfume.dart';

class FavoritesManager extends ChangeNotifier {
  static final FavoritesManager instance = FavoritesManager._internal();

  FavoritesManager._internal();

  final List<Perfume> _items = [];

  List<Perfume> get items => List.unmodifiable(_items);

  bool isFavorite(Perfume perfume) {
    return _items.any((item) => item.name == perfume.name && item.brand == perfume.brand);
  }

  void toggleFavorite(Perfume perfume) {
    if (isFavorite(perfume)) {
      _items.removeWhere(
        (item) => item.name == perfume.name && item.brand == perfume.brand,
      );
    } else {
      _items.add(perfume);
    }
    notifyListeners();
  }
}