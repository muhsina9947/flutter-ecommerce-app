import 'package:ecommerce_openfashion/UI/theme.dart';
import 'package:ecommerce_openfashion/widgets/Luxe%20widgets.dart';
import 'package:flutter/material.dart';

import 'my_orders_screen.dart';

const Color bg = Color(0xffF5F1EB);
const Color dark = Color(0xff161616);
const Color light = Color(0xff8E8A84);
const Color gold = Color(0xffB79A63);
class OrderSuccessScreen extends StatefulWidget {
  final String orderId;

  const OrderSuccessScreen({super.key, required this.orderId});

  @override
  State<OrderSuccessScreen> createState() => _OrderSuccessScreenState();
}

class _OrderSuccessScreenState extends State<OrderSuccessScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnim;
  late Animation<double> _fadeAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _scaleAnim = CurvedAnimation(
        parent: _controller, curve: const Interval(0, 0.6, curve: Curves.elasticOut));
    _fadeAnim = CurvedAnimation(
        parent: _controller, curve: const Interval(0.4, 1, curve: Curves.easeIn));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String get _shortOrderId =>
      widget.orderId.substring(0, 8).toUpperCase();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Animated check
              ScaleTransition(
                scale: _scaleAnim,
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: gold.withOpacity(0.1),
                    border: Border.all(color: gold, width: 1.5),
                  ),
                  child: const Icon(
                    Icons.check_rounded,
                    color: gold,
                    size: 56,
                  ),
                ),
              ),

              const SizedBox(height: 40),

              FadeTransition(
                opacity: _fadeAnim,
                child: Column(
                  children: [
                    Text(
                      'Order Confirmed',
                      style: AppTextStyles.display(42),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Your Maison Luxe selection is\nbeing carefully prepared.',
                      style: AppTextStyles.body(14, color: light),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 32),

                    // Order ID chip
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 14),
                      decoration: BoxDecoration(
                        color: surface,
                        borderRadius: BorderRadius.circular(40),
                        border:
                            Border.all(color: const Color(0xffD6D0C5)),
                      ),
                      child: Column(
                        children: [
                          Text('ORDER ID',
                              style: AppTextStyles.label(9,
                                  color: light, spacing: 2)),
                          const SizedBox(height: 6),
                          Text(
                            '#$_shortOrderId',
                            style: AppTextStyles.display(26),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Estimated delivery
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 12),
                      decoration: BoxDecoration(
                        color: gold.withOpacity(0.08),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.local_shipping_outlined,
                              size: 18, color: gold),
                          const SizedBox(width: 10),
                          Text('Estimated delivery: 3–5 business days',
                              style: AppTextStyles.body(12, color: dark)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 56),

              FadeTransition(
                opacity: _fadeAnim,
                child: Column(
                  children: [
                    LuxeButton(
                      label: 'VIEW MY ORDERS',
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const MyOrdersScreen()),
                          (route) => route.isFirst,
                        );
                      },
                    ),
                    const SizedBox(height: 14),
                    LuxeButton(
                      label: 'CONTINUE SHOPPING',
                      outlined: true,
                      onPressed: () {
                        Navigator.of(context)
                            .popUntil((route) => route.isFirst);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}