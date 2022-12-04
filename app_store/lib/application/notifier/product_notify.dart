import 'package:ecomshop/api/api_service.dart';
import 'package:ecomshop/application/state/product_state.dart';
import 'package:ecomshop/models/pagination.dart';
import 'package:ecomshop/models/product_filter.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductNotify extends StateNotifier<ProductState> {
  final APIService _apiService;
  final ProductFilterModel _filterModel;
  ProductNotify(this._apiService, this._filterModel)
      : super(const ProductState());
  int _page = 1;

  Future<void> getProduct() async {
    if (state.isLoading || !state.hasNext) {
      return;
    }
    state = state.copyWith(isLoading: true);
    var filterModel = _filterModel.copyWith(
        paginationModel: PaginationModel(page: _page, pageSize: 10));
    final products = await _apiService.getProducts(filterModel);
    final newProduct = [...state.products, ...products!];
    if (products.length % 10 != 0 || products.isEmpty) {
      state = state.copyWith(hasNext: false);
    }
    state = state.copyWith(products: newProduct);
    _page++;
    state = state.copyWith(isLoading: false);
  }
}
