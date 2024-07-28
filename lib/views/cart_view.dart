import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../common/constant.dart';
import '../controllers/cart_controller.dart';

class CartScreen extends StatelessWidget {
  final CartController cartController = Get.find<CartController>();

  CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: const Icon(
            Icons.arrow_back_rounded,
            color: Colors.white,
            size: 25,
          ),
        ),
        title: const Text(
          All_String.CART,
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Obx(() {
        if (cartController.cartItems.isEmpty) {
          return const Center(child: Text(All_String.YOUR_CART_IS_EMPTY));
        }
        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: cartController.cartItems.length,
                itemBuilder: (context, index) {
                  final product = cartController.cartItems[index];
                  return Card(
                    margin:
                        const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 1,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: CachedNetworkImage(
                              width: 60,
                              height: 60,
                              imageUrl: product.image,
                              placeholder: (context, url) =>
                                  Image.asset(IMAGES.LOADING_GIF),
                              errorWidget: (context, url, error) =>
                                  Image.network(IMAGES.ERROR_URL),
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product.title,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.black87,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                ),
                                const SizedBox(height: 3),
                                Obx(() {
                                  final quantity = cartController
                                          .quantities[product.id.toString()] ??
                                      0;
                                  final totalPrice = product.price * quantity;
                                  return Text(
                                    '\$${product.price.toStringAsFixed(2)} x $quantity = \$${totalPrice.toStringAsFixed(2)}',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  );
                                }),
                              ],
                            ),
                          ),
                          const SizedBox(width: 5),
                          Container(
                            constraints: const BoxConstraints(maxWidth: 135),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                IconButton(
                                  icon: const Icon(
                                    Icons.remove_circle_outline,
                                    color: Colors.red,
                                    size: 25,
                                  ),
                                  splashRadius: 20,
                                  onPressed: () {
                                    cartController.removeFromCart(product);
                                  },
                                ),
                                Obx(() => AnimatedContainer(
                                      duration:
                                          const Duration(milliseconds: 300),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: Colors.deepPurple.shade100,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Text(
                                        cartController.quantities[
                                                    product.id.toString()]
                                                ?.toString() ??
                                            '0',
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    )),
                                IconButton(
                                  icon: const Icon(
                                    Icons.add_circle_outline,
                                    color: Colors.green,
                                    size: 25,
                                  ),
                                  splashRadius: 20,
                                  onPressed: () {
                                    cartController.addToCart(product);
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(7.0),
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  //   color: Colors.green,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        All_String.TOTAL,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Obx(() => Text(
                            '\$${cartController.totalPrice.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          )),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Padding(
                  padding: EdgeInsets.only(left: 15, right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        All_String.PLACE_ORDER,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        );
      }),
    );
  }
}
