import 'package:ecommerce_openfashion/UI/theme.dart';
import 'package:ecommerce_openfashion/models/Order%20model.dart';
import 'package:ecommerce_openfashion/widgets/Luxe%20widgets.dart';
import 'package:flutter/material.dart';
const Color bg = Color(0xffF5F1EB);
const Color dark = Color(0xff161616);
const Color light = Color(0xff8E8A84);
const Color gold = Color(0xffB79A63);

class OrderDetailsScreen extends StatelessWidget {
  final OrderModel order;

  const OrderDetailsScreen({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final addr = order.address;

    return Scaffold(
      backgroundColor: bg,
      appBar: LuxeAppBar(title: 'ORDER #${order.shortId}'),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // Status timeline
          const LuxeSectionLabel('ORDER STATUS'),
          const SizedBox(height: 20),
          _statusTimeline(order.status),

          const SizedBox(height: 28),

          // Items
          _card(
            label: 'ITEMS ORDERED',
            child: Column(
              children: order.items
                  .map((item) => _itemRow(item))
                  .toList(),
            ),
          ),

          const SizedBox(height: 14),

          // Delivery address
          _card(
            label: 'DELIVERY ADDRESS',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(addr['fullName'] ?? '',
                    style: AppTextStyles.display(22)),
                const SizedBox(height: 6),
                Text(addr['phone'] ?? '',
                    style: AppTextStyles.body(12, color: light)),
                const SizedBox(height: 4),
                Text(
                  '${addr['address']}, ${addr['city']}, ${addr['state']} - ${addr['pincode']}',
                  style: AppTextStyles.body(12, color: light),
                ),
              ],
            ),
          ),

          const SizedBox(height: 14),

          // Payment
          _card(
            label: 'PAYMENT METHOD',
            child: Row(
              children: [
                const Icon(Icons.payments_outlined, color: gold, size: 20),
                const SizedBox(width: 10),
                Text(_paymentLabel(order.paymentMethod),
                    style: AppTextStyles.body(13, weight: FontWeight.w500)),
              ],
            ),
          ),

          const SizedBox(height: 14),

          // Price summary
          _card(
            label: 'PRICE SUMMARY',
            child: Column(
              children: [
                _priceRow('Subtotal', '\$${order.subtotal.toStringAsFixed(0)}'),
                const SizedBox(height: 8),
                _priceRow('Shipping', '\$${order.shipping.toStringAsFixed(0)}'),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Divider(height: 1, color: Color(0xffD6D0C5)),
                ),
                _priceRow('Total', '\$${order.total.toStringAsFixed(0)}',
                    isTotal: true),
              ],
            ),
          ),

          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _statusTimeline(String currentStatus) {
    final steps = [
      _StatusStep('Order Placed', Icons.receipt_outlined),
      _StatusStep('Processing', Icons.inventory_2_outlined),
      _StatusStep('Shipped', Icons.local_shipping_outlined),
      _StatusStep('Delivered', Icons.check_circle_outlined),
    ];

    final activeIndex = () {
      switch (currentStatus.toLowerCase()) {
        case 'processing':
          return 1;
        case 'shipped':
          return 2;
        case 'delivered':
          return 3;
        default:
          return 0;
      }
    }();

    return Row(
      children: steps.asMap().entries.map((entry) {
        final i = entry.key;
        final step = entry.value;
        final isActive = i <= activeIndex;
        final isLast = i == steps.length - 1;

        return Expanded(
          child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      width: 38,
                      height: 38,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isActive ? gold : surface,
                        border: Border.all(
                          color: isActive ? gold : const Color(0xffD6D0C5),
                          width: 1.5,
                        ),
                      ),
                      child: Icon(step.icon,
                          size: 16,
                          color: isActive ? Colors.white : light),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      step.label,
                      style: AppTextStyles.body(9,
                          color: isActive ? dark : light,
                          weight: isActive
                              ? FontWeight.w600
                              : FontWeight.normal),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    height: 1.5,
                    margin: const EdgeInsets.only(bottom: 26),
                    color: i < activeIndex
                        ? gold
                        : const Color(0xffD6D0C5),
                  ),
                ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _itemRow(OrderItem item) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              item.image,
              width: 64,
              height: 80,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                width: 64,
                height: 80,
                decoration: BoxDecoration(
                  color: const Color(0xffE8E4DB),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.image_outlined,
                    color: light, size: 24),
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.label,
                    style: AppTextStyles.label(8, spacing: 1.5)),
                const SizedBox(height: 4),
                Text(item.name, style: AppTextStyles.display(20)),
                const SizedBox(height: 6),
                Text(item.price,
                    style: AppTextStyles.body(13,
                        weight: FontWeight.bold)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _card({required String label, required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xffD6D0C5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LuxeSectionLabel(label),
          const SizedBox(height: 14),
          child,
        ],
      ),
    );
  }

  Widget _priceRow(String label, String value, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style: AppTextStyles.body(isTotal ? 14 : 12,
                weight:
                    isTotal ? FontWeight.bold : FontWeight.normal)),
        Text(value,
            style: AppTextStyles.body(isTotal ? 15 : 13,
                weight: FontWeight.bold,
                color: isTotal ? gold : dark)),
      ],
    );
  }

  String _paymentLabel(String method) {
    switch (method) {
      case 'upi':
        return 'UPI';
      case 'card':
        return 'Credit / Debit Card';
      default:
        return 'Cash on Delivery';
    }
  }
}

class _StatusStep {
  final String label;
  final IconData icon;
  const _StatusStep(this.label, this.icon);
}