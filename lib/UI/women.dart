import 'package:ecommerce_openfashion/UI/HomeScreen.dart';
import 'package:ecommerce_openfashion/services/cart_service.dart';
import 'package:ecommerce_openfashion/services/wishlist_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color bg = Color(0xffF5F1EB);
const Color dark = Color(0xff161616);
const Color light = Color(0xff8E8A84);
const Color gold = Color(0xffB79A63);

class WomenCollectionScreen extends StatefulWidget {
  const WomenCollectionScreen({super.key});

  @override
  State<WomenCollectionScreen> createState() => _WomenCollectionScreenState();
}

class _WomenCollectionScreenState extends State<WomenCollectionScreen> {
  int _selectedFilter = 0;

  final List<String> _filters = [
    "ALL",
    "READY-TO-WEAR",
    "OUTERWEAR",
    "DRESSES",
  ];

  final List<Map<String, String>> _products = [
    {
      "image": "IMAGES/0b7736f6e0fccbaea56caff25688c2da.jpg",
      "category": "READY-TO-WEAR",
      "name": "Structured Wool Blazer",
      "price": "\$2,750",
      "filter": "READY-TO-WEAR",
    },
    {
      "image": "IMAGES/0718f052a163a4295664f03aa7b969f0.jpg",
      "category": "OUTERWEAR",
      "name": "Star-Worth Ivory Coat",
      "price": "\$4,100",
      "filter": "OUTERWEAR",
    },
    {
      "image":
      "IMAGES/Blackpink-Jennie-Chanel-goth-coquette-aesthetic-titkok-fashion-trend-2024-Paris-fashion-week-2-1-scaled.webp",
      "category": "READY-TO-WEAR",
      "name": "Ribbed Cashmere Turtleneck",
      "price": "\$890",
      "filter": "READY-TO-WEAR",
    },
    {
      "image": "IMAGES/May 21, 2026, 12_37_37 PM.png",
      "category": "READY-TO-WEAR",
      "name": "Wide-Leg Wool Trouser",
      "price": "\$1,200",
      "filter": "READY-TO-WEAR",
    },
    {
      "image": "IMAGES/S24_JENNIE_DIGI_PR_nologo_1080x1350_7.webp",
      "category": "READY-TO-WEAR",
      "name": "The Double Tote Bag",
      "price": "\$3,400",
      "filter": "READY-TO-WEAR",
    },
    {
      "image": "IMAGES/ChatGPT Image May 21, 2026, 12_43_40 PM.png",
      "category": "DRESSES",
      "name": "Sculptured Silk Blouse",
      "price": "\$1,560",
      "filter": "DRESSES",
    },
    {
      "image": "IMAGES/51g8y-xHoDL._AC_UF894,1000_QL80_.jpg",
      "category": "DRESSES",
      "name": "Lace Atelier Evening Gown",
      "price": "\$7,200",
      "filter": "DRESSES",
    },
    {
      "image": "IMAGES/jennie-2-1.jpg",
      "category": "DRESSES",
      "name": "Asymmetric Pleated Skirt",
      "price": "\$1,890",
      "filter": "DRESSES",
    },
    {
      "image": "IMAGES/jennie-pictures-am9k0lvwt763kfqa.jpg",
      "category": "DRESSES",
      "name": "Asymmetric Pleated Skirt",
      "price": "\$1,890",
      "filter": "DRESSES",
    },
  ];

  List<Map<String, String>> get _filteredProducts {
    if (_selectedFilter == 0) return _products;

    return _products
        .where((p) => p["filter"] == _filters[_selectedFilter])
        .toList();
  }

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

                  Column(
                    children: [
                      Text(
                        "MAISON LUXE",
                        style: GoogleFonts.cormorantGaramond(
                          fontSize: 20,
                          letterSpacing: 4,
                          color: dark,
                        ),
                      ),
                    ],
                  ),

                  const Icon(Icons.tune, color: dark),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Women's\nCollection",
                  style: GoogleFonts.cormorantGaramond(
                    fontSize: 42,
                    height: 1,
                    color: dark,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              height: 40,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: _filters.length,
                itemBuilder: (context, index) {
                  final isSelected = _selectedFilter == index;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedFilter = index;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.only(right: 10),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected ? dark : Colors.transparent,
                        border: Border.all(
                          color: isSelected ? dark : Colors.grey.shade400,
                        ),
                      ),
                      child: Text(
                        _filters[index],
                        style: GoogleFonts.montserrat(
                          fontSize: 10,
                          color: isSelected ? Colors.white : light,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 18),

            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: _filteredProducts.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 14,
                  mainAxisSpacing: 20,
                  childAspectRatio: 0.63,
                ),
                itemBuilder: (context, index) {
                  final product = _filteredProducts[index];

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              ProductDetailsScreen(product: product),
                        ),
                      );
                    },
                    child: ProductCard(product: product),
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

class ProductCard extends StatelessWidget {
  final Map<String, String> product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Stack(
            children: [
              Positioned.fill(
                child: Hero(
                  tag: product["image"]!,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(product["image"]!, fit: BoxFit.cover),
                  ),
                ),
              ),

              Positioned(
                top: 10,
                right: 10,
                child: GestureDetector(
                  onTap: () async {
                    bool exists = await WishlistService.isInWishlist(
                      product["name"]!,
                    );

                    if (exists) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: const Color(0xff161616),
                          behavior: SnackBarBehavior.floating,
                          margin: const EdgeInsets.all(20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          content: Row(
                            children: [
                              const Icon(
                                Icons.favorite,
                                color: Color(0xffB79A63),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  "Already Part Of Your Collection",
                                  style: GoogleFonts.cormorantGaramond(
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                      return;
                    }

                    await WishlistService.addToWishlist(
                      productId: product["name"]!,
                      image: product["image"]!,
                      name: product["name"]!,
                      price: product["price"]!,
                      label: product["category"]!,
                    );

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: const Color(0xff161616),
                        behavior: SnackBarBehavior.floating,
                        margin: const EdgeInsets.all(20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        content: Row(
                          children: [
                            const Icon(
                              Icons.favorite,
                              color: Color(0xffB79A63),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                "Saved To Your Collection",
                                style: GoogleFonts.cormorantGaramond(
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.favorite_border,
                      size: 14,
                      color: dark,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 10),

        Text(
          product["category"]!,
          style: GoogleFonts.montserrat(
            fontSize: 8,
            color: light,
            letterSpacing: 1.2,
            fontWeight: FontWeight.w600,
          ),
        ),

        const SizedBox(height: 4),

        Text(
          product["name"]!,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: GoogleFonts.cormorantGaramond(fontSize: 18, color: dark),
        ),

        const SizedBox(height: 4),

        Text(
          product["price"]!,
          style: GoogleFonts.montserrat(
            fontSize: 12,
            color: gold,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

class ProductDetailsScreen extends StatelessWidget {
  final Map<String, String> product;

  const ProductDetailsScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,
      body: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * .65,
            width: double.infinity,
            child: Hero(
              tag: product["image"]!,
              child: Image.asset(product["image"]!, fit: BoxFit.cover),
            ),
          ),

          Positioned(
            top: 50,
            left: 20,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(.9),
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

          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * .42,
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product["category"]!,
                    style: GoogleFonts.montserrat(
                      fontSize: 10,
                      letterSpacing: 2,
                      color: gold,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 12),

                  Text(
                    product["name"]!,
                    style: GoogleFonts.cormorantGaramond(
                      fontSize: 36,
                      height: 1,
                      color: dark,
                    ),
                  ),

                  const SizedBox(height: 16),

                  Text(
                    product["price"]!,
                    style: GoogleFonts.montserrat(
                      fontSize: 24,
                      color: dark,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 20),

                  Text(
                    "Elegant luxury fashion crafted with timeless aesthetics and premium materials.",
                    style: GoogleFonts.montserrat(
                      fontSize: 13,
                      color: light,
                      height: 1.8,
                    ),
                  ),

                  const Spacer(),

                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () async {
                            await WishlistService.addToWishlist(
                              productId: product["name"]!,

                              image: product["image"]!,

                              name: product["name"]!,

                              price: product["price"]!,

                              label: product["category"]!,
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
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: const Icon(
                              Icons.favorite_border,
                              color: dark,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(width: 14),

                      Expanded(
                        flex: 3,
                        child: SizedBox(
                          height: 58,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: dark,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            onPressed: () async {
                              await CartService.addToCart(
                                productId: product["name"]!,
                                image: product["image"]!,
                                name: product["name"]!,
                                price: product["price"]!,
                                label: product["category"]!,
                                size: "M",
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
