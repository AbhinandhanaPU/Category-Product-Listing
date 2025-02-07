import 'dart:convert';
import 'dart:developer';

import 'package:category_product_listing/model/product_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl =
      "https://alpha.bytesdelivery.com/api/v3/product/category-products/123";

  static Future<ProductModel?> fetchProducts(
      String selectedCategoryId, int currentPage) async {
    try {
      
      final url = Uri.parse("$baseUrl/$selectedCategoryId/$currentPage");
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return ProductModel.fromJson(data);
      } else {
        return null;
      }
    } catch (e) {
      log("Error fetching products: $e");
      return null;
    }
  }
}
