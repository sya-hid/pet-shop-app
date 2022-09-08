import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pet_shop_app/const.dart';
import 'package:pet_shop_app/models/category_model.dart';
import 'package:pet_shop_app/models/product_model.dart';
import 'package:pet_shop_app/pages/cart.dart';
import 'package:pet_shop_app/pages/detail.dart';
import 'package:pet_shop_app/provider/cart_provider.dart';
import 'package:pet_shop_app/widgets/category.dart';
import 'package:pet_shop_app/widgets/product.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String selectedCategory = 'Foods';
  int selectedPage = 0;
  List<CategoryModel> dataCategory = [];
  List<ProductModel> dataProduct = [];
  List<IconData> icons = [
    Icons.home_filled,
    Icons.favorite_border_rounded,
    Icons.chat_outlined,
    Icons.person_outline_rounded
  ];

  Future<void> getCategory() async {
    final String response =
        await rootBundle.loadString('assets/json/category.json');
    final data = json.decode(response);
    setState(() {
      for (var element in data['category']) {
        dataCategory.add(CategoryModel.fromJson(element));
      }
    });
  }

  Future<void> getProduct() async {
    final String response =
        await rootBundle.loadString('assets/json/product.json');
    final data = json.decode(response);
    setState(() {
      for (var element in data['product']) {
        dataProduct.add(ProductModel.fromJson(element));
      }
    });
  }

  @override
  void initState() {
    getCategory();
    getProduct();
    super.initState();
  }

  @override
  void dispose() {
    getCategory();
    getProduct();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);
    return Scaffold(
      backgroundColor: white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('mop Petshop',
                      style: poppin.copyWith(
                        fontSize: 20,
                        color: black,
                        fontWeight: FontWeight.bold,
                      )),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const CartPage()));
                    },
                    child: SizedBox(
                      height: 35,
                      width: 30,
                      child: Stack(
                        children: [
                          const Positioned(
                            bottom: 0,
                            child: Icon(
                              Icons.shopping_cart_outlined,
                              color: black,
                            ),
                          ),
                          cartProvider.carts.isNotEmpty
                              ? Positioned(
                                  top: 0,
                                  right: 0,
                                  child: Container(
                                      padding: const EdgeInsets.all(5),
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: deepPurple,
                                      ),
                                      child: Text(
                                        '${cartProvider.carts.length}',
                                        style: poppin.copyWith(color: white),
                                      )),
                                )
                              : Container()
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: grey.withOpacity(0.2),
                ),
                child: TextFormField(
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Search food, accesoris, etc ...',
                      hintStyle:
                          poppin.copyWith(color: deepPurple.withOpacity(0.6)),
                      prefixIcon: const Icon(
                        Icons.search,
                        color: deepPurple,
                      ),
                      prefixIconColor: deepPurple),
                ),
              ),
            ),
            const SizedBox(height: 20),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                    dataCategory.length,
                    (index) => Padding(
                          padding: index == 0
                              ? const EdgeInsets.only(left: 20, right: 20)
                              : const EdgeInsets.only(right: 20),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedCategory = dataCategory[index].text!;
                              });
                            },
                            child: CategoryItem(
                              category: dataCategory[index],
                              selectedCategory: selectedCategory,
                            ),
                          ),
                        )),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Best Seller',
                    style: poppin.copyWith(
                        color: black,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    'See all',
                    style: poppin.copyWith(
                      color: deepPurple,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                    dataProduct.length,
                    (index) => Padding(
                          padding: index == 0
                              ? const EdgeInsets.only(left: 20, right: 20)
                              : const EdgeInsets.only(right: 20),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DetailPage(
                                          product: dataProduct[index])));
                            },
                            child: ProductItem(
                              product: dataProduct[index],
                            ),
                          ),
                        )),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Special Bundle',
                    style: poppin.copyWith(
                        color: black,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    'See all',
                    style: poppin.copyWith(
                      color: deepPurple,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 150,
              width: MediaQuery.of(context).size.width - 40,
              child: Stack(
                children: [
                  Positioned(
                    bottom: 0,
                    child: Container(
                      height: 130,
                      width: MediaQuery.of(context).size.width - 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: purple.withOpacity(0.5),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 2,
                    left: -10,
                    child: Transform.rotate(
                      angle: -0.15,
                      child: Image.asset(
                        'assets/foods/meow-mix1.png',
                        height: 120,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 7,
                    left: 50,
                    child: Transform.rotate(
                      angle: 0.3,
                      child: Image.asset(
                        'assets/foods/authority1.png',
                        height: 120,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    left: 20,
                    child: Transform.rotate(
                      angle: 0,
                      child: Image.asset(
                        'assets/foods/royal-canin1.png',
                        height: 120,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 190,
                    top: 30,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Special Bundle',
                          style: poppin.copyWith(
                              fontSize: 16,
                              color: deepPurple,
                              fontWeight: FontWeight.w800),
                        ),
                        Text(
                          'Special offer\n Three in one',
                          style: poppin.copyWith(color: white, fontSize: 14),
                        ),
                        Text(
                          '\$${40.00}',
                          style: poppin.copyWith(
                              fontSize: 20,
                              color: black,
                              fontWeight: FontWeight.w800),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
        child: BottomNavigationBar(
            backgroundColor: white,
            selectedItemColor: deepPurple,
            unselectedItemColor: grey,
            elevation: 1,
            type: BottomNavigationBarType.fixed,
            onTap: (value) {
              setState(() {
                selectedPage = value;
              });
            },
            items: List.generate(
                icons.length,
                (index) => BottomNavigationBarItem(
                    icon: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(
                          icons[index],
                          color: selectedPage == index ? deepPurple : grey,
                        ),
                        const SizedBox(height: 5),
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 500),
                          width: selectedPage == index ? 15 : 0,
                          height: selectedPage == index ? 3 : 0,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: deepPurple),
                        )
                      ],
                    ),
                    label: ''))),
      ),
    );
  }
}
