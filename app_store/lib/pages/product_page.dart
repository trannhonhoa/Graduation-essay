import 'package:ecomshop/components/product_card.dart';
import 'package:ecomshop/models/pagination.dart';
import 'package:ecomshop/models/product_filter.dart';
import 'package:ecomshop/models/product_sort.dart';
import 'package:ecomshop/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  // state
  String? categoryId;
  String? categoryName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
      ),
      body: Container(
        color: Colors.grey[300],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _ProductFilters(categoryId: categoryId, categoryName: categoryName),
            Flexible(
              flex: 1,
              child: _ProductList(),
            )
          ],
        ),
      ),
    );
  }

  @override
  void didChangeDependencies() {
    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;
    categoryName = arguments['categoryName'];
    categoryId = arguments['categoryId'];
    super.didChangeDependencies();
  }
}

class _ProductFilters extends ConsumerWidget {
  final _sortByOptions = [
    ProductSortModel(value: "createdAt", label: "Lastest"),
    ProductSortModel(value: "-productPrice", label: "Price: High to Low"),
    ProductSortModel(value: "productPrice", label: "Price: Low to High")
  ];

  _ProductFilters({Key? key, this.categoryName, this.categoryId});
  final String? categoryName;
  final String? categoryId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filterProvider = ref.watch(productsFilterProvider);
    return Container(
      height: 51,
      margin: const EdgeInsets.fromLTRB(10, 10, 10, 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              categoryName!,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
          ),
          Container(
            decoration: BoxDecoration(color: Colors.grey[300]),
            child: PopupMenuButton(
              onSelected: (sortBy) {
                ProductFilterModel filterModel = ProductFilterModel(
                    paginationModel: PaginationModel(page: 0, pageSize: 10),
                    categoryId: filterProvider.categoryId,
                    sortBy: sortBy.toString());
                ref
                    .read(productsFilterProvider.notifier)
                    .setProductFilter(filterModel);
                ref.read(productNotifierProvider.notifier).getProducts();
              },
              initialValue: filterProvider.sortBy,
              itemBuilder: (BuildContext context) {
                return _sortByOptions
                    .map((item) => PopupMenuItem(
                        value: item.value,
                        child: InkWell(child: Text(item.label!))))
                    .toList();
              },
              icon: const Icon(Icons.filter_list_alt),
            ),
          )
        ],
      ),
    );
  }
}

class _ProductList extends ConsumerWidget {
  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsState = ref.watch(productNotifierProvider);
    if (productsState.products.isEmpty) {
      if (!productsState.hasNext && !productsState.isLoading) {
        return const Center(child: Text('No Products'));
      }
      return const LinearProgressIndicator();
    }
    return RefreshIndicator(
        onRefresh: () {
          return ref.read(productNotifierProvider.notifier).refreshProducts();
        },
        child: Column(
          children: [
            Flexible(
              flex: 1,
              child: GridView.count(
                crossAxisCount: 2,
                children: List.generate(productsState.products.length, (index) {
                  return ProductCard(
                    model: productsState.products[index],
                  );
                }),
              ),
            )
          ],
        ));
  }
}
