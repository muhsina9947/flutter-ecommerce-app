import 'package:ecommerce_openfashion/services/cart_service.dart';
import 'package:ecommerce_openfashion/services/wishlist_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color bg = Color(0xffF5F1EB);
const Color dark = Color(0xff161616);
const Color light = Color(0xff8E8A84);
const Color gold = Color(0xffB79A63);

class JewelryDetailScreen extends StatefulWidget {
  final String image;
  final String name;
  final String price;
  final String label;

  const JewelryDetailScreen({
    super.key,
    required this.image,
    required this.name,
    required this.price,
    required this.label,
  });

  @override
  State<JewelryDetailScreen> createState() => _JewelryDetailScreenState();
}

class _JewelryDetailScreenState extends State<JewelryDetailScreen> {
  bool _detailsExpanded = false;
  bool _shippingExpanded = false;
  bool _careExpanded = false;

  final List<Map<String, String>> _editorialItems = const [
    {
      "image": "IMAGES/ChatGPT Image May 21, 2026, 11_51_55 AM.png",
      "label": "RINGS",
      "name": "Minimalist Gold Drop",
      "price": "\$1,460",
    },
    {
      "image": "IMAGES/ChatGPT Image May 21, 2026, 11_53_51 AM.png",
      "label": "RINGS",
      "name": "Signet du Paris",
      "price": "\$1,280",
    },
    {
      "image": "IMAGES/ChatGPT Image May 21, 2026, 12_23_06 PM.png",
      "label": "WATCHES",
      "name": "Chronos Ivory I",
      "price": "\$8,600",
    },
    {
      "image": "IMAGES/ChatGPT Image May 21, 2026, 11_50_14 AM.png",
      "label": "BRACELETS",
      "name": "Sculpture Cuff",
      "price": "\$3,200",
    },
    {
      "image": "IMAGES/CHAIN3.png",
      "label": "RINGS",
      "name": "The Pavé Band",
      "price": "\$13,500",
    },
    {
      "image": "IMAGES/ChatGPT Image May 21, 2026, 11_33_59 AM.png",
      "label": "RINGS",
      "name": "Diamond Solitaire Studs",
      "price": "\$14,600",
    },
    {
      "image": "IMAGES/ChatGPT Image May 21, 2026, 12_17_57 PM.png",
      "label": "NECKLACES",
      "name": "Heritage Link Bracelet",
      "price": "\$4,200",
    },
    {
      "image": "IMAGES/ChatGPT Image May 21, 2026, 11_44_48 AM.png",
      "label": "NECKLACES",
      "name": "Heritage Link Bracelet",
      "price": "\$4,200",
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

            SliverToBoxAdapter(child: _buildCTAButtons()),

            SliverToBoxAdapter(child: _buildAccordions()),

            SliverToBoxAdapter(child: _buildArtisanStory()),

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
                      _EditorialCard(item: _editorialItems[index]),
                  childCount: _editorialItems.length,
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
          tag: widget.image,

          child: Image.asset(
            widget.image,

            fit: BoxFit.cover,

            filterQuality: FilterQuality.high,

            alignment: Alignment.topCenter,

            errorBuilder: (_, __, ___) {
              return Container(
                color: const Color(0xffE8E4DC),
                alignment: Alignment.center,

                child: const Icon(Icons.image_outlined, size: 40, color: gold),
              );
            },
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
            widget.label,
            style: GoogleFonts.montserrat(
              fontSize: 8,
              color: gold,
              fontWeight: FontWeight.w600,
              letterSpacing: 2,
            ),
          ),

          const SizedBox(height: 6),

          Text(
            widget.name,
            style: GoogleFonts.cormorantGaramond(
              fontSize: 34,
              color: dark,
              fontWeight: FontWeight.w400,
              height: 1.05,
            ),
          ),

          const SizedBox(height: 10),

          Text(
            widget.price,
            style: GoogleFonts.montserrat(
              fontSize: 18,
              color: gold,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 14),

          Text(
            "Hand-crafted in our Parisian atelier, this exclusive Maison Luxe piece blends timeless elegance with modern sophistication.",
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

  Widget _buildCTAButtons() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Column(
        children: [
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
                  productId: widget.name,
                  image: widget.image,
                  name: widget.name,
                  price: widget.price,
                  label: widget.label,
                  size: "M",
                );

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: const Color(0xff161616),
                    elevation: 0,
                    behavior: SnackBarBehavior.floating,
                    margin: const EdgeInsets.all(20),

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),

                    content: Row(
                      children: [
                        const Icon(
                          Icons.check_circle_outline,
                          color: Color(0xffB79A63),
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

                    duration: const Duration(seconds: 2),
                  ),
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

          GestureDetector(
            onTap: () async {
              bool exists = await WishlistService.isInWishlist(widget.name);

              if (exists) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: const Color(0xff161616),
                    elevation: 0,
                    behavior: SnackBarBehavior.floating,
                    margin: const EdgeInsets.all(20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    content: Row(
                      children: [
                        const Icon(Icons.favorite, color: Color(0xffB79A63)),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            "Already Part Of Your Collection",
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
                return;
              }

              await WishlistService.addToWishlist(
                productId: widget.name,
                image: widget.image,
                name: widget.name,
                price: widget.price,
                label: widget.label,
              );

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: const Color(0xff161616),
                  elevation: 0,
                  behavior: SnackBarBehavior.floating,
                  margin: const EdgeInsets.all(20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  content: Row(
                    children: [
                      const Icon(Icons.favorite, color: Color(0xffB79A63)),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          "Saved To Your Collection",
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
            "18kt yellow gold. Luxury handcrafted finish.",
            _detailsExpanded,
            () {
              setState(() {
                _detailsExpanded = !_detailsExpanded;
              });
            },
          ),

          _accordionItem(
            "SHIPPING & RETURNS",
            "Worldwide shipping available.",
            _shippingExpanded,
            () {
              setState(() {
                _shippingExpanded = !_shippingExpanded;
              });
            },
          ),

          _accordionItem(
            "PRODUCT CARE",
            "Store in a dry luxury pouch.",
            _careExpanded,
            () {
              setState(() {
                _careExpanded = !_careExpanded;
              });
            },
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

  Widget _buildArtisanStory() {
    return Column(
      children: [
        const SizedBox(height: 32),

        Container(
          height: 600,
          width: 342,
          color: const Color(0xff1A1A1A),
          child: Image.asset("IMAGES/gold.png", fit: BoxFit.cover),
        ),

        Padding(
          padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "The Alchemy of Gold",
                style: GoogleFonts.cormorantGaramond(fontSize: 28, color: dark),
              ),

              const SizedBox(height: 14),

              Text(
                "Every Maison Luxe creation is shaped through timeless craftsmanship.",
                style: GoogleFonts.montserrat(
                  fontSize: 10,
                  color: light,
                  height: 1.75,
                ),
              ),
            ],
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
            "Jewelry\nCollection",
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
            "Preserving the art of luxury jewelry since 1924.",
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

class _EditorialCard extends StatefulWidget {
  final Map<String, String> item;

  const _EditorialCard({required this.item});

  @override
  State<_EditorialCard> createState() => _EditorialCardState();
}

class _EditorialCardState extends State<_EditorialCard> {
  bool isWishlisted = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => JewelryDetailScreen(
              image: widget.item["image"]!,
              name: widget.item["name"]!,
              price: widget.item["price"]!,
              label: widget.item["label"]!,
            ),
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
                    tag: widget.item["image"]!,
                    child: Image.asset(
                      widget.item["image"]!,
                      fit: BoxFit.cover,
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
                        label: widget.item["label"]!,
                      );

                      setState(() {
                        isWishlisted = true;
                      });

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: dark,
                          behavior: SnackBarBehavior.floating,
                          content: Text(
                            "Saved To Your Collection",
                            style: GoogleFonts.cormorantGaramond(
                              color: Colors.white,
                              fontSize: 18,
                            ),
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
            widget.item["label"]!,
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
