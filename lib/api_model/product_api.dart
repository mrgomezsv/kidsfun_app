import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart'; // Importa la librería de Firebase Auth
import 'product_model.dart';

class ProductApi {
  static FirebaseAuth _auth = FirebaseAuth.instance;

  static Future<List<Product>> fetchProducts() async {
    // Verificar si el usuario está autenticado
    User? user = _auth.currentUser;
    if (user == null) {
      throw Exception('User not authenticated');
    }

    // Usuario autenticado, proceder con la llamada a la API
    final response = await http.get(Uri.parse('https://www.smap.kidsfunyfiestasinfantiles.com/api/products/'));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((item) => Product.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }
}
