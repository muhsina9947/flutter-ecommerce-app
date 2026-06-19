import 'package:cloud_firestore/cloud_firestore.dart';
import 'auth_service.dart';

class WishlistService {
  static final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  static Future<String> addToWishlist({
    required String image,
    required String name,
    required String price,
    required String label,
    required String productId,
  }) async {
    final uid = AuthService.userId;

    if (uid == null) {
      return "User not logged in";
    }

  
    final existing = await _firestore
        .collection("users")
        .doc(uid)
        .collection("wishlist")
        .where("productId", isEqualTo: productId)
        .get();

    if (existing.docs.isNotEmpty) {
      return "Already in Wishlist";
    }

   
    await _firestore
        .collection("users")
        .doc(uid)
        .collection("wishlist")
        .add({
      "productId": productId,
      "image": image,
      "name": name,
      "price": price,
      "label": label,
      "createdAt": Timestamp.now(),
    });

    return "Added to Wishlist";
  }

  static Future<bool> isInWishlist(String productId) async {
    final uid = AuthService.userId;

    if (uid == null) return false;

    final result = await _firestore
        .collection("users")
        .doc(uid)
        .collection("wishlist")
        .where("productId", isEqualTo: productId)
        .get();

    return result.docs.isNotEmpty;
  }

  static Stream<QuerySnapshot> wishlistStream() {
    final uid = AuthService.userId;

    if (uid == null) {
      return const Stream.empty();
    }

    return _firestore
        .collection("users")
        .doc(uid)
        .collection("wishlist")
        .orderBy("createdAt", descending: true)
        .snapshots();
  }

  static Future<void> removeWishlistItem(String docId) async {
    final uid = AuthService.userId;

    if (uid == null) return;

    await _firestore
        .collection("users")
        .doc(uid)
        .collection("wishlist")
        .doc(docId)
        .delete();
  }
}