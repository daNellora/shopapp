import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class CartItem {
  final String id;
  final String title;
  final int cuantity;
  final double price;

  CartItem(
      {@required this.id,
      @required this.title,
      @required this.cuantity,
      @required this.price});
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, CartItem) {
      total += CartItem.price * CartItem.cuantity;
    });
    return total;
  }

  void addItem(String productId, double price, String title) {
    if (_items.containsKey(productId)) {
      _items.update(
        productId,
        (existingCardItem) => CartItem(
          id: existingCardItem.id,
          title: existingCardItem.title,
          price: existingCardItem.price,
          cuantity: existingCardItem.cuantity + 1,
        ),
      );
    } else {
      _items.putIfAbsent(
        productId,
        () => CartItem(
          id: DateTime.now().toString(),
          title: title,
          price: price,
          cuantity: 1,
        ),
      );
    }
    notifyListeners();
  }
}
