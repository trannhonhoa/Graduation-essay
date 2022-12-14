import 'package:ecomshop/api/api_service.dart';
import 'package:ecomshop/application/notifier/product_filter_notify.dart';
import 'package:ecomshop/application/notifier/product_notify.dart';
import 'package:ecomshop/application/state/product_state.dart';
import 'package:ecomshop/models/category.dart';
import 'package:ecomshop/models/slider.dart';
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
//slider
final slidersProvider =
    FutureProvider.family<List<SliderModel>?, PaginationModel>(
        (ref, paginationModel) {
  final apiRepository = ref.watch(apiService);
  return apiRepository.getSliders(
      paginationModel.page, paginationModel.pageSize);
});
// productDetail
final productDetailsProvider =
    FutureProvider.family<Product?, String>((ref, productId) {
  final apiRepository = ref.watch(apiService);
  return apiRepository.getProductDetails(productId);
});
// product related
final relatedProductsProvider =
    FutureProvider.family<List<Product>?, ProductFilterModel>(
        (ref, productFilterModel) {
  final apiRepository = ref.watch(apiService);
  return apiRepository.getProducts(productFilterModel);
});
