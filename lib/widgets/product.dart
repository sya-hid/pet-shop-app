import 'package:flutter/material.dart';
import 'package:pet_shop_app/const.dart';
import 'package:pet_shop_app/models/product_model.dart';
import 'package:pet_shop_app/provider/cart_provider.dart';
import 'package:provider/provider.dart';

class ProductItem extends StatelessWidget {
  final ProductModel product;
  const ProductItem({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.3 + 60,
      width: MediaQuery.of(context).size.width * 0.5 - 30,
      child: Stack(
        children: [
          Positioned(
            top: 30,
            left: 10,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.3 + 10,
              width: MediaQuery.of(context).size.width * 0.5 - 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: white,
                  boxShadow: [
                    BoxShadow(
                        offset: const Offset(3, 3),
                        color: black.withOpacity(0.3),
                        spreadRadius: 0,
                        blurRadius: 5)
                  ]),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(5),
                  child: Stack(
                    children: [
                      Positioned(
                        top: 50,
                        left: 20,
                        right: 20,
                        child: Container(
                          width: 100,
                          height: 100,
                          decoration:
                              BoxDecoration(shape: BoxShape.circle, boxShadow: [
                            BoxShadow(
                                offset: Offset.zero,
                                color: product.color!,
                                spreadRadius: 5,
                                blurRadius: 30)
                          ]),
                        ),
                      ),
                      Image.asset(
                        'assets/foods/${product.image}',
                        height: 180,
                      ),
                    ],
                  ),
                ),
                Text(
                  product.name!,
                  style: poppin.copyWith(
                      fontSize: 16, color: black, fontWeight: FontWeight.w400),
                ),
                Text(
                  '\$${(product.price)!.toStringAsFixed(2)}',
                  style: poppin.copyWith(
                      fontSize: 18, color: black, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: GestureDetector(
              onTap: () {
                cartProvider.addCart(product, 1);
              },
              child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration:
                      const BoxDecoration(color: green, shape: BoxShape.circle),
                  child: Center(
                    child: Text(
                      '+',
                      style: poppin.copyWith(
                          color: white,
                          fontSize: 22,
                          fontWeight: FontWeight.w400),
                    ),
                  )),
            ),
          )
        ],
      ),
    );
  }
}
