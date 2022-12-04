import 'dart:convert';

import 'package:ecomshop/config.dart';
import 'package:ecomshop/models/category.dart';
import 'package:ecomshop/models/product.dart';
import 'package:ecomshop/models/product_filter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

final apiService = Provider((ref) => APIService());

class APIService {
  static var client = http.Client();
  // category
  Future<List<Category>?> getCategories(page, pageSize) async {
    Map<String, String> requestHeaders = {"Content-Type": "application/json"};
    Map<String, String> queryString = {
      'page': page.toString(),
      'pazeSize': pageSize.toString()
    };
    var url = Uri.http(Config.apiUrl, Config.categoryAPI, queryString);
    var res = await client.get(url, headers: requestHeaders);
    if (res.statusCode == 200) {
      var data = jsonDecode(res.body);
      return categoriesFromJson(data["data"]);
    } else {
      return null;
    }
  }

  Future<List<Product>?> getProducts(
      ProductFilterModel productFilterModel) async {
    Map<String, String> requestHeaders = {"Content-Type": "application/json"};
    Map<String, String> queryString = {
      'page': productFilterModel.paginationModel.page.toString(),
      'pazeSize': productFilterModel.paginationModel.pageSize.toString()
    };
    if (productFilterModel.sortBy != null) {
      queryString["sort"] = productFilterModel.sortBy!;
    }
    var url = Uri.http(Config.apiUrl, Config.productAPI, queryString);
    var res = await client.get(url, headers: requestHeaders);
    if (res.statusCode == 200) {
      var data = jsonDecode(res.body);
      return productsFromJson(data["data"]);
    } else {
      return null;
    }
  }
}
