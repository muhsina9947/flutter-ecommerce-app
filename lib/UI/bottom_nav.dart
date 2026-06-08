import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../services/auth_service.dart';

const Color dark = Color(0xff161616);
const Color gold = Color(0xffB79A63);

class BottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTap;

  const BottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onTap,
  });

  static const List<_NavItem> _items = [
    _NavItem(Icons.home_outlined, "Home"),
    _NavItem(Icons.search, "Discover"),
    _NavItem(Icons.favorite_border, "Wishlist"),
    _NavItem(Icons.shopping_bag_outlined, "Bag"),
    _NavItem(Icons.person_outline, "Account"),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: 68,
        decoration: const BoxDecoration(
          color: Color(0xffF8F5F0),
          border: Border(
            top: BorderSide(
              color: Color(0xffE4DDD3),
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment:
              MainAxisAlignment.spaceAround,
          children: List.generate(
            _items.length,
            (index) => _BottomNavItem(
              icon: _items[index].icon,
              label: _items[index].label,
              isSelected:
                  selectedIndex == index,
              onTap: () => onTap(index),
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem {
  final IconData icon;
  final String label;

  const _NavItem(
    this.icon,
    this.label,
  );
}

class _BottomNavItem
    extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _BottomNavItem({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  Stream<int> _badgeStream() {
    final uid = AuthService.userId;

    if (uid == null || uid.isEmpty) {
      return Stream.value(0);
    }

    String collection = "";

    if (label == "Bag") {
      collection = "cart";
    }

    if (label == "Wishlist") {
      collection = "wishlist";
    }

    if (collection.isEmpty) {
      return Stream.value(0);
    }

    return FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .collection(collection)
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs.length,
        );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,

      child: SizedBox(
        width: 65,

        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center,

          children: [

            // ICON + BADGE
            StreamBuilder<int>(
              stream: _badgeStream(),

              builder: (
                context,
                snapshot,
              ) {

                final count =
                    snapshot.data ?? 0;

                return Stack(
                  clipBehavior:
                      Clip.none,

                  children: [

                    Icon(
                      icon,
                      size: 22,

                      color:
                          isSelected
                              ? gold
                              : dark,
                    ),

                    // BADGE
                    if (count > 0)
                      Positioned(
                        right: -8,
                        top: -6,

                        child: Container(
                          padding:
                              const EdgeInsets.all(
                            4,
                          ),

                          decoration:
                              const BoxDecoration(
                            color:
                                Colors.black,
                            shape:
                                BoxShape.circle,
                          ),

                          constraints:
                              const BoxConstraints(
                            minWidth: 18,
                            minHeight: 18,
                          ),

                          child: Center(
                            child: Text(
                              count.toString(),

                              style:
                                  const TextStyle(
                                color:
                                    Colors.white,
                                fontSize: 8,
                                fontWeight:
                                    FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                );
              },
            ),

            const SizedBox(height: 5),

            // LABEL
            Text(
              label,

              style:
                  GoogleFonts.montserrat(
                fontSize: 9,

                fontWeight:
                    isSelected
                        ? FontWeight.bold
                        : FontWeight.w500,

                color:
                    isSelected
                        ? gold
                        : dark,
              ),
            ),
          ],
        ),
      ),
    );
  }
}