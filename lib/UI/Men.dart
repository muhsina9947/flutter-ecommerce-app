import 'package:ecommerce_openfashion/UI/HomeScreen.dart';
import 'package:ecommerce_openfashion/UI/cart_screen.dart';
import 'package:ecommerce_openfashion/services/cart_service.dart';
import 'package:ecommerce_openfashion/services/wishlist_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MaisonLuxeApp());
}

const Color bg = Color(0xffF5F1EB);
const Color dark = Color(0xff161616);
const Color light = Color(0xff8E8A84);
const Color gold = Color(0xffB79A63);

class MaisonLuxeApp extends StatelessWidget {
  const MaisonLuxeApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _snack(BuildContext ctx, IconData icon, String msg) {
    ScaffoldMessenger.of(ctx).showSnackBar(
      SnackBar(
        backgroundColor: dark,
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(20),
        duration: const Duration(seconds: 2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        content: Row(
          children: [
            Icon(icon, color: gold, size: 20),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                msg,
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
  }

  void _toDetail(
    BuildContext ctx, {
    required String image,
    required String title,
    required String category,
    required String price,
    required String description,
  }) {
    Navigator.push(
      ctx,
      MaterialPageRoute(
        builder: (_) => ProductDetailsScreen(
          image: image,
          title: title,
          category: category,
          price: price,
          description: description,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 16,
                ),
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
                      'MAISON LUXE',
                      style: GoogleFonts.cormorantGaramond(
                        fontSize: 22,
                        letterSpacing: 2,
                        fontWeight: FontWeight.w600,
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

              GestureDetector(
                onTap: () => _toDetail(
                  context,
                  image: 'IMAGES/untitled-design-2023-08-08t161947-774.webp',
                  title: 'Architectural Mantle',
                  category: 'LUXURY EDIT',
                  price: '\$2,800',
                  description:
                      'A timeless statement silhouette crafted with elegant structure and luxurious tailoring.',
                ),
                child: Stack(
                  children: [
                    Hero(
                      tag: 'IMAGES/6171b6b360c86ce09212f4dda8e6c27b.jpg',
                      child: Image.asset(
                        'IMAGES/untitled-design-2023-08-08t161947-774.webp',
                        height: 450,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    // gradient overlay
                    Container(
                      height: 420,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.black.withOpacity(.10),
                            Colors.black.withOpacity(.50),
                          ],
                        ),
                      ),
                    ),
                    // small top label
                    Positioned(
                      top: 18,
                      left: 18,
                      child: Text(
                        'AVAILABLE NOW',
                        style: GoogleFonts.inter(
                          fontSize: 7,
                          letterSpacing: 3,
                          color: Colors.white.withOpacity(.75),
                        ),
                      ),
                    ),
                    // main text bottom-left
                    Positioned(
                      bottom: 32,
                      left: 18,
                      right: 18,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "THE MAISON MAN",
                            style: GoogleFonts.cormorantGaramond(
                              fontSize: 42,
                              height: .95,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 14),
                          Row(
                            children: [
                              Container(width: 24, height: 1, color: gold),
                              const SizedBox(width: 10),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(18, 48, 18, 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 55,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Curated Edit',
                            style: GoogleFonts.inter(
                              fontSize: 8,
                              letterSpacing: 3,
                              color: gold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'The Modern\nSilhouette',
                            style: GoogleFonts.cormorantGaramond(
                              fontSize: 36,
                              height: 1.05,
                              color: dark,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 14),
                    // right – body copy
                    Expanded(
                      flex: 45,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 32),
                        child: Text(
                          'Defining the contemporary form through structured wool and relaxed drape and modern geometry.',
                          style: GoogleFonts.inter(
                            fontSize: 11,
                            height: 1.85,
                            color: light,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              _featuredProductCard(context),

              const SizedBox(height: 56),

              _heritageSection(context),

              Container(
                width: double.infinity,
                color: dark,
                padding: const EdgeInsets.symmetric(
                  horizontal: 28,
                  vertical: 48,
                ),
                child: Column(
                  children: [
                    Text(
                      '\u201cTrue style is not\na noise; it is\na resonance.\u201d',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.cormorantGaramond(
                        fontSize: 28,
                        height: 1.5,
                        fontStyle: FontStyle.italic,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(width: 28, height: 1, color: gold),
                    const SizedBox(height: 14),
                    Text(
                      'THE MAISON LUXE MANIFESTO',
                      style: GoogleFonts.inter(
                        fontSize: 7,
                        letterSpacing: 3,
                        color: light,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 56),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'FEATURED IN',
                      style: GoogleFonts.inter(
                        fontSize: 8,
                        letterSpacing: 3,
                        color: gold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Bespoke\nAccessories',
                      style: GoogleFonts.cormorantGaramond(
                        fontSize: 42,
                        height: 1.05,
                        color: dark,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              _accessoryCard(
                context,
                image: 'IMAGES/Luxury Watch.png',
                title: 'The Chronos 01',
                category: 'TIMEPIECE',
                price: '\$4,200',
              ),
              const SizedBox(height: 28),

              _accessoryCard(
                context,
                image: 'IMAGES/istockphoto-533714204-612x612.jpg',
                title: 'The Chronos 01',
                category: 'TIMEPIECE',
                price: '\$4,200',
              ),
              const SizedBox(height: 2),

              _accessoryCard(
                context,
                image: 'IMAGES/Leather Bag.png',
                title: 'Italian Leather Holdall',
                category: 'LUGGAGE',
                price: '\$1,800',
              ),

              const SizedBox(height: 2),

              _accessoryCard(
                context,
                image: 'IMAGES/Silk Scarf.png',
                title: 'Heritage Cashmere Scarf',
                category: 'TEXTILE',
                price: '\$450',
              ),
              _accessoryCard(
                context,
                image: 'IMAGES/vvvvv.jpg',
                title: 'Chocolate Velvet Blazer',
                category: 'APPAREL',
                price: '\$650',
              ),

              _accessoryCard(
                context,
                image: 'IMAGES/vvvv.jpg',
                title: 'Rockstar Chic Leather Outfit Set',
                category: 'FULL SET',
                price: '\$645',
              ),

              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }

  Widget _featuredProductCard(BuildContext context) {
    const img = 'IMAGES/v.jpg';
    const title = 'Precision Wool Blazer';
    const category = 'TAILORING';
    const price = '\$3,200';
    const desc =
        'Sculpted from 100% Italian virgin wool, this blazer fuses structured tailoring with Southern European craftsmanship.';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // image
        Stack(
          children: [
            GestureDetector(
              onTap: () => _toDetail(
                context,
                image: img,
                title: title,
                category: category,
                price: price,
                description: desc,
              ),
              child: Image.asset(
                img,
                height: 380,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: 14,
              right: 14,
              child: _wishBtn(context, img, title, category, price),
            ),
          ],
        ),

        // info
        Container(
          color: const Color(0xffEFE9E1),
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                category,
                style: GoogleFonts.inter(
                  fontSize: 8,
                  letterSpacing: 3,
                  color: gold,
                ),
              ),
              const SizedBox(height: 6),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.cormorantGaramond(
                      fontSize: 26,
                      color: dark,
                    ),
                  ),
                  Text(
                    price,
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      color: dark,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                desc,
                style: GoogleFonts.inter(
                  fontSize: 11,
                  height: 1.75,
                  color: light,
                ),
              ),
              const SizedBox(height: 18),
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: _bagBtn(context, img, title, category, price),
                  ),
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: () => _toDetail(
                      context,
                      image: img,
                      title: title,
                      category: category,
                      price: price,
                      description: desc,
                    ),
                    child: Container(
                      height: 44,
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      decoration: BoxDecoration(
                        border: Border.all(color: dark.withOpacity(.35)),
                      ),
                      child: Center(
                        child: Text(
                          'DETAILS',
                          style: GoogleFonts.inter(
                            fontSize: 8,
                            letterSpacing: 2,
                            color: dark,
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
      ],
    );
  }

  Widget _heritageSection(BuildContext context) {
    const img = 'IMAGES/103106276.webp';
    const title = 'Architectural Mantle';
    const category = 'OUTERWEAR';
    const price = '\$2,800';
    const desc =
        'Please built for longevity. Our outerwear collection pairs precise pattern-making techniques with Southern materials finishing, creating a garment that will last for ages with grace.';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // section label
        Padding(
          padding: const EdgeInsets.fromLTRB(18, 0, 18, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'FEATURED IN',
                style: GoogleFonts.inter(
                  fontSize: 8,
                  letterSpacing: 3,
                  color: gold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Heritage\nOuterwear',
                style: GoogleFonts.cormorantGaramond(
                  fontSize: 42,
                  height: 1.05,
                  color: dark,
                ),
              ),
            ],
          ),
        ),

        // full-width image
        Stack(
          children: [
            GestureDetector(
              onTap: () => _toDetail(
                context,
                image: img,
                title: title,
                category: category,
                price: price,
                description: desc,
              ),
              child: Image.asset(
                img,
                height: 480,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: 14,
              right: 14,
              child: _wishBtn(context, img, title, category, price),
            ),
          ],
        ),

        Container(
          color: const Color(0xffEFE9E1),
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                desc,
                style: GoogleFonts.inter(
                  fontSize: 11.5,
                  height: 1.8,
                  color: light,
                ),
              ),
              const SizedBox(height: 20),

              // feature row 1
              _featureRow(
                Icons.verified_outlined,
                'MAISON CRÉDIT UNION',
                '0% interest free for 36 months with selected orders',
              ),
              const SizedBox(height: 12),

              // feature row 2
              _featureRow(
                Icons.shield_outlined,
                'LIFETIME WARRANTY',
                'Complimentary repair & replacement for life',
              ),

              const SizedBox(height: 22),

              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'FROM',
                        style: GoogleFonts.inter(
                          fontSize: 7,
                          letterSpacing: 2,
                          color: light,
                        ),
                      ),
                      Text(
                        price,
                        style: GoogleFonts.cormorantGaramond(
                          fontSize: 28,
                          color: dark,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: _bagBtn(context, img, title, category, price),
                  ),
                ],
              ),
            ],
          ),
        ),

        const SizedBox(height: 0),
      ],
    );
  }

  Widget _accessoryCard(
    BuildContext context, {
    required String image,
    required String title,
    required String category,
    required String price,
  }) {
    const desc =
        'Luxury crafted accessory designed with premium materials and elegant detailing.';

    return Container(
      color: const Color(0xffEFE9E1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              GestureDetector(
                onTap: () => _toDetail(
                  context,
                  image: image,
                  title: title,
                  category: category,
                  price: price,
                  description: desc,
                ),
                child: Hero(
                  tag: image,
                  child: Image.asset(
                    image,
                    height: 340,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: 14,
                right: 14,
                child: _wishBtn(context, image, title, category, price),
              ),
            ],
          ),

          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // title row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: GoogleFonts.cormorantGaramond(
                              fontSize: 24,
                              color: dark,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            category,
                            style: GoogleFonts.inter(
                              fontSize: 8,
                              letterSpacing: 2,
                              color: light,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      price,
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: dark,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 14),
                _bagBtn(context, image, title, category, price),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _wishBtn(
    BuildContext ctx,
    String image,
    String title,
    String category,
    String price,
  ) {
    return GestureDetector(
      onTap: () async {
        bool exists = await WishlistService.isInWishlist(title);

        if (exists) {
          if (ctx.mounted) {
            _snack(ctx, Icons.favorite, "Already Part Of Your Collection");
          }
          return;
        }

        await WishlistService.addToWishlist(
          productId: title,
          image: image,
          name: title,
          price: price,
          label: category,
        );

        if (ctx.mounted) {
          _snack(ctx, Icons.favorite, "Saved To Your Collection");
        }
      },

      child: Container(
        padding: const EdgeInsets.all(9),
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        child: const Icon(Icons.favorite_border, size: 18, color: dark),
      ),
    );
  }

  Widget _bagBtn(
    BuildContext ctx,
    String image,
    String title,
    String category,
    String price,
  ) {
    return GestureDetector(
      onTap: () async {
        await CartService.addToCart(
          productId: title,
          image: image,
          name: title,
          price: price,
          label: category,
          size: 'M',
        );
        if (ctx.mounted) {
          _snack(ctx, Icons.check_circle_outline, 'Added To Shopping Bag');
        }
      },
      child: Container(
        height: 44,
        width: double.infinity,
        color: dark,
        child: Center(
          child: Text(
            'ADD TO BAG',
            style: GoogleFonts.inter(
              fontSize: 9,
              letterSpacing: 2,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  Widget _featureRow(IconData icon, String title, String subtitle) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 18, color: gold),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.inter(
                  fontSize: 8,
                  letterSpacing: 1.5,
                  color: dark,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                subtitle,
                style: GoogleFonts.inter(
                  fontSize: 10,
                  height: 1.6,
                  color: light,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ProductDetailsScreen extends StatelessWidget {
  final String image;
  final String title;
  final String category;
  final String price;
  final String description;

  const ProductDetailsScreen({
    super.key,
    required this.image,
    required this.title,
    required this.category,
    required this.price,
    required this.description,
  });

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
              tag: image,
              child: Image.asset(image, fit: BoxFit.cover),
            ),
          ),

          Positioned(
            top: 50,
            left: 20,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
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
                    category,
                    style: GoogleFonts.inter(
                      fontSize: 10,
                      letterSpacing: 2,
                      color: gold,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    title,
                    style: GoogleFonts.cormorantGaramond(
                      fontSize: 38,
                      height: 1,
                      color: dark,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    price,
                    style: GoogleFonts.inter(
                      fontSize: 24,
                      color: dark,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 18),
                  Text(
                    description,
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      height: 1.8,
                      color: light,
                    ),
                  ),
                  const Spacer(),

                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () async {
                            await WishlistService.addToWishlist(
                              productId: title,
                              image: image,
                              name: title,
                              price: price,
                              label: category,
                            );
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: dark,
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
                                        Icons.favorite,
                                        color: gold,
                                        size: 20,
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Text(
                                          'Saved To Your Collection',
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
                            }
                          },
                          child: Container(
                            height: 56,
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
                          height: 56,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: dark,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            onPressed: () async {
                              await CartService.addToCart(
                                productId: title,
                                image: image,
                                name: title,
                                price: price,
                                label: category,
                                size: 'M',
                              );
                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    backgroundColor: dark,
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
                                          Icons.shopping_bag_outlined,
                                          color: gold,
                                          size: 20,
                                        ),
                                        const SizedBox(width: 12),
                                        Expanded(
                                          child: Text(
                                            'Added To Shopping Bag',
                                            style:
                                                GoogleFonts.cormorantGaramond(
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
                              }
                            },
                            child: Text(
                              'ADD TO BAG',
                              style: GoogleFonts.inter(
                                fontSize: 11,
                                letterSpacing: 2,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
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
