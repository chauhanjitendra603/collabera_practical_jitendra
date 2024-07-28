class Product {
  final int id;
  final String title;
  final String description;
  final String image;
  final double price;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.price,
  });

  // Convert a Product instance into a Map.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'image': image,
      'price': price,
    };
  }

  // Convert a Map into a Product instance.
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      image: json['image'],
      price: json['price'].toDouble(),
    );
  }
}
