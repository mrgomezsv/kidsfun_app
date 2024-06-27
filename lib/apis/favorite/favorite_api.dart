import 'package:http/http.dart' as http;
import 'dart:convert';
import 'favorite_model.dart';

class FavoriteApi {
  static const String apiUrl = 'https://www.smap.kidsfunyfiestasinfantiles.com/api/likes/';

  static Future<http.Response> sendFavorite(Favorite favorite) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(favorite.toJson()),
    );

    // Print statements for debugging
    print('Request URL: $apiUrl');
    print('Request Body: ${jsonEncode(favorite.toJson())}');
    print('Response Status Code: ${response.statusCode}');
    print('Response Body: ${response.body}');

    return response;
  }
}
