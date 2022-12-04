import 'package:ecomshop/models/product.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part "product_state.freezed.dart";

@freezed
class ProductState with _$ProductState {
  const factory ProductState(
      {@Default(<Product>[]) List<Product> products,
      @Default(true) bool hasNext,
      @Default(false) bool isLoading}) = _ProductState;
}
