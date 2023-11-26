import 'package:get/get.dart';

import '../product_model.dart';

class ProductProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) return Product.fromJson(map);
      if (map is List)
        return map.map((item) => Product.fromJson(item)).toList();
    };
    httpClient.baseUrl = 'YOUR-API-URL';
  }

  Future<Product?> getProduct(int id) async {
    final response = await get('product/$id');
    return response.body;
  }

  Future<Response<Product>> postProduct(Product product) async =>
      await post('product', product);
  Future<Response> deleteProduct(int id) async => await delete('product/$id');
}
