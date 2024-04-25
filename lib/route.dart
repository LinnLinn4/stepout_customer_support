import 'package:stepout_customer_support/ui/pages/chat/cart_page.dart';
import 'package:stepout_customer_support/ui/pages/chat/chat_page.dart';
import 'package:stepout_customer_support/ui/pages/chat/coupon_page.dart';
import 'package:stepout_customer_support/ui/pages/chat/new_trade_in_page.dart';
import 'package:stepout_customer_support/ui/pages/chat/trader_in_page.dart';

import 'package:flutter/material.dart';

class RouteGenerator {
  static final navigatorKey = GlobalKey<NavigatorState>();
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case ChatPage.route:
        return MaterialPageRoute(
            builder: (_) => const ChatPage(), settings: settings);
      case "trade-in":
        return MaterialPageRoute(
            builder: (_) => TradeInPage(), settings: settings);
      case "cart":
        return MaterialPageRoute(
            builder: (_) => CartPage(), settings: settings);
      case "new-trade-in":
        return MaterialPageRoute(
            builder: (_) => NewTradeInPage(), settings: settings);
      case "coupon":
        return MaterialPageRoute(
            builder: (_) => CouponPage(), settings: settings);

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute({String? message}) {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: Center(
          child: Text(message ?? 'ERROR'),
        ),
      );
    });
  }
}
