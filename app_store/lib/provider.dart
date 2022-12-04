import 'package:ecomshop/api/api_service.dart';
import 'package:ecomshop/models/category.dart';
import 'package:ecomshop/models/product.dart';
import 'package:ecomshop/models/product_filter.dart';
import 'package:ecomshop/models/pagination.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final categoriesProvider =
    FutureProvider.family<List<Category>?, PaginationModel>(
        (ref, paginationModel) {
  final apiRepository = ref.watch(apiService);
  return apiRepository.getCategories(
      paginationModel.page, paginationModel.pageSize);
});
final homeproductsProvider =
    FutureProvider.family<List<Product>?, ProductFilterModel>(
        (ref, productFilterModel) {
  final apiRepository = ref.watch(apiService);
  return apiRepository.getProducts(productFilterModel);
});
