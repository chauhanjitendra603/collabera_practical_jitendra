
import 'dart:convert';

import 'package:collabera_test_jitendra/api_helper/urls.dart';

import '../models/product_list_model.dart';
import 'package:http/http.dart' as http;

class ApiService {

  static Future<List<Product>> fetchProducts() async {
    final response = await http.get(Uri.parse('${Url.BASE_URL}${Url.PRODUCTS}'));
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((product) => Product.fromJson(product)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }
}
