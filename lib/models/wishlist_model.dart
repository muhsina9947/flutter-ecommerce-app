class WishlistModel {

  final String productId;
  final String image;
  final String name;
  final String price;
  final String label;

  WishlistModel({
    required this.productId,
    required this.image,
    required this.name,
    required this.price,
    required this.label,
  });

  
  Map<String, dynamic> toMap() {
    return {
      "productId": productId,
      "image": image,
      "name": name,
      "price": price,
      "label": label,
    };
  }

  factory WishlistModel.fromMap(
    Map<String, dynamic> map,
  ) {
    return WishlistModel(
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
    );
  }
}