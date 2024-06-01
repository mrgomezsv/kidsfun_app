import 'dart:convert';
import 'package:http/http.dart' as http;
import 'product_model.dart';


class ProductApi {
  static Future<List<Product>> fetchProducts() async {
    final response = await http.get(Uri.parse('https://smap.webcraftedsolutions.net/api/products/'));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((item) => Product.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }
}
