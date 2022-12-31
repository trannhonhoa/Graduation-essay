import 'dart:convert';

import 'package:ecomshop/config.dart';
import 'package:ecomshop/main.dart';
import 'package:ecomshop/models/cart.dart';
import 'package:ecomshop/models/category.dart';
import 'package:ecomshop/models/login_respone.dart';
import 'package:ecomshop/models/product.dart';
import 'package:ecomshop/models/product_filter.dart';
import 'package:ecomshop/models/slider.dart';
import 'package:ecomshop/utils/shared_service.dart';
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

    if (productFilterModel.categoryId != null) {
      queryString["categoryId"] = productFilterModel.categoryId!;
    }
    if (productFilterModel.sortBy != null) {
      queryString["sort"] = productFilterModel.sortBy!;
    }
    if (productFilterModel.productIds != null) {
      queryString["productIds"] = productFilterModel.productIds!.join(",");
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

  static Future<bool> registerUser(
      String fullName, String email, String password) async {
    Map<String, String> requestHeaders = {"Content-Type": "application/json"};
    var url = Uri.http(Config.apiUrl, Config.registerAPI);
    var respone = await client.post(url,
        headers: requestHeaders,
        body: jsonEncode(
            {'fullName': fullName, 'email': email, 'password': password}));
    if (respone.statusCode == 200) {
      return true;
    }
    return false;
  }

  static Future<bool> loginUser(String email, String password) async {
    Map<String, String> requestHeaders = {"Content-Type": "application/json"};
    var url = Uri.http(Config.apiUrl, Config.loginAPI);
    var respone = await client.post(url,
        headers: requestHeaders,
        body: jsonEncode({'email': email, 'password': password}));
    if (respone.statusCode == 200) {
      await SharedService.setLoginDetails(loginResponeJson(respone.body));
      return true;
    }
    return false;
  }

  Future<List<SliderModel>?> getSliders(page, pageSize) async {
    Map<String, String> requestHeaders = {"Content-Type": "application/json"};
    Map<String, String> queryString = {
      'page': page.toString(),
      'pazeSize': pageSize.toString()
    };
    var url = Uri.http(Config.apiUrl, Config.sliderAPI, queryString);
    var res = await client.get(url, headers: requestHeaders);
    if (res.statusCode == 200) {
      var data = jsonDecode(res.body);
      return slidersFromJson(data["data"]);
    } else {
      return null;
    }
  }

  // product details
  Future<Product?> getProductDetails(String productId) async {
    Map<String, String> requestHeaders = {"Content-Type": "application/json"};

    var url = Uri.http(Config.apiUrl, "${Config.productAPI}/$productId");
    var res = await client.get(url, headers: requestHeaders);
    if (res.statusCode == 200) {
      var data = jsonDecode(res.body);
      return Product.fromJson(data["data"]);
    } else {
      return null;
    }
  }

  // cart
  Future<Cart?> getCart() async {
    var loginDetails = await SharedService.loginDetails();
    Map<String, String> requestHeaders = {
      "Content-Type": "application/json",
      "Authorization": "Basic ${loginDetails!.data.token.toString()}"
    };

    var url = Uri.http(Config.apiUrl, Config.cartAPI);
    var res = await client.get(url, headers: requestHeaders);
    if (res.statusCode == 200) {
      var data = jsonDecode(res.body);
      return Cart.fromJson(data["data"]);
    } else if (res.statusCode == 401) {
      navigatorKey.currentState
          ?.pushNamedAndRemoveUntil("/login", (route) => false);
    }
    return null;
  }

  // addCart
  Future<bool?> addCartItem(productId, qty) async {
    var loginDetails = await SharedService.loginDetails();
    Map<String, String> requestHeaders = {
      "Content-Type": "application/json",
      "Authorization": "Basic ${loginDetails!.data.token.toString()}"
    };

    var url = Uri.http(Config.apiUrl, Config.cartAPI);
    var res = await client.post(url,
        headers: requestHeaders,
        body: jsonEncode({
          "product": [
            {"productId": productId, "qyt": qty}
          ]
        }));
    if (res.statusCode == 200) {
      var data = jsonDecode(res.body);
      return true;
    } else if (res.statusCode == 401) {
      navigatorKey.currentState
          ?.pushNamedAndRemoveUntil("/login", (route) => false);
    }
    return null;
  }

  //remove cart
  Future<bool?> removeCartItem(productId, qty) async {
    var loginDetails = await SharedService.loginDetails();
    Map<String, String> requestHeaders = {
      "Content-Type": "application/json",
      "Authorization": "Basic ${loginDetails!.data.token.toString()}"
    };

    var url = Uri.http(Config.apiUrl, Config.cartAPI);
    var res = await client.delete(url,
        headers: requestHeaders,
        body: jsonEncode({
          "product": [
            {"productId": productId, "qyt": qty}
          ]
        }));
    if (res.statusCode == 200) {
      var data = jsonDecode(res.body);
      return true;
    } else if (res.statusCode == 401) {
      navigatorKey.currentState
          ?.pushNamedAndRemoveUntil("/login", (route) => false);
    }
    return null;
  }
}
