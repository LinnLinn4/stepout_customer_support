import 'package:stepout_customer_support/cart_notifier.dart';
import 'package:stepout_customer_support/route.dart';
import 'package:stepout_customer_support/trade_in_notifier.dart';
import 'package:stepout_customer_support/ui/pages/chat/chat_page.dart';
import 'package:stepout_customer_support/ui/pages/chat/chat_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:provider/provider.dart';
import 'package:stepout_customer_support/utility/color.dart';
import 'package:stepout_customer_support/utility/constants.dart';

void main() async {
  Gemini.init(apiKey: geminiAPIKey);

  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: CartNotifier()),
        ChangeNotifierProvider.value(value: TradeInNotifier()),
        ChangeNotifierProvider.value(value: ChatViewModel()),
      ],
      builder: (context, _) {
        return Container(
          color: Colors.black,
          child: const Center(
            child: ClipRect(
              child: SizedBox(
                // width: 400,
                child: MyApp(),
              ),
            ),
          ),
        );
      }));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'StepOut Customer Support',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: AppColors.whiteBackground,
      ),
      initialRoute: ChatPage.route,
      navigatorKey: RouteGenerator.navigatorKey,
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
