import 'package:ecommerce_openfashion/UI/bottom_nav.dart';
import 'package:ecommerce_openfashion/UI/cart_screen.dart';
import 'package:ecommerce_openfashion/UI/profile_screen.dart';

import 'package:ecommerce_openfashion/UI/wishlist_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'discover_screen.dart';

const double standardWidth = 342;
const double standardHeight = 427.5;
const Color bg = Color(0xffF5F1EB);
const Color dark = Color(0xff161616);
const Color light = Color(0xff8E8A84);
const Color gold = Color(0xffB79A63);

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _selectedIndex = 0;
  String _selectedCategory = "WOMEN";

  void navigateToDiscover(String category) {
    setState(() {
      _selectedIndex = 1;
      _selectedCategory = category;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      HomeScreen(onCategorySelected: navigateToDiscover),

      DiscoverScreen(selectedCategory: _selectedCategory),

      const WishlistScreen(),

      const CartScreen(),
      ProfileScreen()
    ];

    return Scaffold(
      backgroundColor: bg,
      body: screens[_selectedIndex],

      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final Function(String) onCategorySelected;
  const HomeScreen({required this.onCategorySelected, super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final double availableHeight = constraints.maxHeight;

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: availableHeight,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 14,
                          right: 14,
                          top: 10,
                          bottom: 12,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Icon(Icons.search, size: 20, color: dark),
                            Text(
                              "MAISON LUXE",
                              style: GoogleFonts.cormorantGaramond(
                                fontSize: 26,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 3.5,
                                color: dark,
                              ),
                            ),
                            const Icon(
                              Icons.notifications_none,
                              size: 20,
                              color: dark,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: InkFadeAnimator(
                          delayMs: 0,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Positioned.fill(
                                child: Image.asset(
                                  "IMAGES/ChatGPT Image May 21, 2026, 10_59_39 AM.png",
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      const ImageErrorPlaceholder(),
                                ),
                              ),
                              Positioned(
                                bottom: 40,
                                left: 0,
                                right: 0,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      "AUTUMN WINTER 2024",
                                      style: GoogleFonts.montserrat(
                                        color: Colors.white.withOpacity(0.8),
                                        fontSize: 8,
                                        letterSpacing: 2.5,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(height: 14),
                                    Text(
                                      "THE ART OF",
                                      style: GoogleFonts.cormorantGaramond(
                                        color: const Color(0xFFEAEAEA),
                                        fontSize: 36,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    Text(
                                      "UNDERSTATEMENT",
                                      style: GoogleFonts.cormorantGaramond(
                                        color: const Color(0xFFEAEAEA),
                                        fontSize: 36,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 32),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "CURATED FOR YOU",
                        style: GoogleFonts.montserrat(
                          fontSize: 10,
                          color: gold,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1.5,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            child: Text(
                              "New Collection",
                              maxLines: 1,
                              style: GoogleFonts.cormorantGaramond(
                                fontSize: 34,
                                color: dark,
                                fontWeight: FontWeight.w400,
                                height: 1.0,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(bottom: 2),
                            decoration: const BoxDecoration(
                              border: Border(
                                bottom: BorderSide(color: dark, width: 1.0),
                              ),
                            ),
                            
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                InkFadeAnimator(
                  delayMs: 100,
                  child: Center(
                    child: Container(
                      height: standardHeight,
                      width: standardWidth,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("IMAGES/unnamed (1).png"),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withOpacity(.6),
                            ],
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "The Sculptural\nSeries",
                              style: GoogleFonts.cormorantGaramond(
                                color: Colors.white,
                                height: .9,
                                fontSize: 33,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              "Hand-finished garments that redefine the silhouette.",
                              style: GoogleFonts.montserrat(
                                color: Colors.white70,
                                fontSize: 9,
                                height: 1.8,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                InkFadeAnimator(
                  delayMs: 200,
                  child: Center(
                    child: SizedBox(
                      width: standardWidth,
                      child: Column(
                        children: [
                          Image.asset(
                            "IMAGES/unnamed (2).png",
                            height: standardHeight,
                            width: standardWidth,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                const ImageErrorPlaceholder(),
                          ),
                          const SizedBox(height: 12),
                          Container(
                            width: standardWidth,
                            color: const Color(0xffEBE8E3),
                            padding: const EdgeInsets.all(24),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "ACCESSORIES",
                                  style: GoogleFonts.montserrat(
                                    fontSize: 9,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 2.0,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  "The Noir Belt",
                                  style: GoogleFonts.cormorantGaramond(
                                    fontSize: 32,
                                    color: dark,
                                  ),
                                ),
                                const SizedBox(height: 14),
                                Text(
                                  "Italian leather, hand-polished edges.",
                                  style: GoogleFonts.montserrat(
                                    fontSize: 11,
                                    color: Colors.black,
                                    height: 1.6,
                                  ),
                                ),
                                const SizedBox(height: 24),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 24,
                                    vertical: 12,
                                  ),
                                  child: Text(
                                    "DISCOVER",
                                    style: GoogleFonts.montserrat(
                                      fontSize: 9,
                                      letterSpacing: 2.0,
                                      fontWeight: FontWeight.w600,
                                      color: dark,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 48),
                Center(
                  child: Text(
                    "Trending Picks",
                    style: GoogleFonts.cormorantGaramond(
                      fontSize: 36,
                      color: dark,
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      trendingProductCard(
                        "IMAGES/unnamed (3).png",
                        "Maison Luxe Essentials",
                        "Cashmere Oversized Sweater",
                        "8,890",
                      ),
                      const SizedBox(width: 16),
                      trendingProductCard(
                        "IMAGES/unnamed (4).png",
                        "Maison Luxe Essentials",
                        "Structured Wool Tailored Blazer",
                        "12,450",
                      ),
                      const SizedBox(width: 16),
                      trendingProductCard(
                        "IMAGES/unnamed (5).png",
                        "Maison Luxe Essentials",
                        "Heritage Gold Minimalist Ring",
                        "4,200",
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 48),
                Center(
                  child: Text(
                    "Designer\nCategories",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.cormorantGaramond(
                      fontSize: 43,
                      height: .95,
                      color: dark,
                    ),
                  ),
                ),
                const SizedBox(height: 28),

                categoryCard("IMAGES/unnamed (7).png", "WOMEN", 100),
                const SizedBox(height: 14),
                categoryCard("IMAGES/unnamed (8).png", "MEN", 200),
                const SizedBox(height: 14),
                categoryCard("IMAGES/unnamed (9).png", "JEWELRY", 300),

                const SizedBox(height: 80),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget trendingProductCard(
    String imagePath,
    String brandName,
    String productName,
    String price,
  ) {
    return SizedBox(
      width: 200,
      height: 320,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 220,
            child: Stack(
              children: [
                Positioned.fill(
                  child: Image.asset(
                    imagePath,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        const ImageErrorPlaceholder(),
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.favorite_border,
                      size: 14,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Text(
            brandName.toUpperCase(),
            style: GoogleFonts.montserrat(
              fontSize: 8.5,
              color: dark,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            productName,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.montserrat(
              fontSize: 11,
              color: light,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "\$ $price",
            style: GoogleFonts.montserrat(
              fontSize: 12,
              color: gold,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget categoryCard(String imagePath, String title, int delay) {
    return InkFadeAnimator(
      delayMs: delay,
      child: Center(
        child: GestureDetector(
          onTap: () => onCategorySelected(title),
          child: Container(
            width: standardWidth,
            height: standardHeight,
            margin: const EdgeInsets.only(bottom: 14),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: [
                Positioned.fill(
                  child: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white.withOpacity(0.3),
                          width: 0.8,
                        ),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    title,
                    style: GoogleFonts.cormorantGaramond(
                      color: Colors.white,
                      fontSize: 34,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 4.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class InkFadeAnimator extends StatefulWidget {
  final Widget child;
  final int delayMs;
  const InkFadeAnimator({required this.child, this.delayMs = 0, super.key});

  @override
  State<InkFadeAnimator> createState() => _InkFadeAnimatorState();
}

class _InkFadeAnimatorState extends State<InkFadeAnimator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutCubic),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.08),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));
    Future.delayed(Duration(milliseconds: widget.delayMs), () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Opacity(
          opacity: _opacityAnimation.value,
          child: Transform.translate(
            offset: Offset(0, _slideAnimation.value.dy * 100),
            child: widget.child,
          ),
        );
      },
    );
  }
}

class ImageErrorPlaceholder extends StatelessWidget {
  const ImageErrorPlaceholder({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade300,
      alignment: Alignment.center,
      child: const Icon(Icons.image_outlined, color: Colors.grey, size: 24),
    );
  }
}
