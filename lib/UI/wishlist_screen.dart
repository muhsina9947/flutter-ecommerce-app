import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_openfashion/UI/HomeScreen.dart';
import 'package:ecommerce_openfashion/UI/cart_screen.dart';
import 'package:ecommerce_openfashion/UI/profile/profile_screen.dart';
import 'package:ecommerce_openfashion/services/cart_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../services/wishlist_service.dart';

const Color bg = Color(0xffF5F1EB);
const Color dark = Color(0xff161616);
const Color light = Color(0xff8E8A84);
const Color gold = Color(0xffB79A63);

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const MainNavigationScreen(),
                        ),
                        (route) => false,
                      );
                    },
                    child: const Icon(
                      Icons.arrow_back_ios_new,
                      size: 18,
                      color: dark,
                    ),
                  ),
                  Text(
                    "MAISON LUXE",
                    style: GoogleFonts.cormorantGaramond(
                      fontSize: 20,
                      letterSpacing: 4,
                      fontWeight: FontWeight.w600,
                      color: dark,
                    ),
                  ),
                GestureDetector(
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const CartScreen(),
      ),
    );
  },
  child: const Icon(
    Icons.shopping_bag_outlined,
    size: 18,
    color: dark,
  ),
),
                ],
              ),
            ),

          
            Divider(height: 1, color: dark.withOpacity(.10)),

            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: WishlistService.wishlistStream(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: dark,
                        strokeWidth: 1,
                      ),
                    );
                  }

                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.favorite_border,
                            size: 44,
                            color: light,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            "Wishlist Is Empty",
                            style: GoogleFonts.cormorantGaramond(
                              fontSize: 30,
                              color: dark,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Save pieces you love",
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              color: light,
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  final items = snapshot.data!.docs;

                  return ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: items.length + 1, // +1 for header
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(18, 28, 18, 28),
                          child: Column(
                            children: [
                              Text(
                                "Curated\nSelection",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.cormorantGaramond(
                                  fontSize: 46,
                                  height: 1.0,
                                  color: dark,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                "Your personal collection of timeless\npieces, carefully held until the moment\nof acquisition.",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.inter(
                                  fontSize: 11,
                                  height: 1.7,
                                  color: light,
                                ),
                              ),
                            ],
                          ),
                        );
                      }

                      final item = items[index - 1];
                      final data = item.data() as Map<String, dynamic>;

                      final image = data["image"] ?? "";
                      final name = data["name"] ?? "Product";
                      final price = data["price"] ?? "\$0";
                      final label = data["label"] ?? "";

                      return _WishlistItemCard(
                        docId: item.id,
                        image: image,
                        name: name,
                        price: price,
                        label: label,
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _WishlistItemCard extends StatelessWidget {
  final String docId;
  final String image;
  final String name;
  final String price;
  final String label;

  const _WishlistItemCard({
    required this.docId,
    required this.image,
    required this.name,
    required this.price,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            Center(
              child: Image.asset(
                image,
                height: 427.5,
                width: 342,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  height: 300,
                  color: const Color(0xffE8E2DA),
                  child: const Center(
                    child: Icon(Icons.image_outlined, size: 40, color: light),
                  ),
                ),
              ),
            ),

            Positioned(
              top: 12,
              right: 10,
              child: GestureDetector(
                onTap: () => WishlistService.removeWishlistItem(docId),
                child: Container(
                  height: 36,
                  width: 36,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.favorite, color: gold, size: 18),
                ),
              ),
            ),
          ],
        ),

        Padding(
          padding: const EdgeInsets.fromLTRB(18, 14, 18, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      name,
                      style: GoogleFonts.cormorantGaramond(
                        fontSize: 26,
                        color: dark,
                        height: 1.1,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    price,
                    style: GoogleFonts.cormorantGaramond(
                      fontSize: 20,
                      color: gold,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 4),

              Text(
                label.toUpperCase(),
                style: GoogleFonts.inter(
                  fontSize: 9,
                  letterSpacing: 2,
                  color: light,
                ),
              ),

              const SizedBox(height: 16),

              SizedBox(
                width: double.infinity,
                height: 46,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: dark,
                    elevation: 0,
                    shape: const RoundedRectangleBorder(),
                  ),
                  
                  onPressed: () async {
              
                    await CartService.addToCart(
                      productId: name,
                      image: image,
                      name: name,
                      price: price,
                      label: label,
                      size: "M",
                    );

                    await WishlistService.removeWishlistItem(docId);

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: const Color(0xff161616),
                        content: Text(
                          "Moved To Bag",
                          style: GoogleFonts.cormorantGaramond(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    );
                  },
                  child: Text(
                    "MOVE TO BAG",
                    style: GoogleFonts.inter(
                      fontSize: 9,
                      letterSpacing: 2.5,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ],
    );
  }
}
