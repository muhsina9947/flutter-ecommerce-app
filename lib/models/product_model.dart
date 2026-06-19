class ProductModel {
  final String productId;
  final String image;
  final String name;
  final String price;
  final String category;
  final String description;

  ProductModel({
    required this.productId,
    required this.image,
    required this.name,
    required this.price,
    required this.category,
    required this.description,
  });

 
  Map<String, dynamic> toMap() {
    return {
      "productId": productId,
      "image": image,
      "name": name,
      "price": price,
      "category": category,
      "description": description,
    };
  }

  
  factory ProductModel.fromMap(
    Map<String, dynamic> map,
  ) {
    return ProductModel(
      productId: map["productId"] ?? "",
      image: map["image"] ?? "",
      name: map["name"] ?? "",
      price: map["price"] ?? "",
      category: map["category"] ?? "",
      description:
          map["description"] ?? "",
    );
  }
}