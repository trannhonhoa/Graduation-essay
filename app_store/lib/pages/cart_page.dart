import 'package:ecomshop/application/state/cart_state.dart';
import 'package:ecomshop/config.dart';
import 'package:ecomshop/models/cart.dart';
import 'package:ecomshop/models/cart_product.dart';
import 'package:ecomshop/provider.dart';
import 'package:ecomshop/widgets/widget_cart_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartPage extends ConsumerStatefulWidget {
  const CartPage({super.key});

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends ConsumerState<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: _cartList(ref),
              flex: 1,
            )
          ],
        ),
      ),
    );
  }

  Widget _buidCartItems(List<CartProduct> cartProducts, WidgetRef ref) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      scrollDirection: Axis.vertical,
      itemCount: cartProducts.length,
      itemBuilder: (context, index) {
        return CartItemWidget(
            model: cartProducts[index],
            onQtyUpdate: (CartProduct model, qty, type) {
              final cartViewModel = ref.read(cartItemProvider.notifier);
              cartViewModel.updatedQty(model.product, qty, type);
            },
            onItemRemove: (CartProduct model) {
              final cartViewModel = ref.read(cartItemProvider.notifier);
              cartViewModel.removeCartItem(model.product.productId, model.qty);
            });
      },
    );
  }

  Widget _cartList(WidgetRef ref) {
    final cartState = ref.watch(cartItemProvider);
    if (cartState.cartModel == null) {
      return const LinearProgressIndicator();
    }
    if (cartState.cartModel!.products.isEmpty) {
      return const Center(
        child: Text("Cart Empty"),
      );
    }
    return _buidCartItems(cartState.cartModel!.products, ref);
  }
}

class _checkoutBottomNavbar extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartProvider = ref.watch(cartItemProvider);
    if (cartProvider.cartModel != null) {
      return cartProvider.cartModel!.products.isNotEmpty
          ? (Container(
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          "Total: ${Config.currentcy}${cartProvider.cartModel!.grandTotal.toString()}")
                    ],
                  ),
                ),
              ),
            ))
          : SizedBox();
    }
    return SizedBox();
  }
}
