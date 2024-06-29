class Comment {
  final String comment;
  final String? userId;
  final int productId;
  final String? userDisplayName; // Nuevo campo para el nombre de usuario

  Comment({
    required this.comment,
    required this.userId,
    required this.productId,
    this.userDisplayName,
  });

  Map<String, dynamic> toJson() {
    return {
      'comment': comment,
      'user_id': userId,
      'product_id': productId,
    };
  }

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      comment: json['comment'],
      userId: json['user_id'],
      productId: json['product_id'],
      userDisplayName: json['user_display_name'], // Asignar el nombre de usuario desde JSON
    );
  }
}
