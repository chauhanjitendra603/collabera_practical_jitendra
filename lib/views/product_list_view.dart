import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../common/constant.dart';
import '../controllers/product_controller.dart';
import 'product_detail_view.dart';

class ProductListScreen extends StatelessWidget {
  final ProductController productController = Get.put(ProductController());

  ProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
        title: const Text(
          All_String.PRODUCT_LIST,
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Obx(() {
        if (productController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        return RefreshIndicator(
          onRefresh: () async {
            productController.fetchProducts();
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Number of columns
                childAspectRatio: 0.70, // Adjust this as needed
              ),
              itemCount: productController.productList.length,
              itemBuilder: (context, index) {
                final product = productController.productList[index];
                return GestureDetector(
                  onTap: () {
                    Get.to(() => ProductDetailScreen(product: product));
                  },
                  child: Card(
                    margin: const EdgeInsets.all(8.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side:
                          const BorderSide(color: Colors.deepPurple, width: 2),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CachedNetworkImage(
                          width: double.infinity,
                          height: 140, // Adjust height as needed
                          imageUrl: product.image,
                          placeholder: (context, url) =>
                              Image.asset(IMAGES.LOADING_GIF),
                          errorWidget: (context, url, error) =>
                              Image.network(IMAGES.ERROR_URL),
                          fit: BoxFit.cover,
                        ),
                        Expanded(
                          // Ensures the remaining space is used by the text
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product.title,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500),
                                  overflow:
                                      TextOverflow.ellipsis, // Avoids overflow
                                  maxLines: 3,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  '\$${product.price.toStringAsFixed(2)}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w900),
                                  overflow:
                                      TextOverflow.ellipsis, // Avoids overflow
                                  maxLines: 1,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        );
      }),
    );
  }
}
