import 'package:ecomshop/models/pagination.dart';
import 'package:ecomshop/models/product_filter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductFilterNotify extends StateNotifier<ProductFilterModel> {
  ProductFilterNotify()
      : super(ProductFilterModel(
            paginationModel: PaginationModel(page: 0, pageSize: 10)));
  void setProductFilter(ProductFilterModel model) {
    state = model;
  }
}
