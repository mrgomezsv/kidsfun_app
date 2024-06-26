import 'package:http/http.dart' as http;
import 'dart:convert';
import 'comment_model.dart';

class CommentApi {
  static const String apiUrl = 'https://www.smap.kidsfunyfiestasinfantiles.com/api/commentary/';

  static Future<http.Response> sendComment(Comment comment) async {
    // Print statements para depuración
    // print('Request URL: $apiUrl');
    // print('Request Body: ${jsonEncode(comment.toJson())}');

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(comment.toJson()),
    );

    // print('Response Status Code: ${response.statusCode}');
    // print('Response Body: ${response.body}');

    return response;
  }
}
