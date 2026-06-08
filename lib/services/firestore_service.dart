import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {

  static final FirebaseFirestore db =
      FirebaseFirestore.instance;

 
  static CollectionReference users =
      db.collection("users");

 
  static CollectionReference products =
      db.collection("products");

  
  static DocumentReference userDoc(
    String uid,
  ) {
    return users.doc(uid);
  }

 
  static CollectionReference cart(
    String uid,
  ) {
    return users
        .doc(uid)
        .collection("cart");
  }

 
  static CollectionReference wishlist(
    String uid,
  ) {
    return users
        .doc(uid)
        .collection("wishlist");
  }

  
  static CollectionReference orders(
    String uid,
  ) {
    return users
        .doc(uid)
        .collection("orders");
  }
}