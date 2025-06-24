import 'package:flutter/material.dart';
import 'package:tokoperabot_uas_rioferdinand_22421011/models/product.dart';
import 'package:tokoperabot_uas_rioferdinand_22421011/core/network/dio_client.dart';

class ProductController {
  Future<bool> addProductWithUrl({required Product product}) async {
    try {
      final dio = await DioClient.instance;

      final response = await dio.post(
        '/items',
        data: {
          'title': product.title,
          'description': product.description,
          'price': product.price,
          'category': product.category,
          'image': product.image, // langsung kirim URL string
        },
      );

      debugPrint('Add Product with URL Response: ${response.data}');
      return true;
    } catch (e) {
      debugPrint('Error Add Product with URL: $e');
      return false;
    }
  }

  Future<bool> updateProduct(String id, Product product) async {
    try {
      final dio = await DioClient.instance;

      final response = await dio.put(
        '/items/$id',
        data: {
          'title': product.title,
          'description': product.description,
          'price': product.price,
          'category': product.category,
          'image': product.image,
        },
      );

      debugPrint('Update Product Response: ${response.data}');
      return true;
    } catch (e) {
      debugPrint('Error Update Product: $e');
      return false;
    }
  }

  Future<bool> deleteProduct(String id) async {
    try {
      final dio = await DioClient.instance;
      final response = await dio.delete('/items/$id');
      debugPrint('Delete Product Response: ${response.data}');
      return true;
    } catch (e) {
      debugPrint('Error Delete Product: $e');
      return false;
    }
  }

  Future<List<Product>> getProducts() async {
    try {
      final dio = await DioClient.instance;
      final response = await dio.get('/items');

      // Konversi data JSON ke List<Product>
      // final List data = response.data['data']; // pastikan struktur JSON benar
      // debugPrint('Response: $data');
      // return data.map((item) => Product.fromJson(item)).toList();

      final List<Product> data =
          (response.data['data'] as List)
              .map((item) => Product.fromJson(item))
              .toList();
      return data;
    } catch (e) {
      debugPrint('Error getProducts: $e');
      return [];
    }
  }
}
