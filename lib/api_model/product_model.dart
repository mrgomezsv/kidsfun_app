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
    String baseUrl = 'https://';

    List<String> images = [
      _completeUrl(baseUrl, json['img1']),
      _completeUrl(baseUrl, json['img2']),
      _completeUrl(baseUrl, json['img3']),
      _completeUrl(baseUrl, json['img4']),
      _completeUrl(baseUrl, json['img5']),
    ];

    // Imprime las URLs para verificar
    print('Main Image URL: ${_completeUrl(baseUrl, json['img'])}');
    images.forEach((image) => print('Additional Image URL: $image'));

    return Product(
      id: json['id'],
      img: _completeUrl(baseUrl, json['img']),
      additionalImages: images,
      title: json['title'],
      description: json['description'],
      price: json['price'],
      category: json['category'],
    );
  }

  static String _completeUrl(String baseUrl, String url) {
    if (url.startsWith('http')) {
      return url;
    }
    return baseUrl + url;
  }
}
