import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_openfashion/models/Address%20model%20.dart';
import 'package:ecommerce_openfashion/models/Order%20model.dart';

import 'auth_service.dart';

class OrderService {
  static CollectionReference _ordersRef() => FirebaseFirestore.instance
      .collection('users')
      .doc(AuthService.userId)
      .collection('orders');

  static CollectionReference _cartRef() => FirebaseFirestore.instance
      .collection('users')
      .doc(AuthService.userId)
      .collection('cart');

 
  static Future<String> placeOrder({
    required AddressModel address,
    required String paymentMethod,
  }) async {
   
    final cartSnap = await _cartRef().get();
    final cartDocs = cartSnap.docs;

    if (cartDocs.isEmpty) throw Exception('Cart is empty');

    
    final items = cartDocs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      return OrderItem(
        name: data['name'] ?? '',
        label: data['label'] ?? '',
        price: data['price'] ?? '',
        image: data['image'] ?? '',
      );
    }).toList();

    
    double subtotal = 0;
    for (final item in items) {
      final cleaned =
          item.price.replaceAll('\$', '').replaceAll(',', '').trim();
      subtotal += double.tryParse(cleaned) ?? 0;
    }
    const shipping = 120.0;
    final total = subtotal + shipping;

   
    final orderData = OrderModel(
      id: '',
      items: items,
      subtotal: subtotal,
      shipping: shipping,
      total: total,
      address: address.toMap(),
      paymentMethod: paymentMethod,
      status: 'Pending',
      createdAt: DateTime.now(),
    );

   
    final docRef = await _ordersRef().add(orderData.toMap());

    
    final batch = FirebaseFirestore.instance.batch();
    for (final doc in cartDocs) {
      batch.delete(doc.reference);
    }
    await batch.commit();

    return docRef.id;
  }

  static Stream<List<OrderModel>> ordersStream() {
    return _ordersRef()
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snap) =>
            snap.docs.map((doc) => OrderModel.fromDoc(doc)).toList());
  }

  static Future<OrderModel?> getOrder(String orderId) async {
    final doc = await _ordersRef().doc(orderId).get();
    if (!doc.exists) return null;
    return OrderModel.fromDoc(doc);
  }
}