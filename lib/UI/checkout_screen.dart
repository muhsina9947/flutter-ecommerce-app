import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../services/auth_service.dart';

const Color bg = Color(0xffF5F1EB);
const Color dark = Color(0xff161616);
const Color light = Color(0xff8E8A84);
const Color gold = Color(0xffB79A63);

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  Stream<QuerySnapshot> _cartStream() {

    return FirebaseFirestore.instance
        .collection("users")
        .doc(AuthService.userId)
        .collection("cart")
        .snapshots();
  }

  double _calculateTotal(
    List<QueryDocumentSnapshot> docs,
  ) {

    double total = 0;

    for (var doc in docs) {

      String price =
          doc["price"]
              .toString()
              .replaceAll("\$", "")
              .replaceAll(",", "");

      total += double.tryParse(price) ?? 0;
    }

    return total;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: bg,

      appBar: AppBar(
        backgroundColor: bg,
        elevation: 0,

        centerTitle: true,

        title: Text(
          "CHECKOUT",

          style:
              GoogleFonts.cormorantGaramond(
            fontSize: 28,
            color: dark,
            letterSpacing: 3,
          ),
        ),

        iconTheme:
            const IconThemeData(
          color: dark,
        ),
      ),

      body: StreamBuilder<QuerySnapshot>(
        stream: _cartStream(),

        builder: (context, snapshot) {

          if (!snapshot.hasData) {
            return const Center(
              child:
                  CircularProgressIndicator(),
            );
          }

          final cartItems =
              snapshot.data!.docs;

          final subtotal =
              _calculateTotal(cartItems);

          const shipping = 120.0;

          final total =
              subtotal + shipping;

          return Padding(
            padding:
                const EdgeInsets.all(20),

            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [

                Text(
                  "ORDER SUMMARY",

                  style:
                      GoogleFonts.montserrat(
                    fontSize: 10,
                    letterSpacing: 2,
                    color: gold,
                    fontWeight:
                        FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 24),

                Expanded(
                  child: ListView.builder(
                    itemCount:
                        cartItems.length,

                    itemBuilder:
                        (context, index) {

                      final item =
                          cartItems[index];

                      return Container(
                        margin:
                            const EdgeInsets.only(
                          bottom: 18,
                        ),

                        child: Row(
                          children: [

                            ClipRRect(
                              borderRadius:
                                  BorderRadius.circular(
                                14,
                              ),

                              child: Image.asset(
                                item["image"],

                                height: 100,
                                width: 80,
                                fit: BoxFit.cover,
                              ),
                            ),

                            const SizedBox(width: 16),

                            Expanded(
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment
                                        .start,

                                children: [

                                  Text(
                                    item["label"],

                                    style:
                                        GoogleFonts
                                            .montserrat(
                                      fontSize: 9,
                                      color: gold,
                                      letterSpacing: 1.5,
                                    ),
                                  ),

                                  const SizedBox(
                                      height: 6),

                                  Text(
                                    item["name"],

                                    style:
                                        GoogleFonts
                                            .cormorantGaramond(
                                      fontSize: 24,
                                      color: dark,
                                    ),
                                  ),

                                  const SizedBox(
                                      height: 8),

                                  Text(
                                    item["price"],

                                    style:
                                        GoogleFonts
                                            .montserrat(
                                      fontSize: 13,
                                      fontWeight:
                                          FontWeight.bold,
                                      color: dark,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),

                const Divider(),

                const SizedBox(height: 10),

                _priceRow(
                  "Subtotal",
                  "\$${subtotal.toStringAsFixed(0)}",
                ),

                const SizedBox(height: 10),

                _priceRow(
                  "Shipping",
                  "\$120",
                ),

                const SizedBox(height: 16),

                _priceRow(
                  "TOTAL",
                  "\$${total.toStringAsFixed(0)}",
                  isTotal: true,
                ),

                const SizedBox(height: 30),

                SizedBox(
                  width: double.infinity,
                  height: 58,

                  child: ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(
                      backgroundColor: dark,

                      shape:
                          RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(
                          18,
                        ),
                      ),
                    ),

                    onPressed: () {

                      showDialog(
                        context: context,

                        builder: (_) =>
                            AlertDialog(
                          backgroundColor: bg,

                          title: Text(
                            "Order Placed",

                            style:
                                GoogleFonts
                                    .cormorantGaramond(
                              fontSize: 30,
                            ),
                          ),

                          content: Text(
                            "Your Maison Luxe order has been confirmed.",

                            style:
                                GoogleFonts
                                    .montserrat(
                              fontSize: 12,
                              color: light,
                            ),
                          ),
                        ),
                      );
                    },

                    child: Text(
                      "PLACE ORDER",

                      style:
                          GoogleFonts.montserrat(
                        fontSize: 11,
                        letterSpacing: 2,
                        color: Colors.white,
                        fontWeight:
                            FontWeight.w700,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 16),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _priceRow(
    String title,
    String value, {
    bool isTotal = false,
  }) {

    return Row(
      mainAxisAlignment:
          MainAxisAlignment.spaceBetween,

      children: [

        Text(
          title,

          style:
              GoogleFonts.montserrat(
            fontSize: isTotal ? 14 : 11,

            fontWeight:
                isTotal
                    ? FontWeight.bold
                    : FontWeight.w500,

            color: dark,
          ),
        ),

        Text(
          value,

          style:
              GoogleFonts.montserrat(
            fontSize: isTotal ? 16 : 12,

            fontWeight:
                FontWeight.bold,

            color:
                isTotal
                    ? gold
                    : dark,
          ),
        ),
      ],
    );
  }
}