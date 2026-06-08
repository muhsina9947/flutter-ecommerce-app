import 'package:cloud_firestore/cloud_firestore.dart';

class OrderItem {
  final String name;
  final String label;
  final String price;
  final String image;

  OrderItem({
    required this.name,
    required this.label,
    required this.price,
    required this.image,
  });

  factory OrderItem.fromMap(Map<String, dynamic> map) => OrderItem(
        name: map['name'] ?? '',
        label: map['label'] ?? '',
        price: map['price'] ?? '',
        image: map['image'] ?? '',
      );

  Map<String, dynamic> toMap() => {
        'name': name,
        'label': label,
        'price': price,
        'image': image,
      };
}

class OrderModel {
  final String id;
  final List<OrderItem> items;
  final double subtotal;
  final double shipping;
  final double total;
  final Map<String, dynamic> address;
  final String paymentMethod;
  final String status;
  final DateTime createdAt;

  OrderModel({
    required this.id,
    required this.items,
    required this.subtotal,
    required this.shipping,
    required this.total,
    required this.address,
    required this.paymentMethod,
    required this.status,
    required this.createdAt,
  });

  factory OrderModel.fromDoc(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return OrderModel(
      id: doc.id,
      items: (data['items'] as List<dynamic>? ?? [])
          .map((e) => OrderItem.fromMap(e as Map<String, dynamic>))
          .toList(),
      subtotal: (data['subtotal'] ?? 0).toDouble(),
      shipping: (data['shipping'] ?? 0).toDouble(),
      total: (data['total'] ?? 0).toDouble(),
      address: Map<String, dynamic>.from(data['address'] ?? {}),
      paymentMethod: data['paymentMethod'] ?? '',
      status: data['status'] ?? 'Pending',
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() => {
        'items': items.map((e) => e.toMap()).toList(),
        'subtotal': subtotal,
        'shipping': shipping,
        'total': total,
        'address': address,
        'paymentMethod': paymentMethod,
        'status': status,
        'createdAt': Timestamp.fromDate(createdAt),
      };

  String get shortId => id.substring(0, 8).toUpperCase();

  String get formattedDate {
    final months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return '${createdAt.day} ${months[createdAt.month - 1]} ${createdAt.year}';
  }
}