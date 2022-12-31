import 'package:ecomshop/api/api_service.dart';
import 'package:ecomshop/application/state/cart_state.dart';
import 'package:ecomshop/models/cart_product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartNotify extends StateNotifier<CartState> {
  final APIService _apiService;
  CartNotify(this._apiService) : super(const CartState()) {
    getCartItems();
  }
  Future<void> getCartItems() async {
    state = state.copyWith(isLoading: true);
    final caretData = await _apiService.getCart();
    state = state.copyWith(isLoading: false);
  }

  Future<void> addCartItem(productId, qty) async {
    await _apiService.addCartItem(productId, qty);
    await getCartItems();
  }

  Future<void> removeCartItem(productId, qty) async {
    await _apiService.removeCartItem(productId, qty);
    var isCartItemExist = state.cartModel!.products
        .firstWhere((element) => element.product.productId == productId);
    var updatedItems = state.cartModel!;
    updatedItems.products.remove(isCartItemExist);
    state = state.copyWith(cartModel: updatedItems);
  }

  Future<void> updatedQty(productId, qty, type) async {
    var cartItem = state.cartModel!.products
        .firstWhere((element) => element.product.productId == productId);
    var updatedItems = state.cartModel!;
    if (type == "-") {
      await _apiService.removeCartItem(productId, 1);
      if (cartItem.qty > 1) {
        CartProduct cartProduct =
            CartProduct(qty: cartItem.qty - 1, product: cartItem.product);
        updatedItems.products.remove(cartItem);
        updatedItems.products.add(cartProduct);
      } else {
        updatedItems.products.add(cartItem);
      }
    } else {
      CartProduct cartProduct =
          CartProduct(qty: cartItem.qty + 1, product: cartItem.product);
      updatedItems.products.remove(cartItem);
      updatedItems.products.add(cartProduct);
    }
    state = state.copyWith(cartModel: updatedItems);
  }
}
