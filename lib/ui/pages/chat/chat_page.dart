// ignore_for_file: constant_identifier_names, depend_on_referenced_packages

import 'package:stepout_customer_support/cart_notifier.dart';
import 'package:stepout_customer_support/ui/pages/chat/chat_viewmodel.dart';
import 'package:stepout_customer_support/utility/color.dart';
import 'package:stepout_customer_support/utility/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:provider/provider.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
// import 'package:video_player/video_player.dart';

class ChatPage extends StatefulWidget {
  static const String route = "chat";
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late ChatViewModel chatViewModel;
  @override
  void initState() {
    chatViewModel = context.read<ChatViewModel>();
    chatViewModel.init(context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            ListTile(
              title: const Text('Customer Support'),
              onTap: () {},
            ),
            ListTile(
              title: const Text('Shopping Cart'),
              onTap: () {
                push(context, "cart");
              },
            ),
            ListTile(
              title: const Text('Trade In'),
              onTap: () {
                push(context, "trade-in");
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Color(0xFF2F2F87)),
        actions: [
          Center(
            child: InkWell(
              onTap: () {
                push(context, "cart");
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  // border: Border.all(color: Color(0xFF2F2F87)),
                ),
                child: const Icon(Icons.shopping_cart_sharp,
                    color: Color(0xFF2F2F87)),
              ),
            ),
          ),
          const SizedBox(
            width: 8,
          )
        ],
        title: Column(
          children: [
            Text(
              'StepOut',
              textAlign: TextAlign.center,
              style: GoogleFonts.mulish(
                fontSize: 17,
                color: AppColors.textColor,
                fontWeight: FontWeight.w700,
              ),
            ),
            // Text(
            //   '會診資訊',
            //   textAlign: TextAlign.center,
            //   style: GoogleFonts.mulish(
            //     color: const Color(0xFF0EAD69),
            //     fontSize: 13,
            //     fontWeight: FontWeight.w700,
            //   ),
            // ),
          ],
        ),
      ),
      body: ChangeNotifierProvider.value(
        value: chatViewModel,
        child: Consumer<ChatViewModel>(
            builder: (context, ChatViewModel chatViewModel, _) {
          if (chatViewModel.initializing) {
            return const FractionallySizedBox(
              widthFactor: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 10),
                  Text("Initializing, please wait..."),
                ],
              ),
            );
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Chat(
                  scrollController: chatViewModel.scrollController,
                  messages: [
                    ...chatViewModel.messagesList,
                    if (chatViewModel.messagesList.isNotEmpty)
                      const types.CustomMessage(
                        author: types.User(id: "autoscroll"),
                        id: "autoscroll",
                      )
                  ],
                  customMessageBuilder: (p0, {required messageWidth}) =>
                      customMessageBuilder(p0, chatViewModel,
                          messageWidth: messageWidth),
                  avatarBuilder: (author) {
                    if (author.id == "system") {
                      return const SizedBox();
                    }
                    if (author.id == "autoscroll") {
                      return const SizedBox();
                    }

                    return const SizedBox();
                  },
                  showUserAvatars: false,
                  emptyState: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Spacer(),
                        const Text(
                          "Hi...",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 32,
                            color: Color(0xFF2F2F87),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          "This is Brian, your AI customer support. ",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Color(0xFF2F2F87),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          "Happy to assist you throughout your shopping process.",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2F2F87),
                            fontSize: 16,
                          ),
                        ),
                        const Spacer(),
                        FractionallySizedBox(
                          widthFactor: 1,
                          child: SizedBox(
                            height: 50,
                            child: OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                    side: const BorderSide(
                                      color: Color(0xFF2F2F87),
                                      width: 1.5,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      side: const BorderSide(
                                        color: Color(0xFF2F2F87),
                                        width: 2,
                                      ),
                                    )),
                                onPressed: () {
                                  chatViewModel
                                      .sendMessage("Recommend me a shoe.");
                                },
                                child: const Text("Recommend me a shoe.")),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        FractionallySizedBox(
                          widthFactor: 1,
                          child: SizedBox(
                            height: 50,
                            child: OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                    side: const BorderSide(
                                      color: Color(0xFF2F2F87),
                                      width: 1.5,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      side: const BorderSide(
                                        color: Color(0xFF2F2F87),
                                        width: 2,
                                      ),
                                    )),
                                onPressed: () {
                                  chatViewModel.sendMessage(
                                      "What kind of warranty and after-sales support do you offer?");
                                },
                                child: const Text(
                                    "What kind of warranty and after-sales support do you offer?")),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        FractionallySizedBox(
                          widthFactor: 1,
                          child: SizedBox(
                            height: 50,
                            child: OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                    side: const BorderSide(
                                      color: Color(0xFF2F2F87),
                                      width: 1.5,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      side: const BorderSide(
                                        color: Color(0xFF2F2F87),
                                        width: 2,
                                      ),
                                    )),
                                onPressed: () {
                                  chatViewModel.sendMessage(
                                      "Do you have Nike Dunk size 7?");
                                },
                                child: const Text(
                                    "Do you have Nike Dunk size 7?")),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        FractionallySizedBox(
                            widthFactor: 1,
                            child: SizedBox(
                              height: 50,
                              child: OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                      side: const BorderSide(
                                        color: Color(0xFF2F2F87),
                                        width: 1.5,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        side: const BorderSide(
                                          color: Color(0xFF2F2F87),
                                          width: 2,
                                        ),
                                      )),
                                  onPressed: () {
                                    chatViewModel.sendMessage(
                                        "Do you have any trade-in program?");
                                  },
                                  child: const Text(
                                      "Do you have any trade-in program?")),
                            )),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                  onSendPressed: (text) {},
                  user: const types.User(id: "user"),
                  customBottomWidget: const SizedBox(),
                  theme: DefaultChatTheme(
                    backgroundColor: AppColors.whiteBackground,
                    primaryColor: Colors.grey.shade300,
                    secondaryColor: const Color(0xFF2F2F87),
                    receivedMessageBodyTextStyle: GoogleFonts.mulish(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                    sentMessageBodyTextStyle: GoogleFonts.mulish(
                      color: AppColors.textColor,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
              Container(
                color: Colors.white,
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    chatViewModel.recordOrStop();
                  },
                  child: FractionallySizedBox(
                    widthFactor: 1,
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        gradient: chatViewModel.isRecording
                            ? null
                            : const LinearGradient(
                                begin: Alignment(0.71, 0.71),
                                end: Alignment(-0.71, -0.71),
                                colors: [Color(0xFF2F2F87), Color(0xFF2F2F87)],
                              ),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: chatViewModel.isRecording
                              ? AppColors.accentColor
                              : Colors.transparent,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          chatViewModel.isRecording ? "Stop" : "Press to Talk",
                          style: GoogleFonts.mulish(
                            color: chatViewModel.isRecording
                                ? AppColors.accentColor
                                : Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget customMessageBuilder(types.CustomMessage message, ChatViewModel model,
      {required int messageWidth}) {
    if (message.id == "autoscroll") {
      return AutoScrollTag(
        key: const Key("scroll"),
        controller: chatViewModel.scrollController,
        index: 99999,
        child: const SizedBox(),
      );
    }
    if (message.id.contains("trade-")) {
      return Container(
        color: Colors.white,
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "You can go to the page by clicking the following button.",
              style: GoogleFonts.mulish(
                color: const Color(0xFF2F2F87),
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            FractionallySizedBox(
              widthFactor: 1,
              child: InkWell(
                onTap: () {
                  push(context, "trade-in");
                },
                child: Container(
                  height: 45,
                  decoration: ShapeDecoration(
                    color: AppColors.accentColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      "Go to Trade-In Page",
                      style: GoogleFonts.mulish(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      );
    }
    if (message.id.contains("product-cart")) {
      final product = model.productsList.firstWhere(
        (element) => element.name == message.id.split('-').last,
        orElse: () => model.productsList.first,
      );
      return Container(
        color: Colors.white,
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Here are the shoes I would recommend.",
              style: GoogleFonts.mulish(
                color: const Color(0xFF2F2F87),
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            ),
            Row(
              children: [
                Image.asset(
                  product.image,
                  width: 100,
                  height: 100,
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name,
                        style: GoogleFonts.mulish(
                          color: AppColors.textColor,
                          fontSize: 15,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        "฿ ${product.price}",
                        style: GoogleFonts.mulish(
                          color: AppColors.textColor,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            FractionallySizedBox(
              widthFactor: 1,
              child: InkWell(
                onTap: () {
                  if (context.read<CartNotifier>().products.indexWhere(
                          (element) => element.name == product.name) ==
                      -1) {
                    Fluttertoast.showToast(msg: "Added to cart");
                    context.read<CartNotifier>().addProduct(product);
                  }
                },
                child: Container(
                  height: 45,
                  decoration: ShapeDecoration(
                    color: AppColors.accentColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      context.watch<CartNotifier>().products.indexWhere(
                                  (element) => element.name == product.name) !=
                              -1
                          ? "Added to Cart"
                          : "Add to Cart",
                      style: GoogleFonts.mulish(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      );
    }
    return const SizedBox();
  }
}
