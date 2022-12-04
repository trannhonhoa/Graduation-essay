import 'package:flutter/material.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  String? categoryId;
  String? categoryName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
      ),
      body: Text(categoryName ?? "Not Found"),
    );
  }

  @override
  void didChangeDependencies() {
    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;
    if (arguments != null) {
      categoryName = arguments['categoryName'];
      categoryId = arguments['categoryId'];
    }
    super.didChangeDependencies();
  }
}
