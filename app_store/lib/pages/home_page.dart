import 'package:ecomshop/widgets/widget_home_category.dart';
import 'package:ecomshop/widgets/widget_home_product.dart';
import 'package:ecomshop/widgets/widget_home_slider.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gocery Green'),
        backgroundColor: Colors.green,
      ),
      body: ListView(
        children: const [
          HomeSliderWidget(),
          HomeCategoriesWidget(),
          HomeProductWidget()
        ],
      ),
    );
  }
}
