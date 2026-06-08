import 'package:ecommerce_openfashion/UI/profile_screen.dart';
import 'package:flutter/material.dart';

import 'HomeScreen.dart';
import 'discover_screen.dart';
import 'wishlist_screen.dart';
import 'cart_screen.dart';
import 'package:ecommerce_openfashion/UI/bottom_nav.dart';

const Color bg = Color(0xffF5F1EB);

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() =>
      _MainNavigationScreenState();
}

class _MainNavigationScreenState
    extends State<MainNavigationScreen> {

  int selectedIndex = 0;

  late final List<Widget> screens;

  @override
  void initState() {
    super.initState();

    screens = [

      HomeScreen(
        onCategorySelected: (value) {},
      ),

      DiscoverScreen(
        selectedCategory: '',
      ),

      const WishlistScreen(),

      const CartScreen(),
      ProfileScreen(),

      const Center(
        child: Text(
          "Account Screen",
        ),
      ),
    ];
  }

  void onItemTapped(int index) {

    setState(() {

      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: bg,

      body: screens[selectedIndex],

      bottomNavigationBar: BottomNavBar(
        selectedIndex: selectedIndex,
        onTap: onItemTapped,
      ),
    );
  }
}