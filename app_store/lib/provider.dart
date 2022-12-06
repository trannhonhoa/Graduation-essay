import 'package:ecomshop/api/api_service.dart';
import 'package:ecomshop/application/notifier/product_filter_notify.dart';
import 'package:ecomshop/application/notifier/product_notify.dart';
import 'package:ecomshop/application/state/product_state.dart';
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

final productsFilterProvider =
    StateNotifierProvider<ProductFilterNotify, ProductFilterModel>(
        (ref) => ProductFilterNotify());

final productNotifierProvider =
    StateNotifierProvider<ProductNotify, ProductState>((ref) => ProductNotify(
        ref.watch(apiService), ref.watch(productsFilterProvider)));
