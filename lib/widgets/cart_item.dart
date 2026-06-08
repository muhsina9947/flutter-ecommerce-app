import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../services/cart_service.dart';

class CartItem extends StatelessWidget {

  final String productId;
  final String image;
  final String name;
  final String price;
  final String size;
  final int quantity;

  const CartItem({
    super.key,
    required this.productId,
    required this.image,
    required this.name,
    required this.price,
    required this.size,
    required this.quantity,
  });

  @override
  Widget build(BuildContext context) {

    return Container(

      margin:
          const EdgeInsets.only(
        bottom: 18,
      ),

      child: Row(

        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [

          Container(
            height: 130,
            width: 95,

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
                    fontSize: 24,
                  ),
                ),

                const SizedBox(
                  height: 4,
                ),

                Text(
                  "Size: $size",

                  style:
                      GoogleFonts.inter(
                    fontSize: 10,
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

                Row(
                  children: [

                    GestureDetector(

                      onTap: () {

                        CartService
                            .decreaseQuantity(
                          productId,
                          quantity,
                        );
                      },

                      child: Container(

                        padding:
                            const EdgeInsets
                                .all(6),

                        decoration:
                            BoxDecoration(
                          border:
                              Border.all(
                            color:
                                Colors.black12,
                          ),
                        ),

                        child: const Icon(
                          Icons.remove,
                          size: 16,
                        ),
                      ),
                    ),

                    Padding(
                      padding:
                          const EdgeInsets
                              .symmetric(
                        horizontal: 14,
                      ),

                      child: Text(
                        quantity.toString(),
                      ),
                    ),

                    GestureDetector(

                      onTap: () {

                        CartService
                            .increaseQuantity(
                          productId,
                          quantity,
                        );
                      },

                      child: Container(

                        padding:
                            const EdgeInsets
                                .all(6),

                        decoration:
                            BoxDecoration(
                          border:
                              Border.all(
                            color:
                                Colors.black12,
                          ),
                        ),

                        child: const Icon(
                          Icons.add,
                          size: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          GestureDetector(

            onTap: () {

              CartService.removeItem(
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