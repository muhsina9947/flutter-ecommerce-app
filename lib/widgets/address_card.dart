
import 'package:ecommerce_openfashion/UI/theme.dart';
import 'package:ecommerce_openfashion/models/Address%20model%20.dart';
import 'package:flutter/material.dart';
const Color bg = Color(0xffF5F1EB);
const Color dark = Color(0xff161616);
const Color light = Color(0xff8E8A84);
const Color gold = Color(0xffB79A63);
class AddressCard extends StatelessWidget {
  final AddressModel address;
  final bool isSelected;
  final VoidCallback? onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final VoidCallback? onSetDefault;

  const AddressCard({
    super.key,
    required this.address,
    this.isSelected = false,
    this.onTap,
    this.onEdit,
    this.onDelete,
    this.onSetDefault,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: surface,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: isSelected ? gold : const Color(0xffD6D0C5),
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    address.fullName,
                    style: AppTextStyles.display(22),
                  ),
                ),
                if (address.isDefault)
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: gold.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text('DEFAULT',
                        style: AppTextStyles.label(8, spacing: 1.5)),
                  ),
                if (isSelected && !address.isDefault)
                  const Icon(Icons.check_circle, color: gold, size: 18),
              ],
            ),
            const SizedBox(height: 8),
            Text(address.phone, style: AppTextStyles.body(12, color: light)),
            const SizedBox(height: 4),
            Text(
              address.fullAddressLine,
              style: AppTextStyles.body(12, color: light),
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                if (!address.isDefault && onSetDefault != null)
                  _actionBtn('Set Default', onSetDefault!),
                const Spacer(),
                if (onEdit != null)
                  _actionBtn('Edit', onEdit!, icon: Icons.edit_outlined),
                const SizedBox(width: 10),
                if (onDelete != null)
                  _actionBtn('Remove', onDelete!,
                      icon: Icons.delete_outline, color: error),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _actionBtn(String label, VoidCallback onTap,
      {IconData? icon, Color color = gold}) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          if (icon != null) Icon(icon, size: 14, color: color),
          if (icon != null) const SizedBox(width: 4),
          Text(label, style: AppTextStyles.label(9, color: color, spacing: 1)),
        ],
      ),
    );
  }
}