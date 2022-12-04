import 'package:ecomshop/pages/home_page.dart';
import 'package:ecomshop/pages/product_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sweet Cake',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
      routes: <String, WidgetBuilder>{
        '/products': (BuildContext context) => const ProductsPage()
      },
    );
  }
}
