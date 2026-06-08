import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../services/cart_service.dart';
import '../services/wishlist_service.dart';

class WishlistItem extends StatelessWidget {

  final String productId;
  final String image;
  final String name;
  final String price;
  final String label;

  const WishlistItem({
    super.key,
    required this.productId,
    required this.image,
    required this.name,
    required this.price,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {

    return Container(

      margin:
          const EdgeInsets.only(
        bottom: 18,
      ),

      child: Row(
        children: [

          Container(

            height: 120,
            width: 90,

            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  image,
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Column(

              crossAxisAlignment:
                  CrossAxisAlignment
                      .start,

              children: [

                Text(
                  name,

                  style:
                      GoogleFonts
                          .cormorantGaramond(
                    fontSize: 22,
                  ),
                ),

                const SizedBox(
                  height: 6,
                ),

                Text(
                  label,

                  style:
                      GoogleFonts.inter(
                    fontSize: 8,
                    letterSpacing: 2,
                    color: Colors.grey,
                  ),
                ),

                const SizedBox(
                  height: 10,
                ),

                Text(
                  price,

                  style:
                      GoogleFonts.inter(
                    fontSize: 12,
                  ),
                ),

                const SizedBox(
                  height: 16,
                ),

                GestureDetector(

                  onTap: () async {

                    await CartService
                        .addToCart(

                      productId:
                          productId,

                      image: image,

                      name: name,

                      price: price,

                      label: label,

                      size: "M",
                    );
                  },

                  child: Container(

                    padding:
                        const EdgeInsets
                            .symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),

                    decoration:
                        BoxDecoration(
                      border: Border.all(
                        color:
                            Colors.black26,
                      ),
                    ),

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
              ],
            ),
          ),

          GestureDetector(

            onTap: () {

              WishlistService
                  .removeWishlistItem(
                productId,
              );
            },

            child: const Icon(
              Icons.close,
              size: 18,
            ),
          ),
        ],
      ),
    );
  }
}