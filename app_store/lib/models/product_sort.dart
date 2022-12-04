import 'package:freezed_annotation/freezed_annotation.dart';
part 'product_sort.freezed.dart';

@freezed
abstract class ProductSortModel with _$ProductSortModel {
  factory ProductSortModel({String? label, String? value}) = _ProductSortModel;
}
