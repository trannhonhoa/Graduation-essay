import 'package:ecomshop/components/product_card.dart';
import 'package:ecomshop/models/pagination.dart';
import 'package:ecomshop/models/product.dart';
import 'package:ecomshop/models/product_filter.dart';
import 'package:ecomshop/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeProductWidget extends ConsumerWidget {
  const HomeProductWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      color: const Color(0xffF4F7FA),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Padding(
                padding: EdgeInsets.only(left: 16, top: 15),
                child: Text(
                  "Top 10 products",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: _productList(ref),
          )
        ],
      ),
    );
  }

  Widget _productList(WidgetRef ref) {
    final products = ref.watch(homeproductsProvider(ProductFilterModel(
        paginationModel: PaginationModel(page: 1, pageSize: 10))));
    return products.when(
        data: (list) {
          return _buildProductList(list!);
        },
        error: (_, __) {
          return const Center(child: Text("ERROR"));
        },
        loading: () => const CircularProgressIndicator());
  }

  Widget _buildProductList(List<Product> products) {
    return Container(
      height: 200,
      alignment: Alignment.centerLeft,
      child: ListView.builder(
        physics: const ClampingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: products.length,
        itemBuilder: (context, index) {
          var data = products[index];
          return GestureDetector(
            onTap: () {
              print(123);
            },
            child: ProductCard(
              model: data,
            ),
          );
        },
      ),
    );
  }
}
