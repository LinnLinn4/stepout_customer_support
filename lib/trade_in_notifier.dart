import 'package:flutter/foundation.dart';

class TradeInNotifier extends ChangeNotifier {
  List<TradeInProduct> tradeInProducts = [];
  String? seleced;
  String? cond;

  List<TradeInProduct> tradeInProductsList = [
    TradeInProduct(
      "",
      "",
      "",
      id: 1,
      assetsLink: "assets/calm.png",
      description:
          "Enjoy a calm and comfortable experience wherever you go on holiday.",
      name: "Nike Calm",
      price: 2000,
      quantity: 1,
    ),
    TradeInProduct(
      "",
      "",
      "",
      id: 1,
      assetsLink: "assets/court.png",
      description:
          "If you love the classic look of '80s basketball, this shoe is perfect.",
      name: "Nike Court Vision Low Next Nature",
      price: 3000,
      quantity: 1,
    ),
    TradeInProduct(
      "",
      "",
      "",
      id: 1,
      assetsLink: "assets/force.png",
      description:
          "Comfortable, durable and timeless - that's why they're the #1 go-to item.",
      name: "Nike Air Force 1 '07",
      price: 5200,
      quantity: 1,
    ),
    TradeInProduct(
      "",
      "",
      "",
      id: 1,
      assetsLink: "assets/nike.png",
      description: "An '80s basketball icon made for hardwood courts.",
      name: "Nike Dunk Low",
      price: 5000,
      quantity: 1,
    ),
  ];

  void addProduct(TradeInProduct product) {
    tradeInProducts.add(product);
    notifyListeners();
  }
}

class TradeInProduct {
  final int id;
  final String name;
  final String description;
  final double price;
  final String condition;
  final String status;
  final String credit;

  final String assetsLink;
  int quantity;

  TradeInProduct(
    this.condition,
    this.status,
    this.credit, {
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.assetsLink,
    this.quantity = 1, // Default quantity is 1
  });
}
