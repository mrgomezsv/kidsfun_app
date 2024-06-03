class Product {
  final int id;
  final String img;
  final List<String> additionalImages; // Lista para almacenar las imágenes adicionales
  final String title;
  final String description;
  final String price;
  final String category;

  Product({
    required this.id,
    required this.img,
    required this.additionalImages,
    required this.title,
    required this.description,
    required this.price,
    required this.category,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    List<String> images = [
      json['img1'],
      json['img2'],
      json['img3'],
      json['img4'],
      json['img5'],
    ];

    return Product(
      id: json['id'],
      img: json['img'],
      additionalImages: images,
      title: json['title'],
      description: json['description'],
      price: json['price'],
      category: json['category'],
    );
  }
}
