import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color bg = Color(0xffF5F1EB);
const Color dark = Color(0xff161616);
const Color light = Color(0xff8E8A84);
const Color gold = Color(0xffB79A63);

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 18,
                vertical: 14,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
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

                  const SizedBox(width: 18),
                ],
              ),
            ),

            const SizedBox(height: 30),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "DISCOVER",
                    style: GoogleFonts.montserrat(
                      color: gold,
                      fontSize: 10,
                      letterSpacing: 2,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    "Search\nCollection",
                    style: GoogleFonts.cormorantGaramond(
                      fontSize: 48,
                      height: 0.95,
                      color: dark,
                    ),
                  ),

                  const SizedBox(height: 30),

                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey.shade300,
                      ),
                      color: Colors.white.withOpacity(.7),
                    ),
                    child: TextField(
                      controller: searchController,
                      style: GoogleFonts.montserrat(
                        color: dark,
                        fontSize: 14,
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 18,
                        ),
                        prefixIcon: const Icon(
                          Icons.search,
                          color: dark,
                        ),
                        hintText: "Search products...",
                        hintStyle: GoogleFonts.montserrat(
                          color: light,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 40),

                  Text(
                    "POPULAR SEARCHES",
                    style: GoogleFonts.montserrat(
                      fontSize: 10,
                      color: gold,
                      letterSpacing: 2,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 20),

                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      luxuryTag("Women"),
                      luxuryTag("Men"),
                      luxuryTag("Jewelry"),
                      luxuryTag("Accessories"),
                      luxuryTag("Outerwear"),
                      luxuryTag("Bags"),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget luxuryTag(String title) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: dark),
      ),
      child: Text(
        title.toUpperCase(),
        style: GoogleFonts.montserrat(
          fontSize: 10,
          letterSpacing: 1.5,
          color: dark,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}