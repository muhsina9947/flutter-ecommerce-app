import 'package:ecommerce_openfashion/UI/Jewelry.dart';
import 'package:ecommerce_openfashion/UI/Men.dart';
import 'package:ecommerce_openfashion/UI/women.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color bg = Color(0xffF5F1EB);
const Color dark = Color(0xff161616);
const Color light = Color(0xff8E8A84);
const Color gold = Color(0xffB79A63);

class DiscoverScreen extends StatelessWidget {
  final String selectedCategory;
  const DiscoverScreen({required this.selectedCategory, super.key});

  Widget _resolveScreen() {
    switch (selectedCategory.toUpperCase()) {
      case "WOMEN":
        return const WomenCollectionScreen();
      case "MEN":
        return const MaisonLuxeApp();
      case "JEWELRY":
        return const JewelryDetailScreen(
          image: "IMAGES/CHAIN3.png",
          name: "Luxury Gold Chain",
          price: "\$4,200",
          label: "NECKLACES",
        );
      default:
        return _GenericDiscoverScreen(category: selectedCategory);
    }
  }

  @override
  Widget build(BuildContext context) {
    return _resolveScreen();
  }
}

class _GenericDiscoverScreen extends StatelessWidget {
  final String category;
  const _GenericDiscoverScreen({required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.maybePop(context),
                    child: const Icon(
                      Icons.arrow_back_ios,
                      size: 18,
                      color: dark,
                    ),
                  ),
                  Text(
                    "MAISON LUXE",
                    style: GoogleFonts.cormorantGaramond(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 3.0,
                      color: dark,
                    ),
                  ),
                  const Icon(Icons.search, size: 18, color: dark),
                ],
              ),
              const SizedBox(height: 32),
              Text(
                "DISCOVER",
                style: GoogleFonts.montserrat(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                  color: light,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                category,
                style: GoogleFonts.cormorantGaramond(
                  fontSize: 42,
                  fontWeight: FontWeight.w400,
                  color: dark,
                ),
              ),
              const Divider(color: Colors.black26, height: 30),
              Expanded(
                child: Center(
                  child: Text(
                    "Showing items for $category Collection",
                    style: GoogleFonts.montserrat(fontSize: 14, color: light),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
