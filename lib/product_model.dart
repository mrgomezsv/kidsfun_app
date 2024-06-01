class Product {
  final int id;
  final String img;
  final String title;
  final String description;
  final String price;
  final String category;

  Product({
    required this.id,
    required this.img,
    required this.title,
    required this.description,
    required this.price,
    required this.category,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      img: json['img'],
      title: json['title'],
      description: json['description'],
      price: json['price'],
      category: json['category'],
    );
  }
}
