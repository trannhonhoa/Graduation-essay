import 'dart:convert';

import 'package:api_cache_manager/api_cache_manager.dart';
import 'package:api_cache_manager/models/cache_db_model.dart';
import 'package:ecomshop/models/login_respone.dart';
import 'package:flutter/cupertino.dart';

class SharedService {
  // ignore: constant_identifier_names
  static const String KEY_NAME = "login_key";
  static Future<bool> isLoggedIn() async {
    var isCacheKeyEx = await APICacheManager().isAPICacheKeyExist(KEY_NAME);
    return isCacheKeyEx;
  }

  static Future<void> setLoginDetails(LoginResponeModel model) async {
    APICacheDBModel cacheDBModel =
        APICacheDBModel(key: KEY_NAME, syncData: jsonEncode(model.toJson()));
    await APICacheManager().addCacheData(cacheDBModel);
  }

  static Future<LoginResponeModel?> loginDetails() async {
    var isCacheKeyEx = await APICacheManager().isAPICacheKeyExist(KEY_NAME);
    if (isCacheKeyEx) {
      var cacheData = await APICacheManager().getCacheData(KEY_NAME);
      return loginResponeJson(cacheData.syncData);
    }
    return null;
  }

  static Future<void> logout(BuildContext context) async {
    await APICacheManager().deleteCache(KEY_NAME);
    // ignore: use_build_context_synchronously
    Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
  }
}
