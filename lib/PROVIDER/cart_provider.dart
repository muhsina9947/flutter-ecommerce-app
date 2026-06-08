import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {

  int cartCount = 0;

  void updateCartCount(
    int count,
  ) {

    cartCount = count;

    notifyListeners();
  }
}