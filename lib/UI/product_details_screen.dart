import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../services/cart_service.dart';
import '../services/wishlist_service.dart';

const Color bg = Color(0xffF5F1EB);
const Color dark = Color(0xff161616);
const Color light = Color(0xff8E8A84);
const Color gold = Color(0xffB79A63);

class ProductDetailsScreen extends StatelessWidget {
  final Map<String, String> product;

  const ProductDetailsScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final image = product["image"] ?? "";
    final name = product["name"] ?? "Product";
    final category = product["category"] ?? "LUXURY";
    final price = product["price"] ?? "\$0";

    return Scaffold(
      backgroundColor: bg,

      body: Stack(
        children: [
          // IMAGE
          SizedBox(
            height: MediaQuery.of(context).size.height * .65,
            width: double.infinity,

            child: Hero(
              tag: image,

              child: Image.asset(
                image,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey.shade300,
                    child: const Icon(Icons.image, size: 60),
                  );
                },
              ),
            ),
          ),

          Container(
            height: MediaQuery.of(context).size.height * .65,
            color: Colors.black.withOpacity(0.08),
          ),

          // BACK BUTTON
          Positioned(
            top: 50,
            left: 20,

            child: GestureDetector(
              onTap: () => Navigator.pop(context),

              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.95),
                  shape: BoxShape.circle,
                ),

                child: const Icon(
                  Icons.arrow_back_ios_new,
                  size: 18,
                  color: dark,
                ),
              ),
            ),
          ),

          // BOTTOM CARD
          Align(
            alignment: Alignment.bottomCenter,

            child: Container(
              height: MediaQuery.of(context).size.height * .42,
              width: double.infinity,

              padding: const EdgeInsets.all(24),

              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(34)),
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Text(
                    category,
                    style: GoogleFonts.montserrat(
                      fontSize: 10,
                      letterSpacing: 2,
                      color: gold,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  const SizedBox(height: 12),

                  Text(
                    name,
                    style: GoogleFonts.cormorantGaramond(
                      fontSize: 38,
                      height: 1,
                      color: dark,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 16),

                  Text(
                    price,
                    style: GoogleFonts.montserrat(
                      fontSize: 24,
                      color: dark,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 18),

                  Text(
                    "Elegant luxury fashion crafted with timeless aesthetics and premium materials. Designed for a sophisticated modern wardrobe.",
                    style: GoogleFonts.montserrat(
                      fontSize: 13,
                      color: light,
                      height: 1.8,
                    ),
                  ),

                  const Spacer(),

                  Row(
                    children: [
                      // WISHLIST
                      Expanded(
                        child: GestureDetector(
                          onTap: () async {
                            await WishlistService.addToWishlist(
                              productId: product["id"] ?? name,
                              image: product["image"] ?? "",
                              name: product["name"] ?? "",
                              price: product["price"] ?? "",
                              label: product["category"] ?? "",
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Added To Wishlist"),
                              ),
                            );
                          },

                          child: Container(
                            height: 58,
                            decoration: BoxDecoration(
                              border: Border.all(color: dark),
                              borderRadius: BorderRadius.circular(18),
                            ),
                            child: const Icon(
                              Icons.favorite_border,
                              color: dark,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(width: 14),

                      // CART
                      Expanded(
                        flex: 3,

                        child: SizedBox(
                          height: 58,

                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: dark,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18),
                              ),
                            ),
onPressed: () async {
  await CartService.addToCart(
    productId: product["id"] ?? name,
    image: product["image"] ?? "",
    name: product["name"] ?? "",
    price: product["price"] ?? "",
    label: product["category"] ?? "",
    size: product["size"] ?? "M",
  );

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: const Color(0xff161616),
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(20),
      duration: const Duration(seconds: 2),

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),

      content: Row(
        children: [
          const Icon(
            Icons.check_circle_outline,
            color: Color(0xffB79A63),
            size: 20,
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Text(
              "Added To Shopping Bag",
              style: GoogleFonts.cormorantGaramond(
                fontSize: 18,
                color: Colors.white,
                letterSpacing: 1,
              ),
            ),
          ),
        ],
      ),
    ),
  );
},

child: Text(
  "ADD TO BAG",
  style: GoogleFonts.montserrat(
    fontSize: 12,
    letterSpacing: 1.5,
    fontWeight: FontWeight.w700,
    color: Colors.white,
  ),
),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
