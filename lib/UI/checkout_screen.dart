import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_openfashion/UI/Payment%20method%20screen%20.dart';
import 'package:ecommerce_openfashion/UI/address/address_screen.dart';
import 'package:ecommerce_openfashion/UI/orders/order_success_screen.dart';
import 'package:ecommerce_openfashion/UI/theme.dart';
import 'package:ecommerce_openfashion/models/Address%20model%20.dart';
import 'package:ecommerce_openfashion/services/Address%20service.dart';
import 'package:ecommerce_openfashion/services/Order%20service.dart';
import 'package:ecommerce_openfashion/services/auth_service.dart';
import 'package:ecommerce_openfashion/widgets/Luxe%20widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color bg = Color(0xffF5F1EB);
const Color dark = Color(0xff161616);
const Color light = Color(0xff8E8A84);
const Color gold = Color(0xffB79A63);

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  AddressModel? _selectedAddress;
  String _paymentMethod = 'cod';
  bool _placingOrder = false;

  @override
  void initState() {
    super.initState();
    _loadDefaultAddress();
  }

  Future<void> _loadDefaultAddress() async {
    final addr = await AddressService.getDefaultAddress();
    if (mounted) setState(() => _selectedAddress = addr);
  }

  Stream<QuerySnapshot> _cartStream() {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(AuthService.userId)
        .collection('cart')
        .snapshots();
  }

  double _calculateTotal(List<QueryDocumentSnapshot> docs) {
    double total = 0;
    for (var doc in docs) {
      final price = doc['price']
          .toString()
          .replaceAll('\$', '')
          .replaceAll(',', '');
      total += double.tryParse(price) ?? 0;
    }
    return total;
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

  Future<void> _placeOrder() async {
    if (_selectedAddress == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please select a delivery address',
              style: AppTextStyles.body(12, color: Colors.white)),
          backgroundColor: error,
          behavior: SnackBarBehavior.floating,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      );
      return;
    }

    setState(() => _placingOrder = true);

    try {
      final orderId = await OrderService.placeOrder(
        address: _selectedAddress!,
        paymentMethod: _paymentMethod,
      );

      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => OrderSuccessScreen(orderId: orderId),
          ),
        );
      }
    } catch (e) {
      setState(() => _placingOrder = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to place order: ${e.toString()}',
              style: AppTextStyles.body(12, color: Colors.white)),
          backgroundColor: error,
          behavior: SnackBarBehavior.floating,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,
      appBar: const LuxeAppBar(title: 'CHECKOUT'),
      body: StreamBuilder<QuerySnapshot>(
        stream: _cartStream(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
                child: CircularProgressIndicator(color: gold));
          }

          final cartItems = snapshot.data!.docs;
          final subtotal = _calculateTotal(cartItems);
          const shipping = 120.0;
          final total = subtotal + shipping;

          return ListView(
            padding: const EdgeInsets.all(20),
            children: [
              // Order Summary
              const LuxeSectionLabel('ORDER SUMMARY'),
              const SizedBox(height: 20),
              ...cartItems.map((item) => _cartItem(item)),

              const Divider(height: 32),

              // Delivery Address
              _sectionCard(
                label: 'DELIVERY ADDRESS',
                child: _selectedAddress == null
                    ? GestureDetector(
                        onTap: _pickAddress,
                        child: Row(
                          children: [
                            const Icon(Icons.add_location_outlined,
                                color: gold, size: 20),
                            const SizedBox(width: 10),
                            Text('Add delivery address',
                                style: AppTextStyles.label(12, spacing: 0)),
                          ],
                        ),
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(children: [
                            Expanded(
                              child: Text(_selectedAddress!.fullName,
                                  style: AppTextStyles.display(22)),
                            ),
                            GestureDetector(
                              onTap: _pickAddress,
                              child: Text('Change',
                                  style:
                                      AppTextStyles.label(10, spacing: 0.5)),
                            ),
                          ]),
                          const SizedBox(height: 6),
                          Text(_selectedAddress!.phone,
                              style: AppTextStyles.body(12, color: light)),
                          const SizedBox(height: 4),
                          Text(_selectedAddress!.fullAddressLine,
                              style: AppTextStyles.body(12, color: light)),
                        ],
                      ),
              ),

              const SizedBox(height: 14),

              // Payment Method
              _sectionCard(
                label: 'PAYMENT METHOD',
                child: GestureDetector(
                  onTap: _pickPayment,
                  child: Row(
                    children: [
                      const Icon(Icons.credit_card_outlined,
                          color: gold, size: 20),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(_paymentLabel(_paymentMethod),
                            style: AppTextStyles.body(13,
                                weight: FontWeight.w500)),
                      ),
                      Text('Change',
                          style: AppTextStyles.label(10, spacing: 0.5)),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Price breakdown
              _priceRow('Subtotal',
                  '\$${subtotal.toStringAsFixed(0)}'),
              const SizedBox(height: 10),
              _priceRow('Shipping', '\$120'),
              const SizedBox(height: 16),
              _priceRow(
                  'TOTAL', '\$${total.toStringAsFixed(0)}',
                  isTotal: true),

              const SizedBox(height: 30),

              LuxeButton(
                label: 'PLACE ORDER',
                onPressed: _placeOrder,
                isLoading: _placingOrder,
              ),
              const SizedBox(height: 16),
            ],
          );
        },
      ),
    );
  }

  Widget _cartItem(QueryDocumentSnapshot item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: Image.asset(
              item['image'],
              height: 90,
              width: 72,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                height: 90,
                width: 72,
                decoration: BoxDecoration(
                  color: surface,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(Icons.image_outlined, color: light),
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item['label'],
                    style: AppTextStyles.label(9, spacing: 1.5)),
                const SizedBox(height: 6),
                Text(item['name'], style: AppTextStyles.display(22)),
                const SizedBox(height: 8),
                Text(item['price'],
                    style: AppTextStyles.body(13,
                        weight: FontWeight.bold)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionCard({required String label, required Widget child}) {
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

  Widget _priceRow(String title, String value, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,
            style: AppTextStyles.body(isTotal ? 14 : 11,
                weight:
                    isTotal ? FontWeight.bold : FontWeight.w500)),
        Text(value,
            style: GoogleFonts.montserrat(
              fontSize: isTotal ? 16 : 12,
              fontWeight: FontWeight.bold,
              color: isTotal ? gold : dark,
            )),
      ],
    );
  }

  Future<void> _pickAddress() async {
    final result = await Navigator.push<AddressModel>(
      context,
      MaterialPageRoute(
        builder: (_) => AddressScreen(
          selectMode: true,
          selectedAddressId: _selectedAddress?.id,
        ),
      ),
    );
    if (result != null) setState(() => _selectedAddress = result);
  }

  Future<void> _pickPayment() async {
    final result = await Navigator.push<String>(
      context,
      MaterialPageRoute(
        builder: (_) =>
            PaymentMethodScreen(initialMethod: _paymentMethod),
      ),
    );
    if (result != null) setState(() => _paymentMethod = result);
  }
}