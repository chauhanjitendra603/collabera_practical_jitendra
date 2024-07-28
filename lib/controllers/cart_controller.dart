import 'package:get/get.dart';
import '../models/product_list_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class CartController extends GetxController {
  var cartItems = <Product>[].obs;
  var quantities = <String, int>{}.obs; // Use product ID as the key

  @override
  void onInit() {
    super.onInit();
    loadCart();
  }

  void addToCart(Product product) {
    if (quantities.containsKey(product.id.toString())) {
      quantities.update(product.id.toString(), (value) => value + 1);
    } else {
      cartItems.add(product);
      quantities[product.id.toString()] = 1;
    }
    saveCart();
  }

  void removeFromCart(Product product) {
    String productId = product.id.toString();
    if (quantities.containsKey(productId) && quantities[productId]! > 0) {
      quantities.update(productId, (value) => value - 1);
      if (quantities[productId] == 0) {
        quantities.remove(productId);
        cartItems.removeWhere((item) => item.id == product.id);
      }
    }
    saveCart();
  }

  int getTotalItems() {
    return quantities.values.fold(0, (sum, item) => sum + item);
  }

  double get totalPrice => cartItems.fold(
      0,
      (sum, item) =>
          sum + (item.price * (quantities[item.id.toString()] ?? 0)));

  Future<void> saveCart() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> items = cartItems.map((product) {
      return json.encode({
        'product': product.toJson(),
        'quantity': quantities[product.id.toString()]
      });
    }).toList();
    await prefs.setStringList('cart', items);
  }

  Future<void> loadCart() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? items = prefs.getStringList('cart');
    if (items != null) {
      for (var item in items) {
        var data = json.decode(item);
        Product product = Product.fromJson(data['product']);
        int quantity = data['quantity'];
        cartItems.add(product);
        quantities[product.id.toString()] = quantity;
      }
    }
  }
}
