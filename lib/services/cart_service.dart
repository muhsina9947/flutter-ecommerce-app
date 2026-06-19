import 'package:cloud_firestore/cloud_firestore.dart';
import 'auth_service.dart';

class CartService {
  static final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

 
  static Future<void> addToCart({
    required String productId,
    required String image,
    required String name,
    required String price,
    required String label,
    required String size,
  }) async {

    final uid = AuthService.userId;

    final cartRef = _firestore
        .collection("users")
        .doc(uid)
        .collection("cart")
        .doc(productId);

    final doc = await cartRef.get();

   
    if (doc.exists) {

      int currentQuantity =
          doc["quantity"];

      await cartRef.update({
        "quantity":
            currentQuantity + 1,
      });

    } else {

      
      await cartRef.set({
        "productId": productId,
        "image": image,
        "name": name,
        "price": price,
        "label": label,
        "size": size,
        "quantity": 1,
        "createdAt": Timestamp.now(),
      });
    }
  }

  
  static Stream<QuerySnapshot> cartStream() {

    final uid = AuthService.userId;

    return _firestore
        .collection("users")
        .doc(uid)
        .collection("cart")
        .orderBy(
          "createdAt",
          descending: true,
        )
        .snapshots();
  }

  
  static Future<void> removeItem(
    String productId,
  ) async {

    final uid = AuthService.userId;

    await _firestore
        .collection("users")
        .doc(uid)
        .collection("cart")
        .doc(productId)
        .delete();
  }

  
  static Future<void> increaseQuantity(
    String productId,
    int quantity,
  ) async {

    final uid = AuthService.userId;

    await _firestore
        .collection("users")
        .doc(uid)
        .collection("cart")
        .doc(productId)
        .update({
      "quantity": quantity + 1,
    });
  }

  static Future<void> decreaseQuantity(
    String productId,
    int quantity,
  ) async {

    final uid = AuthService.userId;

    if (quantity <= 1) {
      removeItem(productId);

    } else {

      await _firestore
          .collection("users")
          .doc(uid)
          .collection("cart")
          .doc(productId)
          .update({
        "quantity": quantity - 1,
      });
    }
  }
}