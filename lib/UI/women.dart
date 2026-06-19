import 'package:ecommerce_openfashion/UI/HomeScreen.dart';
import 'package:ecommerce_openfashion/UI/cart_screen.dart';
import 'package:ecommerce_openfashion/services/cart_service.dart';
import 'package:ecommerce_openfashion/services/wishlist_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color bg = Color(0xffF5F1EB);
const Color dark = Color(0xff161616);
const Color light = Color(0xff8E8A84);
const Color gold = Color(0xffB79A63);

void _showSnackbar(
  BuildContext context, {
  required IconData icon,
  required String message,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: dark,
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      content: Row(
        children: [
          Icon(icon, color: gold),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: GoogleFonts.cormorantGaramond(
                fontSize: 18,
                color: Colors.white,
                letterSpacing: 1,
              ),
            ),
          ),
        ],
      ),
      duration: const Duration(seconds: 2),
    ),
  );
}

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
    {
      "image": "IMAGES/jjjjjjjjjjjjjjjjjjjj.jpg",
      "category": "READY-TO-WEAR",
      "name": "Chanel Velvet Strapless Dress",
      "price": "\$7,100",
      "filter": "READY-TO-WEAR",
    },
    {
      "image": "IMAGES/jjjjjjjjjjjjjjjjj.webp",
      "category": "READY-TO-WEAR",
      "name": "Jacquemus La Robe Foulard Strapless Dress",
      "price": "\$1,120",
      "filter": "READY-TO-WEAR",
    },
    {
      "image": "IMAGES/jjjjjjjjjjjjjjjjjjjj.webp",
      "category": "READY-TO-WEAR",
      "name": "Calvin Klein Modern Cotton Bralette",
      "price": "\$4,8000",
      "filter": "READY-TO-WEAR",
    },
    {
      "image": "IMAGES/jjjjjjjjjjjjjjjjjj.webp",
      "category": "READY-TO-WEAR",
      "name": "Calvin Klein Denim Zip-Up Jacket",
      "price": "\$1,2800",
      "filter": "READY-TO-WEAR",
    },
    {
      "image": "IMAGES/jjjjjjjjjjj.jpg",
      "category": "READY-TO-WEAR",
      "name": "Lace Bustier & Wide-Leg Tweed Trousers",
      "price": "\$8,200",
      "filter": "READY-TO-WEAR",
    },
    {
      "image": "IMAGES/jjjjjjjj.jpg",
      "category": "READY-TO-WEAR",
      "name": "Classic Oversized Lambskin Leather Jacket",
      "price": "\$1,450",
      "filter": "READY-TO-WEAR",
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
                  Text(
                    "MAISON LUXE",
                    style: GoogleFonts.cormorantGaramond(
                      fontSize: 20,
                      letterSpacing: 4,
                      color: dark,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const CartScreen()),
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
                    onTap: () => setState(() => _selectedFilter = index),
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

              // Wishlist heart
              Positioned(
                top: 10,
                right: 10,
                child: GestureDetector(
                  onTap: () async {
                    final bool exists = await WishlistService.isInWishlist(
                      product["name"]!,
                    );
                    if (exists) {
                      _showSnackbar(
                        context,
                        icon: Icons.favorite,
                        message: "Already Part Of Your Collection",
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
                    _showSnackbar(
                      context,
                      icon: Icons.favorite,
                      message: "Saved To Your Collection",
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

class ProductDetailsScreen extends StatefulWidget {
  final Map<String, String> product;
  const ProductDetailsScreen({super.key, required this.product});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  bool _detailsExpanded = false;
  bool _shippingExpanded = false;
  bool _careExpanded = false;

  
  final List<Map<String, String>> _relatedProducts = const [
    {
      "image": "IMAGES/0b7736f6e0fccbaea56caff25688c2da.jpg",
      "category": "READY-TO-WEAR",
      "name": "Structured Wool Blazer",
      "price": "\$2,750",
    },
    {
      "image": "IMAGES/0718f052a163a4295664f03aa7b969f0.jpg",
      "category": "OUTERWEAR",
      "name": "Star-Worth Ivory Coat",
      "price": "\$4,100",
    },
    {
      "image":
          "IMAGES/Blackpink-Jennie-Chanel-goth-coquette-aesthetic-titkok-fashion-trend-2024-Paris-fashion-week-2-1-scaled.webp",
      "category": "READY-TO-WEAR",
      "name": "Ribbed Cashmere Turtleneck",
      "price": "\$890",
    },
    {
      "image": "IMAGES/May 21, 2026, 12_37_37 PM.png",
      "category": "READY-TO-WEAR",
      "name": "Wide-Leg Wool Trouser",
      "price": "\$1,200",
    },
    {
      "image": "IMAGES/S24_JENNIE_DIGI_PR_nologo_1080x1350_7.webp",
      "category": "READY-TO-WEAR",
      "name": "The Double Tote Bag",
      "price": "\$3,400",
    },
    {
      "image": "IMAGES/ChatGPT Image May 21, 2026, 12_43_40 PM.png",
      "category": "DRESSES",
      "name": "Sculptured Silk Blouse",
      "price": "\$1,560",
    },
    {
      "image": "IMAGES/51g8y-xHoDL._AC_UF894,1000_QL80_.jpg",
      "category": "DRESSES",
      "name": "Lace Atelier Evening Gown",
      "price": "\$7,200",
    },
    {
      "image": "IMAGES/jennie-2-1.jpg",
      "category": "DRESSES",
      "name": "Asymmetric Pleated Skirt",
      "price": "\$1,890",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: _buildHeader(context)),
            SliverToBoxAdapter(child: _buildProductImage()),
            SliverToBoxAdapter(child: _buildProductInfo()),
            SliverToBoxAdapter(child: _buildCTAButtons(context)),
            SliverToBoxAdapter(child: _buildAccordions()),
            SliverToBoxAdapter(child: _buildEditorialHeader()),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 10,
                  childAspectRatio: 0.65,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) =>
                      _RelatedProductCard(item: _relatedProducts[index]),
                  childCount: _relatedProducts.length,
                ),
              ),
            ),
            SliverToBoxAdapter(child: _buildFooter()),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back_ios, size: 18, color: dark),
          ),
          Text(
            "MAISON LUXE",
            style: GoogleFonts.cormorantGaramond(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              letterSpacing: 3,
              color: dark,
            ),
          ),
          const Icon(Icons.shopping_bag_outlined, size: 18, color: dark),
        ],
      ),
    );
  }

  Widget _buildProductImage() {
    return Container(
      height: 430,
      width: double.infinity,
      margin: const EdgeInsets.only(left: 16, right: 16, top: 8),
      decoration: BoxDecoration(
        color: const Color(0xffE8E4DC),
        borderRadius: BorderRadius.circular(2),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(2),
        child: Hero(
          tag: widget.product["image"]!,
          child: Image.asset(
            widget.product["image"]!,
            fit: BoxFit.cover,
            filterQuality: FilterQuality.high,
            alignment: Alignment.topCenter,
            errorBuilder: (_, __, ___) => Container(
              color: const Color(0xffE8E4DC),
              alignment: Alignment.center,
              child: const Icon(Icons.image_outlined, size: 40, color: gold),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProductInfo() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.product["category"]!,
            style: GoogleFonts.montserrat(
              fontSize: 8,
              color: gold,
              fontWeight: FontWeight.w600,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            widget.product["name"]!,
            style: GoogleFonts.cormorantGaramond(
              fontSize: 34,
              color: dark,
              fontWeight: FontWeight.w400,
              height: 1.05,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            widget.product["price"]!,
            style: GoogleFonts.montserrat(
              fontSize: 18,
              color: gold,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 14),
          Text(
            "Crafted for the woman who moves with quiet authority. A Maison Luxe atelier piece built on premium materials and timeless silhouette.",
            style: GoogleFonts.montserrat(
              fontSize: 10,
              color: light,
              height: 1.75,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCTAButtons(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Column(
        children: [
          // ADD TO BAG
          SizedBox(
            width: double.infinity,
            height: 55,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: dark,
                elevation: 0,
              ),
              onPressed: () async {
                await CartService.addToCart(
                  productId: widget.product["name"]!,
                  image: widget.product["image"]!,
                  name: widget.product["name"]!,
                  price: widget.product["price"]!,
                  label: widget.product["category"]!,
                  size: "M",
                );
                _showSnackbar(
                  context,
                  icon: Icons.shopping_bag_outlined,
                  message: "Added To Shopping Bag",
                );
              },
              child: Text(
                "ADD TO BAG",
                style: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 2.5,
                ),
              ),
            ),
          ),

          const SizedBox(height: 10),

          // WISHLIST
          GestureDetector(
            onTap: () async {
              final bool exists = await WishlistService.isInWishlist(
                widget.product["name"]!,
              );
              if (exists) {
                _showSnackbar(
                  context,
                  icon: Icons.favorite,
                  message: "Already Part Of Your Collection",
                );
                return;
              }
              await WishlistService.addToWishlist(
                productId: widget.product["name"]!,
                image: widget.product["image"]!,
                name: widget.product["name"]!,
                price: widget.product["price"]!,
                label: widget.product["category"]!,
              );
              _showSnackbar(
                context,
                icon: Icons.favorite,
                message: "Saved To Your Collection",
              );
            },
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 14),
              decoration: BoxDecoration(border: Border.all(color: dark)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.favorite, size: 14, color: gold),
                  const SizedBox(width: 8),
                  Text(
                    "WISHLIST",
                    style: GoogleFonts.montserrat(
                      color: dark,
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 2,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAccordions() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
      child: Column(
        children: [
          _accordionItem(
            "PRODUCT DETAILS",
            "Crafted from the finest materials sourced globally. Each piece is finished by hand in our Parisian atelier and inspected to the highest luxury standards.",
            _detailsExpanded,
            () => setState(() => _detailsExpanded = !_detailsExpanded),
          ),
          _accordionItem(
            "SHIPPING & RETURNS",
            "Complimentary worldwide shipping on all orders. Returns accepted within 14 days in original condition. Your order arrives in our signature Maison Luxe packaging.",
            _shippingExpanded,
            () => setState(() => _shippingExpanded = !_shippingExpanded),
          ),
          _accordionItem(
            "PRODUCT CARE",
            "Dry clean or hand wash only. Store folded in a cool, dry place away from direct sunlight. We recommend our exclusive Maison Luxe garment bags for long-term storage.",
            _careExpanded,
            () => setState(() => _careExpanded = !_careExpanded),
          ),
        ],
      ),
    );
  }

  Widget _accordionItem(
    String title,
    String content,
    bool isExpanded,
    VoidCallback onTap,
  ) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 14),
            decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: Color(0xffDDD8D0))),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: GoogleFonts.montserrat(
                    fontSize: 9,
                    color: dark,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1,
                  ),
                ),
                Icon(isExpanded ? Icons.remove : Icons.add, size: 16),
              ],
            ),
          ),
        ),
        if (isExpanded)
          Padding(
            padding: const EdgeInsets.only(bottom: 14),
            child: Text(
              content,
              style: GoogleFonts.montserrat(
                fontSize: 10,
                color: light,
                height: 1.7,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildEditorialHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 40, 20, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "EDITORIAL SELECTION",
            style: GoogleFonts.montserrat(
              fontSize: 8,
              color: gold,
              fontWeight: FontWeight.w600,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "Women's\nCollection",
            style: GoogleFonts.cormorantGaramond(
              fontSize: 38,
              color: dark,
              height: 1,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      color: dark,
      padding: const EdgeInsets.fromLTRB(20, 32, 20, 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "MAISON LUXE",
            style: GoogleFonts.cormorantGaramond(
              fontSize: 22,
              color: Colors.white,
              letterSpacing: 3,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            "Dressing women of distinction since 1924.",
            style: GoogleFonts.montserrat(
              fontSize: 9,
              color: Colors.white54,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}

class _RelatedProductCard extends StatefulWidget {
  final Map<String, String> item;
  const _RelatedProductCard({required this.item});

  @override
  State<_RelatedProductCard> createState() => _RelatedProductCardState();
}

class _RelatedProductCardState extends State<_RelatedProductCard> {
  bool isWishlisted = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ProductDetailsScreen(product: widget.item),
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Stack(
              children: [
                Positioned.fill(
                  child: Hero(
                    // suffix avoids Hero tag clash with collection grid
                    tag: "${widget.item["image"]!}_related",
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(2),
                      child: Image.asset(
                        widget.item["image"]!,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Container(
                          color: const Color(0xffE8E4DC),
                          alignment: Alignment.center,
                          child: const Icon(
                            Icons.image_outlined,
                            size: 32,
                            color: gold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: GestureDetector(
                    onTap: () async {
                      await WishlistService.addToWishlist(
                        productId: widget.item["name"]!,
                        image: widget.item["image"]!,
                        name: widget.item["name"]!,
                        price: widget.item["price"]!,
                        label: widget.item["category"]!,
                      );
                      setState(() => isWishlisted = true);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: dark,
                          behavior: SnackBarBehavior.floating,
                          margin: const EdgeInsets.all(20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          content: Row(
                            children: [
                              const Icon(Icons.favorite, color: gold),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  "Saved To Your Collection",
                                  style: GoogleFonts.cormorantGaramond(
                                    color: Colors.white,
                                    fontSize: 18,
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
                      child: Icon(
                        isWishlisted ? Icons.favorite : Icons.favorite_border,
                        size: 14,
                        color: isWishlisted ? gold : dark,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            widget.item["category"]!,
            style: GoogleFonts.montserrat(
              fontSize: 7.5,
              color: light,
              fontWeight: FontWeight.w600,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            widget.item["name"]!,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.cormorantGaramond(
              fontSize: 15,
              color: dark,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            widget.item["price"]!,
            style: GoogleFonts.montserrat(
              fontSize: 11,
              color: gold,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
