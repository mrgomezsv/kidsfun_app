class Comment {
  final String comment;
  final String? userId;
  final int productId;

  Comment({
    required this.comment,
    required this.userId,
    required this.productId,
  });

  Map<String, dynamic> toJson() {
    return {
      'comment': comment,
      'user_id': userId,
      'product_id': productId,
    };
  }
}
