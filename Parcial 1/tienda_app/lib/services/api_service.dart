import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product.dart';

class ApiService {
  final String baseUrl = "https://fakestoreapi.com";

  Future<List<Product>> fetchProducts() async {
    final res = await http.get(Uri.parse('$baseUrl/products'));

    if (res.statusCode == 200) {
      List data = json.decode(res.body);
      return data.map((e) => Product.fromJson(e)).toList();
    } else {
      throw Exception("Error al cargar productos");
    }
  }

  Future<Product> createProduct(Product product) async {
    final res = await http.post(
      Uri.parse('$baseUrl/products'),
      headers: {"Content-Type": "application/json"},
      body: json.encode(product.toJson()),
    );

    if (res.statusCode == 200 || res.statusCode == 201) {
      return Product.fromJson(json.decode(res.body));
    } else {
      throw Exception("Error al crear producto");
    }
  }

  Future<Product> updateProduct(int id, Product product) async {
    final res = await http.put(
      Uri.parse('$baseUrl/products/$id'),
      headers: {"Content-Type": "application/json"},
      body: json.encode(product.toJson()),
    );

    if (res.statusCode == 200) {
      return Product.fromJson(json.decode(res.body));
    } else {
      throw Exception("Error al actualizar");
    }
  }

  Future<void> deleteProduct(int id) async {
    final res = await http.delete(Uri.parse('$baseUrl/products/$id'));

    if (res.statusCode != 200) {
      throw Exception("Error al eliminar");
    }
  }
}