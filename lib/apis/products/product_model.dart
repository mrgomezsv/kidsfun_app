class Product {
  final int id;
  final String img;
  final List<String> additionalImages;
  final String title;
  final String description;
  final String price;
  final String category; // Mantienes la categoría como clave
  final String categoryName; // Agregas una propiedad para el nombre de la categoría

  Product({
    required this.id,
    required this.img,
    required this.additionalImages,
    required this.title,
    required this.description,
    required this.price,
    required this.category,
    required this.categoryName, // Añades la propiedad categoryName
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
      price: json['price'],
      category: json['category'], // Aquí obtienes la clave de la categoría
      categoryName: getCategoryName(json['category']), // Obtienes el nombre de la categoría
    );
  }

  static String _completeUrl(String baseUrl, String url) {
    if (url.startsWith('http')) {
      return url;
    }
    return baseUrl + url;
  }

  static String getCategoryName(String categoryKey) {
    // Implementa la lógica para obtener el nombre de la categoría basado en la clave
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
