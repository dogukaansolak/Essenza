import 'package:flutter/foundation.dart';
import '../models/perfume.dart';

class CartManager extends ChangeNotifier {
  static final CartManager instance = CartManager._internal();

  CartManager._internal();

  final List<Perfume> _items = [];

  List<Perfume> get items => List.unmodifiable(_items);

  int get itemCount => _items.length;

  double get totalPrice {
    return _items.fold(0.0, (sum, item) => sum + item.price);
  }

  void addToCart(Perfume perfume) {
    _items.add(perfume);
    notifyListeners();
  }

  void removeFromCart(Perfume perfume) {
    _items.remove(perfume);
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}