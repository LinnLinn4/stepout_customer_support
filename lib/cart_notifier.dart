import 'package:flutter/foundation.dart';

class CartNotifier extends ChangeNotifier {
  List<Product> products = [];
  void addProduct(Product product) {
    products.add(product);
    notifyListeners();
  }
}

class Product {
  final int id;
  final String name;
  final String description;
  final double price;
  int quantity;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    this.quantity = 1, // Default quantity is 1
  });

  double getTotalPrice() {
    return price * quantity;
  }

  void incrementQuantity() {
    quantity++;
  }

  void decrementQuantity() {
    if (quantity > 1) {
      quantity--;
    }
  }
}
