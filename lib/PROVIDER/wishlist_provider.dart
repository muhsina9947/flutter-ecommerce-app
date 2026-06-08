import 'package:flutter/material.dart';

class WishlistProvider
    extends ChangeNotifier {

  int wishlistCount = 0;

  void updateWishlistCount(
    int count,
  ) {

    wishlistCount = count;

    notifyListeners();
  }
}