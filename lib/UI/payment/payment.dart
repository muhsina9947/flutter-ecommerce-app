import 'package:ecommerce_openfashion/UI/theme.dart';
import 'package:ecommerce_openfashion/widgets/Luxe%20widgets.dart';
import 'package:flutter/material.dart';
const Color bg = Color(0xffF5F1EB);
const Color dark = Color(0xff161616);
const Color light = Color(0xff8E8A84);
const Color gold = Color(0xffB79A63);

class PaymentMethodScreen extends StatefulWidget {
  final String? initialMethod;

  const PaymentMethodScreen({super.key, this.initialMethod});

  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  late String _selected;

  final _methods = [
    _PaymentMethod(
      id: 'cod',
      title: 'Cash on Delivery',
      subtitle: 'Pay when your order arrives',
      icon: Icons.payments_outlined,
      available: true,
    ),
    _PaymentMethod(
      id: 'upi',
      title: 'UPI',
      subtitle: 'GPay, PhonePe, Paytm & more',
      icon: Icons.account_balance_wallet_outlined,
      available: false,
    ),
    _PaymentMethod(
      id: 'card',
      title: 'Credit / Debit Card',
      subtitle: 'Visa, Mastercard, Amex',
      icon: Icons.credit_card_outlined,
      available: false,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _selected = widget.initialMethod ?? 'cod';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,
      appBar: const LuxeAppBar(title: 'PAYMENT'),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const LuxeSectionLabel('SELECT PAYMENT METHOD'),
            const SizedBox(height: 24),
            Expanded(
              child: ListView.builder(
                itemCount: _methods.length,
                itemBuilder: (context, i) {
                  final method = _methods[i];
                  final isSelected = _selected == method.id;

                  return GestureDetector(
                    onTap: method.available
                        ? () => setState(() => _selected = method.id)
                        : null,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      margin: const EdgeInsets.only(bottom: 14),
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: surface,
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(
                          color: isSelected
                              ? gold
                              : const Color(0xffD6D0C5),
                          width: isSelected ? 1.5 : 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? gold.withOpacity(0.12)
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(method.icon,
                                color: isSelected ? gold : light,
                                size: 22),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(method.title,
                                        style: AppTextStyles.body(14,
                                            weight: FontWeight.w600,
                                            color: method.available
                                                ? dark
                                                : light)),
                                    if (!method.available) ...[
                                      const SizedBox(width: 8),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 2),
                                        decoration: BoxDecoration(
                                          color: const Color(0xffE8E4DB),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: Text('COMING SOON',
                                            style: AppTextStyles.label(7,
                                                color: light, spacing: 1)),
                                      ),
                                    ],
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Text(method.subtitle,
                                    style:
                                        AppTextStyles.body(11, color: light)),
                              ],
                            ),
                          ),
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            width: 22,
                            height: 22,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: isSelected ? gold : Colors.transparent,
                              border: Border.all(
                                color: isSelected ? gold : light,
                                width: 1.5,
                              ),
                            ),
                            child: isSelected
                                ? const Icon(Icons.check,
                                    size: 12, color: Colors.white)
                                : null,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            LuxeButton(
              label: 'CONFIRM PAYMENT METHOD',
              onPressed: () => Navigator.pop(context, _selected),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class _PaymentMethod {
  final String id;
  final String title;
  final String subtitle;
  final IconData icon;
  final bool available;

  const _PaymentMethod({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.available,
  });
}