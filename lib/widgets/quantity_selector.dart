import 'package:flutter/material.dart';

class QuantitySelector
    extends StatelessWidget {

  final int quantity;

  final VoidCallback onAdd;
  final VoidCallback onRemove;

  const QuantitySelector({
    super.key,
    required this.quantity,
    required this.onAdd,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {

    return Row(
      children: [

        GestureDetector(

          onTap: onRemove,

          child: Container(

            padding:
                const EdgeInsets.all(
              6,
            ),

            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black12,
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
              const EdgeInsets.symmetric(
            horizontal: 14,
          ),

          child: Text(
            quantity.toString(),
          ),
        ),

        GestureDetector(

          onTap: onAdd,

          child: Container(

            padding:
                const EdgeInsets.all(
              6,
            ),

            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black12,
              ),
            ),

            child: const Icon(
              Icons.add,
              size: 16,
            ),
          ),
        ),
      ],
    );
  }
}