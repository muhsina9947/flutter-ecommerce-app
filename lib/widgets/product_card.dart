import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../services/cart_service.dart';
import '../services/wishlist_service.dart';

class ProductCard extends StatelessWidget {

  final String productId;
  final String image;
  final String name;
  final String price;
  final String category;
  final String size;

  const ProductCard({
    super.key,
    required this.productId,
    required this.image,
    required this.name,
    required this.price,
    required this.category,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {

    return Container(

      color: const Color(
        0xffEFE9E1,
      ),

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [

          Expanded(
            child: Stack(
              children: [

                Positioned.fill(
                  child: Image.asset(
                    image,
                    fit: BoxFit.cover,
                  ),
                ),

                Positioned(
                  top: 10,
                  right: 10,

                  child: GestureDetector(

                    onTap: () async {

                      await WishlistService
                          .addToWishlist(

                        productId:
                            productId,

                        image: image,

                        name: name,

                        price: price,

                        label:
                            category,
                      );
                    },

                    child: Container(

                      padding:
                          const EdgeInsets
                              .all(6),

                      decoration:
                          const BoxDecoration(

                        color:
                            Colors.white,

                        shape:
                            BoxShape.circle,
                      ),

                      child: const Icon(
                        Icons
                            .favorite_border,

                        size: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding:
                const EdgeInsets.all(
              12,
            ),

            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment
                      .start,

              children: [

                GestureDetector(

                  onTap: () async {

                    await CartService
                        .addToCart(

                      productId:
                          productId,

                      image: image,

                      name: name,

                      price: price,

                      label:
                          category,

                      size: size,
                    );
                  },

                  child: Container(

                    width:
                        double.infinity,

                    padding:
                        const EdgeInsets
                            .symmetric(
                      vertical: 10,
                    ),

                    decoration:
                        BoxDecoration(
                      border: Border.all(
                        color:
                            Colors.black26,
                      ),
                    ),

                    child: Center(
                      child: Text(

                        "ADD TO BAG",

                        style:
                            GoogleFonts
                                .inter(
                          fontSize: 8,
                          letterSpacing:
                              2,
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(
                  height: 14,
                ),

                Text(
                  name,

                  style:
                      GoogleFonts
                          .cormorantGaramond(
                    fontSize: 22,
                  ),
                ),

                const SizedBox(
                  height: 4,
                ),

                Text(
                  category,

                  style:
                      GoogleFonts.inter(
                    fontSize: 8,
                    letterSpacing: 2,
                    color: Colors.grey,
                  ),
                ),

                const SizedBox(
                  height: 8,
                ),

                Text(
                  price,

                  style:
                      GoogleFonts.inter(
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}