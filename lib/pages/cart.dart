import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:pet_shop_app/const.dart';
import 'package:pet_shop_app/provider/cart_provider.dart';
import 'package:pet_shop_app/widgets/cartItem.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios_rounded,
            color: black.withOpacity(0.7),
            size: 18,
          ),
        ),
        title: Text(
          'Cart',
          style: poppin.copyWith(
              fontSize: 18, color: black, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: cartProvider.carts.isNotEmpty
                ? Text.rich(TextSpan(children: [
                    TextSpan(
                        text: '${cartProvider.carts.length} ',
                        style: poppin.copyWith(
                            fontSize: 14, fontWeight: FontWeight.w600)),
                    TextSpan(
                        text:
                            cartProvider.carts.length > 1 ? ' Items' : ' Item',
                        style: poppin.copyWith(
                            fontSize: 14, fontWeight: FontWeight.w400)),
                  ]))
                : Container(),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: List.generate(
                    cartProvider.carts.length,
                    (index) => Padding(
                          padding: const EdgeInsets.only(bottom: 15),
                          child: Container(
                            height: 105,
                            decoration: BoxDecoration(
                                color: grey.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(20)),
                            child: Slidable(
                                endActionPane: ActionPane(
                                    extentRatio: 0.15,
                                    motion: const BehindMotion(),
                                    children: [
                                      SlidableAction(
                                        onPressed: (context) {
                                          cartProvider.remoceCart(
                                              cartProvider.carts[index].id!);
                                        },
                                        icon: Icons.delete_outline_rounded,
                                        foregroundColor: Colors.red,
                                        autoClose: true,
                                        backgroundColor: grey.withOpacity(0.1),
                                        borderRadius:
                                            const BorderRadius.horizontal(
                                                right: Radius.circular(20)),
                                      )
                                    ]),
                                child:
                                    CartItem(cart: cartProvider.carts[index])),
                          ),
                        )),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: AnimatedContainer(
        duration: const Duration(seconds: 2),
        height: cartProvider.carts.isNotEmpty ? 265 : 0,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          color: white,
          boxShadow: [
            BoxShadow(
                color: black.withOpacity(0.2),
                offset: Offset.zero,
                spreadRadius: 5,
                blurRadius: 10)
          ],
        ),
        child: Padding(
          padding:
              const EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 30),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text.rich(TextSpan(children: [
                      TextSpan(
                          text: '${cartProvider.carts.length} ',
                          style: poppin.copyWith(
                              fontSize: 16,
                              color: grey,
                              fontWeight: FontWeight.w600)),
                      TextSpan(
                          text: cartProvider.carts.length > 1
                              ? ' Items'
                              : ' Item',
                          style: poppin.copyWith(
                              fontSize: 16,
                              color: grey,
                              fontWeight: FontWeight.w200)),
                    ])),
                    Text(
                      '\$${(cartProvider.totalPrice()).toStringAsFixed(2)}',
                      style: poppin.copyWith(
                          fontSize: 16,
                          color: grey,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Tax',
                      style: poppin.copyWith(
                          fontSize: 16,
                          color: grey,
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      '\$${(cartProvider.totalPrice() * 0.1).toStringAsFixed(2)}',
                      style: poppin.copyWith(
                          fontSize: 16,
                          color: grey,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total',
                      style: poppin.copyWith(
                          fontSize: 18,
                          color: black,
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      '\$${(cartProvider.totalPrice() * 1.1).toStringAsFixed(2)}',
                      style: poppin.copyWith(
                          fontSize: 18,
                          color: black,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: green,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(
                    child: Text(
                      'Check out',
                      style: poppin.copyWith(
                          fontSize: 16,
                          color: white,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
