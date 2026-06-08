import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../services/auth_service.dart';
import '../services/cart_service.dart';
import 'checkout_screen.dart';

const Color bg = Color(0xffF5F1EB);
const Color dark = Color(0xff161616);
const Color gold = Color(0xffB79A63);
const Color lite = Color(0xff8E8A84);

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  Stream<QuerySnapshot> _cartStream() {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(AuthService.userId)
        .collection("cart")
        .orderBy("createdAt", descending: true)
        .snapshots();
  }

  double _calculateTotal(List<QueryDocumentSnapshot> docs) {
    double total = 0;
    for (var doc in docs) {
      final data = doc.data() as Map<String, dynamic>;
      String price = data["price"]?.toString() ?? "0";
      price = price
          .replaceAll("\$", "")
          .replaceAll("₹", "")
          .replaceAll(",", "");
      final quantity = data["quantity"] ?? 1;
      total += (double.tryParse(price) ?? 0) * quantity;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        child: StreamBuilder<QuerySnapshot>(
          stream: _cartStream(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(color: dark, strokeWidth: 1),
              );
            }

            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.shopping_bag_outlined,
                      size: 48,
                      color: lite,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "Your Bag Is Empty",
                      style: GoogleFonts.cormorantGaramond(
                        fontSize: 32,
                        color: dark,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Add pieces to begin your edit",
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: lite,
                        letterSpacing: .5,
                      ),
                    ),
                  ],
                ),
              );
            }

            final cartItems = snapshot.data!.docs;
            final subtotal = _calculateTotal(cartItems);
            final tax = subtotal * 0.08;
            final total = subtotal + tax;

            return SingleChildScrollView(
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
                        const Icon(Icons.search, size: 22, color: dark),
                        Text(
                          "MAISON LUXE",
                          style: GoogleFonts.cormorantGaramond(
                            fontSize: 20,
                            letterSpacing: 4,
                            fontWeight: FontWeight.w600,
                            color: dark,
                          ),
                        ),
                        const Icon(
                          Icons.notifications_none,
                          size: 22,
                          color: dark,
                        ),
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(18, 8, 18, 4),
                    child: Text(
                      "Shopping Bag",
                      style: GoogleFonts.cormorantGaramond(
                        fontSize: 40,
                        color: dark,
                        height: 1.1,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(18, 0, 18, 24),
                    child: Text(
                      "${cartItems.length} Items Curated",
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: lite,
                        letterSpacing: .3,
                      ),
                    ),
                  ),

                  ...cartItems.map((item) {
                    final data = item.data() as Map<String, dynamic>;
                    final image = data["image"] ?? "";
                    final name = data["name"] ?? "";
                    final label = data["label"] ?? "";
                    final price = data["price"] ?? "";
                    final size = data["size"] ?? "";
                    final quantity = data["quantity"] ?? 1;

                    final labelUp = label.toString().toUpperCase();

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Image.asset(
                            image,
                            height: 427.5,
                            width: 342,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => Container(
                              height: 320,
                              color: const Color(0xffE8E2DA),
                              child: const Center(
                                child: Icon(
                                  Icons.image_outlined,
                                  size: 40,
                                  color: lite,
                                ),
                              ),
                            ),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.fromLTRB(18, 16, 18, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    labelUp,
                                    style: GoogleFonts.inter(
                                      fontSize: 9,
                                      letterSpacing: 2,
                                      color: lite,
                                    ),
                                  ),
                                  Text(
                                    price,
                                    style: GoogleFonts.cormorantGaramond(
                                      fontSize: 32,
                                      color: dark,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 2),

                              Text(
                                name,
                                style: GoogleFonts.cormorantGaramond(
                                  fontSize: 30,
                                  color: dark,
                                  height: 1.1,
                                ),
                              ),

                              const SizedBox(height: 4),

                              Text(
                                "$size / Size ${data["sizeLabel"] ?? size}",
                                style: GoogleFonts.inter(
                                  fontSize: 11,
                                  color: lite,
                                ),
                              ),

                              const SizedBox(height: 16),

                              Row(
                                children: [
                                  Container(
                                    height: 36,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: dark.withOpacity(.25),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        _qtyBtn(
                                          icon: Icons.remove,
                                          onTap: () =>
                                              CartService.decreaseQuantity(
                                                item.id,
                                                quantity,
                                              ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 14,
                                          ),
                                          child: Text(
                                            quantity.toString().padLeft(2, '0'),
                                            style: GoogleFonts.inter(
                                              fontSize: 13,
                                              color: dark,
                                            ),
                                          ),
                                        ),
                                        _qtyBtn(
                                          icon: Icons.add,
                                          onTap: () =>
                                              CartService.increaseQuantity(
                                                item.id,
                                                quantity,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  const SizedBox(width: 18),

                                  // remove
                                  GestureDetector(
                                    onTap: () =>
                                        CartService.removeItem(item.id),
                                    child: Text(
                                      "REMOVE",
                                      style: GoogleFonts.inter(
                                        fontSize: 9,
                                        letterSpacing: 1.5,
                                        color: dark,
                                        decoration: TextDecoration.underline,
                                        decorationColor: dark,
                                      ),
                                    ),
                                  ),

                                  const Spacer(),

                                  // wishlist heart
                                  const Icon(
                                    Icons.favorite_border,
                                    size: 20,
                                    color: dark,
                                  ),
                                ],
                              ),

                              const SizedBox(height: 32),

                              // divider between items
                              Divider(color: dark.withOpacity(.1), height: 1),

                              const SizedBox(height: 32),
                            ],
                          ),
                        ),
                      ],
                    );
                  }),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(18, 0, 18, 0),
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        border: Border.all(color: dark.withOpacity(.15)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "ORDER SUMMARY",
                            style: GoogleFonts.inter(
                              fontSize: 9,
                              letterSpacing: 2,
                              color: dark,
                              fontWeight: FontWeight.w600,
                            ),
                          ),

                          const SizedBox(height: 20),

                          _summaryRow(
                            "Subtotal",
                            "\$${subtotal.toStringAsFixed(0)}",
                          ),

                          const SizedBox(height: 10),

                          _summaryRowWidget(
                            "Standard\nShipping",
                            Text(
                              "COMPLIMENTARY",
                              style: GoogleFonts.inter(
                                fontSize: 10,
                                letterSpacing: 1,
                                color: gold,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),

                          const SizedBox(height: 10),

                          _summaryRow("Tax", "\$${tax.toStringAsFixed(0)}"),

                          const SizedBox(height: 20),

                          Divider(color: dark.withOpacity(.12), height: 1),

                          const SizedBox(height: 20),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "TOTAL",
                                style: GoogleFonts.inter(
                                  fontSize: 10,
                                  letterSpacing: 2,
                                  color: dark,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                "\$${total.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]},')}",
                                style: GoogleFonts.cormorantGaramond(
                                  fontSize: 38,
                                  color: dark,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 20),

                          SizedBox(
                            width: double.infinity,
                            height: 52,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: dark,
                                elevation: 0,
                                shape: const RoundedRectangleBorder(),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const CheckoutScreen(),
                                  ),
                                );
                              },
                              child: Text(
                                "CHECKOUT",
                                style: GoogleFonts.inter(
                                  fontSize: 11,
                                  letterSpacing: 3,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 14),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.lock_outline, size: 11, color: lite),
                              const SizedBox(width: 5),
                              Text(
                                "SECURE ENCRYPTED CHECKOUT",
                                style: GoogleFonts.inter(
                                  fontSize: 8,
                                  letterSpacing: 1.5,
                                  color: lite,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 28),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Complimentary Gift Wrapping",
                          style: GoogleFonts.cormorantGaramond(
                            fontSize: 18,
                            color: dark,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          "Each order from Maison Luxe arrives in our signature FSC-certified packaging, finished with a silk ribbon and seasonal floral sprig.",
                          style: GoogleFonts.inter(
                            fontSize: 11,
                            height: 1.75,
                            color: lite,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 32),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _qtyBtn({required IconData icon, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 36,
        height: 36,
        child: Icon(icon, size: 16, color: dark),
      ),
    );
  }

  Widget _summaryRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: GoogleFonts.inter(fontSize: 12, color: lite)),
        Text(value, style: GoogleFonts.inter(fontSize: 12, color: dark)),
      ],
    );
  }

  Widget _summaryRowWidget(String label, Widget valueWidget) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(fontSize: 12, color: lite, height: 1.5),
        ),
        valueWidget,
      ],
    );
  }
}
