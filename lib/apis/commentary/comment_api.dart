import 'dart:convert';
import 'package:http/http.dart' as http;
import 'comment_model.dart';

class CommentApi {
  static const String apiUrl = 'https://www.smap.kidsfunyfiestasinfantiles.com/api/commentary/';

  static Future<http.Response> sendComment(Comment comment) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(comment.toJson()),
    );
    return response;
  }

  static Future<List<Comment>> fetchComments(int productId) async {
    final response = await http.get(
      Uri.parse('$apiUrl/comments_for_product?product_id=$productId'),
    );

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Comment.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load comments');
    }
  }
}
