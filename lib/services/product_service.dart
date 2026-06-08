import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/product_model.dart';

class ProductService {

  static final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

 
  static Stream<List<ProductModel>>
      getProducts() {

    return _firestore
        .collection("products")
        .snapshots()
        .map((snapshot) {

      return snapshot.docs.map((doc) {

        return ProductModel.fromMap(
          doc.data(),
        );

      }).toList();
    });
  }

  
  static Stream<List<ProductModel>>
      getProductsByCategory(
    String category,
  ) {

    return _firestore
        .collection("products")
        .where(
          "category",
          isEqualTo: category,
        )
        .snapshots()
        .map((snapshot) {

      return snapshot.docs.map((doc) {

        return ProductModel.fromMap(
          doc.data(),
        );

      }).toList();
    });
  }

  
  static Future<ProductModel?>
      getSingleProduct(
    String productId,
  ) async {

    final doc = await _firestore
        .collection("products")
        .doc(productId)
        .get();

    if (doc.exists) {

      return ProductModel.fromMap(
        doc.data()!,
      );
    }

    return null;
  }

 
  static Stream<List<ProductModel>>
      searchProducts(
    String search,
  ) {

    return _firestore
        .collection("products")
        .snapshots()
        .map((snapshot) {

      return snapshot.docs
          .map((doc) {
            return ProductModel
                .fromMap(doc.data());
          })
          .where((product) {

            return product.name
                .toLowerCase()
                .contains(
                  search.toLowerCase(),
                );

          }).toList();
    });
  }
}