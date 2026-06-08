class CartModel {

  final String productId;
  final String image;
  final String name;
  final String price;
  final String label;
  final String size;
  final int quantity;

  CartModel({
    required this.productId,
    required this.image,
    required this.name,
    required this.price,
    required this.label,
    required this.size,
    required this.quantity,
  });

  
  Map<String, dynamic> toMap() {
    return {
      "productId": productId,
      "image": image,
      "name": name,
      "price": price,
      "label": label,
      "size": size,
      "quantity": quantity,
    };
  }

  
  factory CartModel.fromMap(
    Map<String, dynamic> map,
  ) {
    return CartModel(
      productId:
          map["productId"] ?? "",

      image:
          map["image"] ?? "",

      name:
          map["name"] ?? "",

      price:
          map["price"] ?? "",

      label:
          map["label"] ?? "",

      size:
          map["size"] ?? "",

      quantity:
          map["quantity"] ?? 1,
    );
  }
}