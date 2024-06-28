class Product {
  final int id;
  final String img;
  final List<String> additionalImages;
  final String title;
  final String description;
  final String? price; // Permitir que el campo price sea nulo
  final String category;
  final String categoryName;

  Product({
    required this.id,
    required this.img,
    required this.additionalImages,
    required this.title,
    required this.description,
    this.price, // Hacer que el campo price sea opcional
    required this.category,
    required this.categoryName,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    String baseUrl = 'https://';

    List<String> images = [
      _completeUrl(baseUrl, json['img1']),
      _completeUrl(baseUrl, json['img2']),
      _completeUrl(baseUrl, json['img3']),
      _completeUrl(baseUrl, json['img4']),
      _completeUrl(baseUrl, json['img5']),
    ];

    return Product(
      id: json['id'],
      img: _completeUrl(baseUrl, json['img']),
      additionalImages: images,
      title: json['title'],
      description: json['description'],
      price: json['price'], // Permitir que el campo price sea opcional
      category: json['category'],
      categoryName: getCategoryName(json['category']),
    );
  }

  static String _completeUrl(String baseUrl, String url) {
    if (url.startsWith('http')) {
      return url;
    }
    return baseUrl + url;
  }

  static String getCategoryName(String categoryKey) {
    switch (categoryKey) {
      case 'option1':
        return 'Bounce House';
      case 'option2':
        return 'Mechanical Games';
      case 'option3':
        return 'Furniture';
      default:
        return 'Unknown Category';
    }
  }
}
