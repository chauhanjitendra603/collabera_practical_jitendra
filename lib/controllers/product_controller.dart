import 'package:collabera_test_jitendra/api_helper/api_service.dart';
import 'package:get/get.dart';
import '../models/product_list_model.dart';

class ProductController extends GetxController {
  var isLoading = false.obs;
  var productList = <Product>[].obs;

  @override
  void onInit() {
    fetchProducts();
    super.onInit();
  }

  void fetchProducts() async {
    try {
      isLoading(true);
      var products = await ApiService.fetchProducts();
      if (products.isNotEmpty) {
        productList.assignAll(products);
      }
    } finally {
      isLoading(false);
    }
  }
}
