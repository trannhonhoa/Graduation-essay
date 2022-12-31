import 'package:ecomshop/components/widget_colapse_expands.dart';
import 'package:ecomshop/components/widget_custom_stepper.dart';
import 'package:ecomshop/config.dart';
import 'package:ecomshop/models/product.dart';
import 'package:ecomshop/provider.dart';
import 'package:ecomshop/widgets/widget_related_product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductDetailsPage extends ConsumerStatefulWidget {
  const ProductDetailsPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ProductDetailsPageState createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends ConsumerState<ProductDetailsPage> {
  String productId = "";
  int qty = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Product Details"),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(child: _productDetails(ref)),
    );
  }

  @override
  void didChangeDependencies() {
    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;
    productId = arguments["productId"];
    super.didChangeDependencies();
  }

  Widget _productDetails(WidgetRef ref) {
    final details = ref.watch(productDetailsProvider(productId));
    return details.when(data: (model) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _productDetailsUI(model!),
          RelatedProductWidget(relatedProducts: model.relatedProducts!)
        ],
      );
    }, error: (_, __) {
      return const Center(child: Text("ERR"));
    }, loading: () {
      return const CircularProgressIndicator();
    });
  }

  Widget _productDetailsUI(Product model) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 200,
            width: MediaQuery.of(context).size.width,
            child: Image.network(
              model.fullImagePath,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            model.productName,
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: 25, color: Colors.black, fontWeight: FontWeight.bold),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    '${Config.currentcy}${model.productPrice.toString()}',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 20,
                        color: model.calculateDiscount > 0
                            ? Colors.red
                            : Colors.black,
                        decoration: model.productSalePrice > 0
                            ? TextDecoration.lineThrough
                            : null),
                  ),
                  Text(
                    (model.calculateDiscount > 0)
                        ? " ${Config.currentcy}${model.productSalePrice}"
                        : "",
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              TextButton.icon(
                onPressed: () {},
                icon: const Text(
                  "SHARE",
                  style: TextStyle(color: Colors.black, fontSize: 13),
                ),
                label: const Icon(
                  Icons.share,
                  color: Colors.black,
                  size: 20,
                ),
              )
            ],
          ),
          Text(
            "Availability: ${model.stockStatus}",
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: 13, color: Colors.black, fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              "Product code: ${model.productSKU}",
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 13,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomStepper(
                  lowerLimit: 1,
                  upperLimit: 20,
                  stepValue: 1,
                  iconSize: 22.0,
                  value: 1,
                  onChanged: (value) {
                    qty = value["qty"];
                  }),
              TextButton.icon(
                onPressed: () {
                  final cartViewModel = ref.read(cartItemProvider.notifier);
                  cartViewModel.addCartItem(model.productId, qty);
                },
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.green)),
                icon: const Icon(
                  Icons.shopping_basket,
                  color: Colors.white,
                ),
                label: const Text(
                  "Add to cart",
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          ColExpand(
              title: "Short Description",
              content: model.productShortDescription!)
        ],
      ),
    );
  }
}
