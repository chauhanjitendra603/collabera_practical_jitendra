import 'package:cached_network_image/cached_network_image.dart';
import 'package:collabera_test_jitendra/views/cart_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../common/constant.dart';
import '../controllers/cart_controller.dart';
import '../models/product_list_model.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;
  final CartController cartController = Get.put(CartController());

  ProductDetailScreen({super.key, required this.product});

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
          '',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(
                  Icons.shopping_cart,
                  color: Colors.white,
                ),
                onPressed: () {
                  Get.to(() => CartScreen());
                },
              ),
              Positioned(
                right: 0,
                child: Obx(() {
                  return cartController.getTotalItems() > 0
                      ? CircleAvatar(
                          radius: 10,
                          backgroundColor: Colors.red,
                          child: Text(
                            cartController.getTotalItems().toString(),
                            style: const TextStyle(
                                color: Colors.white, fontSize: 12),
                          ),
                        )
                      : Container();
                }),
              ),
            ],
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.deepPurple, width: 2),
                      ),
                      child: CachedNetworkImage(
                        height: 250,
                        width: MediaQuery.of(context).size.width,
                        imageUrl: product.image,
                        placeholder: (context, url) =>
                            Image.asset(IMAGES.LOADING_GIF),
                        errorWidget: (context, url, error) => Image.network(
                            IMAGES.ERROR_URL),
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      product.title,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '\$${product.price.toStringAsFixed(2)}',
                      style: const TextStyle(
                          fontSize: 22,
                          color: Colors.green,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(product.description),
                    const SizedBox(
                        height: 16), // Add some spacing before the button
                  ],
                ),
              ),
            ),
            Center(
              child: Obx(() {
                int quantity =
                    cartController.quantities[product.id.toString()] ?? 0;
                return quantity > 0
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              cartController.removeFromCart(product);
                              showMsg(All_String.REMOVED_FROM_CART);
                            },
                            style: ElevatedButton.styleFrom(
                              shape: const CircleBorder(),
                              backgroundColor: Colors.deepPurple,
                              padding: const EdgeInsets.all(8),
                            ),
                            child:
                                const Icon(Icons.remove, color: Colors.white),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.deepPurple, width: 2),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              quantity.toString(),
                              style: const TextStyle(fontSize: 18),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              cartController.addToCart(product);
                              showMsg("Added to Cart");
                            },
                            style: ElevatedButton.styleFrom(
                              shape: const CircleBorder(),
                              backgroundColor: Colors.deepPurple,
                              padding: const EdgeInsets.all(8),
                            ),
                            child: const Icon(Icons.add, color: Colors.white),
                          ),
                        ],
                      )
                    : MaterialButton(
                        height: 45,
                        minWidth: 330,
                        onPressed: () {
                          cartController.addToCart(product);
                          showMsg(All_String.ADDED_TO_CART);
                        },
                        color: Colors.deepPurple,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        child: const Padding(
                          padding: EdgeInsets.only(left: 8, right: 8),
                          child: Text(
                            All_String.ADD_TO_CART,
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

showMsg(String msg, {Color? color}) {
  Get.showSnackbar(GetSnackBar(
    snackPosition: SnackPosition.TOP,
    backgroundColor: Colors.black,
    duration: const Duration(milliseconds: 650),
    borderRadius: 10,
    messageText: Text(
      msg,
      style: const TextStyle(color: Colors.white),
    ),
    margin: const EdgeInsets.fromLTRB(20, 5, 20, 20),
  ));
}
