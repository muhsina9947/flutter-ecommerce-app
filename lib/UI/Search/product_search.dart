import 'package:ecommerce_openfashion/UI/Men.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductSearchDelegate extends SearchDelegate {
  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
      scaffoldBackgroundColor: bg,
      appBarTheme: const AppBarTheme(backgroundColor: bg, elevation: 0),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: GoogleFonts.montserrat(color: light, fontSize: 14),
        border: InputBorder.none,
      ),
    );
  }

  @override
  String get searchFieldLabel => "Search Maison Luxe";

  final List<Map<String, String>> products;

  ProductSearchDelegate(this.products);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(icon: const Icon(Icons.close), onPressed: () => query = ""),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back_ios),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = products.where((product) {
      final name = product["name"]?.toLowerCase() ?? "";
      final filter = product["filter"]?.toLowerCase() ?? "";

      if (query.toLowerCase() == "women") {
        return filter == "ready-to-wear" ||
            filter == "outerwear" ||
            filter == "dresses";
      }

      if (query.toLowerCase() == "men") {
        return filter == "men";
      }

      if (query.toLowerCase() == "jewelry") {
        return product["category"] == "RINGS" ||
            product["category"] == "BRACELETS" ||
            product["category"] == "NECKLACES" ||
            product["category"] == "WATCHES";
      }

      return name.contains(query.toLowerCase());
    }).toList();
    return _buildProductList(results);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
              children: [_chip("Women"), _chip("Jewelry"), _chip("Men")],
            ),
          ],
        ),
      );
    }
    final results = products.where((product) {
      final name = product["name"]?.toLowerCase() ?? "";
      final category = product["category"]?.toLowerCase() ?? "";

      if (query.toLowerCase() == "women") {
        return category == "ready-to-wear" ||
            category == "dresses" ||
            category == "outerwear";
      }

      if (query.toLowerCase() == "jewelry") {
        return category == "rings" ||
            category == "bracelets" ||
            category == "necklaces";
      }

      if (query.toLowerCase() == "men") {
        return category == "timepiece" ||
            category == "luggage" ||
            category == "textile";
      }

      return name.contains(query.toLowerCase()) ||
          category.contains(query.toLowerCase());
    }).toList();

    return _buildProductList(results);
  }

  Widget _chip(String text) {
    return ActionChip(
      label: Text(text),
      onPressed: () {
        query = text;
      },
    );
  }

  Widget _buildProductList(List<Map<String, String>> results) {
    if (results.isEmpty) {
      return Center(
        child: Text(
          "No products found",
          style: GoogleFonts.cormorantGaramond(fontSize: 24, color: dark),
        ),
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: results.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 14,
        mainAxisSpacing: 18,
        childAspectRatio: 0.62,
      ),
      itemBuilder: (context, index) {
        final product = results[index];

        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ProductDetailsScreen(
                  image: product["image"]!,
                  title: product["name"]!,
                  category: product["category"] ?? "PRODUCT",
                  price: product["price"]!,
                  description: "Luxury crafted piece.",
                ),
              ),
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    product["image"]!,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              const SizedBox(height: 10),

              Text(
                product["category"] ?? "",
                style: GoogleFonts.montserrat(
                  fontSize: 8,
                  color: gold,
                  letterSpacing: 1.5,
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
          ),
        );
      },
    );
  }
}
