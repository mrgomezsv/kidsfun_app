class Favorite {
  final String? userId;
  final String productId;
  final bool isFavorite;

  Favorite({
    required this.userId,
    required this.productId,
    required this.isFavorite,
  });

  Map<String, dynamic> toJson() {
    return {
      'user': userId ?? '',
      'product': productId,
      'is_favorite': isFavorite,
    };
  }
}
