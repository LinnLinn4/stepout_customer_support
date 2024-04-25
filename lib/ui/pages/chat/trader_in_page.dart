import 'package:stepout_customer_support/cart_notifier.dart';
import 'package:stepout_customer_support/trade_in_notifier.dart';
import 'package:stepout_customer_support/utility/color.dart';
import 'package:stepout_customer_support/utility/navigation.dart';
import 'package:flutter/material.dart';
import 'package:stepout_customer_support/utils/CustomTextStyle.dart';
import 'package:stepout_customer_support/utils/CustomUtils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class TradeInPage extends StatefulWidget {
  const TradeInPage({super.key});

  @override
  _TradeInPageState createState() => _TradeInPageState();
}

class _TradeInPageState extends State<TradeInPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<TradeInNotifier>(builder: (context, p, _) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          iconTheme: const IconThemeData(color: Color(0xFF2F2F87)),
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
            ],
          ),
        ),
        body: Column(
          children: <Widget>[
            createHeader(),
            // createSubTitle(context),
            Expanded(
              child: createCartList(context),
            ),
            footer(context)
          ],
        ),
      );
    });
  }

  footer(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Utils.getSizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FractionallySizedBox(
              widthFactor: 1,
              child: InkWell(
                onTap: () {
                  push(context, "new-trade-in");
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
                      "New Trade-In",
                      style: GoogleFonts.mulish(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Utils.getSizedBox(height: 8),
        ],
      ),
    );
  }

  createHeader() {
    return Container(
      alignment: Alignment.topLeft,
      margin: const EdgeInsets.only(left: 12, top: 12),
      child: Text(
        "Trade-In",
        style: CustomTextStyle.textFormFieldBold
            .copyWith(fontSize: 16, color: Colors.black),
      ),
    );
  }

  createSubTitle(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      margin: const EdgeInsets.only(left: 12, top: 4),
      child: Text(
        "Total ${context.read<CartNotifier>().products.length} Items",
        style: CustomTextStyle.textFormFieldBold
            .copyWith(fontSize: 12, color: Colors.grey),
      ),
    );
  }

  createCartList(BuildContext context) {
    final p = context.watch<TradeInNotifier>().tradeInProducts;
    return ListView.builder(
      // shrinkWrap: true,
      primary: false,
      itemBuilder: (context, position) {
        return GestureDetector(
          onTap: () {
            push(context, "coupon");
          },
          child: createCartListItem(p.elementAt(position), position),
        );
      },
      itemCount: p.length,
    );
  }

  createCartListItem(TradeInProduct p, int pos) {
    return Consumer<TradeInNotifier>(builder: (context, pp, _) {
      return Stack(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(left: 16, right: 16, top: 16),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(16))),
            child: Row(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(
                      right: 8, left: 8, top: 8, bottom: 8),
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(14)),
                    // color: Color(0xFF2F2F87).shade200,
                    image: DecorationImage(
                      image: AssetImage(p.assetsLink),
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
                Expanded(
                  flex: 100,
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.only(right: 8, top: 4),
                          child: Text(
                            p.name,
                            maxLines: 2,
                            softWrap: true,
                            style: CustomTextStyle.textFormFieldSemiBold
                                .copyWith(fontSize: 14),
                          ),
                        ),
                        Utils.getSizedBox(height: 6),
                        Text(
                          "Condition: ${p.condition}",
                          style: CustomTextStyle.textFormFieldRegular
                              .copyWith(color: Colors.grey, fontSize: 14),
                        ),
                        Text(
                          "Estimated Credits: ${p.credit}",
                          style: CustomTextStyle.textFormFieldRegular
                              .copyWith(color: Colors.grey, fontSize: 14),
                        ),
                        Text(
                          "Status: ${p.status}",
                          style: CustomTextStyle.textFormFieldBlack
                              .copyWith(color: const Color(0xFF2F2F87)),
                        ),
                        // Container(
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //     children: <Widget>[
                        //       Text(
                        //         "B ${p.price}",
                        //         style: CustomTextStyle.textFormFieldBlack
                        //             .copyWith(color: Color(0xFF2F2F87)),
                        //       ),
                        //       Padding(
                        //         padding: const EdgeInsets.all(8.0),
                        //         child: Row(
                        //           mainAxisAlignment: MainAxisAlignment.center,
                        //           crossAxisAlignment: CrossAxisAlignment.end,
                        //           children: <Widget>[
                        //             GestureDetector(
                        //               onTap: () {
                        //                 // p.decrementQuantity();
                        //                 context
                        //                     .read<CartNotifier>()
                        //                     .notifyListeners();
                        //               },
                        //               child: Icon(
                        //                 Icons.remove,
                        //                 size: 24,
                        //                 color: Colors.grey.shade700,
                        //               ),
                        //             ),
                        //             Container(
                        //               color: Colors.grey.shade200,
                        //               padding: const EdgeInsets.only(
                        //                   bottom: 2, right: 12, left: 12),
                        //               child: Text(
                        //                 p.quantity.toString(),
                        //                 style:
                        //                     CustomTextStyle.textFormFieldSemiBold,
                        //               ),
                        //             ),
                        //             GestureDetector(
                        //               onTap: () {
                        //                 p.incrementQuantity();
                        //                 context
                        //                     .read<CartNotifier>()
                        //                     .notifyListeners();
                        //               },
                        //               child: Icon(
                        //                 Icons.add,
                        //                 size: 24,
                        //                 color: Colors.grey.shade700,
                        //               ),
                        //             )
                        //           ],
                        //         ),
                        //       )
                        // ],
                        // ),
                        // ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      );
    });
  }
}
