import 'package:flutter/material.dart';
import 'package:pet_shop_app/models/cart_model.dart';
import 'package:pet_shop_app/models/product_model.dart';

class CartProvider with ChangeNotifier {
  List<CartModel> _carts = [];
  List<CartModel> get carts => _carts;

  set carts(List<CartModel> carts) {
    _carts = carts;
    notifyListeners();
  }

  addCart(ProductModel product, int qunatity) {
    if (productExist(product)) {
      int index =
          _carts.indexWhere((element) => element.product!.id == product.id);
      _carts[index].quantity = _carts[index].quantity! + qunatity;
    } else {
      _carts.add(
          CartModel(id: _carts.length, product: product, quantity: qunatity));
    }
    notifyListeners();
  }

  remoceCart(int id) {
    _carts.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  productExist(ProductModel product) {
    if (_carts.indexWhere((element) => element.product!.id == product.id) ==
        -1) {
      return false;
    } else {
      return true;
    }
  }

  totalPrice() {
    double total = 0;
    for (var element in _carts) {
      total += (element.quantity! * element.product!.price!);
    }
    return total;
  }
}
