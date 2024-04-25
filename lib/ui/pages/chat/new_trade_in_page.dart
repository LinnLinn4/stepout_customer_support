// ignore_for_file: unused_import, invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member, library_private_types_in_public_api

import 'package:stepout_customer_support/trade_in_notifier.dart';
import 'package:stepout_customer_support/utility/color.dart';
import 'package:stepout_customer_support/utility/navigation.dart';
import 'package:flutter/material.dart';
import 'package:stepout_customer_support/utility/CustomTextStyle.dart';
import 'package:stepout_customer_support/utility/CustomUtils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class NewTradeInPage extends StatefulWidget {
  const NewTradeInPage({super.key});

  @override
  _NewTradeInPageState createState() => _NewTradeInPageState();
}

class _NewTradeInPageState extends State<NewTradeInPage> {
  String? _character = "Walk-in";
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
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  FractionallySizedBox(
                    widthFactor: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Choose Product"),
                        const SizedBox(
                          height: 5,
                        ),
                        DropdownButton(
                          value: context.watch<TradeInNotifier>().seleced,
                          isExpanded: true,
                          items: context
                              .watch<TradeInNotifier>()
                              .tradeInProductsList
                              .map(
                                (e) => DropdownMenuItem(
                                    value: e.name, child: Text(e.name)),
                              )
                              .toList(),
                          hint: const Text("Product"),
                          onChanged: (value) {
                            context.read<TradeInNotifier>().seleced = value;
                            context.read<TradeInNotifier>().notifyListeners();
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  FractionallySizedBox(
                    widthFactor: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Product Condition"),
                        const SizedBox(
                          height: 5,
                        ),
                        DropdownButton(
                          value: context.watch<TradeInNotifier>().cond,
                          isExpanded: true,
                          items: ['Perfect', 'Medium', 'Damaged']
                              .map(
                                (e) =>
                                    DropdownMenuItem(value: e, child: Text(e)),
                              )
                              .toList(),
                          hint: const Text("Product Condition"),
                          onChanged: (value) {
                            context.read<TradeInNotifier>().cond = value;
                            context.read<TradeInNotifier>().notifyListeners();
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  FractionallySizedBox(
                    widthFactor: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Trade-in Method"),
                        const SizedBox(
                          height: 5,
                        ),
                        ListTile(
                          title: const Text('Walk-in'),
                          leading: Radio<String>(
                            value: "Walk-in",
                            groupValue: _character,
                            onChanged: (String? value) {
                              setState(() {
                                _character = value;
                              });
                            },
                          ),
                        ),
                        ListTile(
                          title: const Text('By delivery'),
                          leading: Radio<String>(
                            value: "By delivery",
                            groupValue: _character,
                            onChanged: (String? value) {
                              setState(() {
                                _character = value;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  if (_character == "By delivery")
                    const FractionallySizedBox(
                      widthFactor: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Location"),
                          SizedBox(
                            height: 5,
                          ),
                          TextField(
                            decoration: InputDecoration(
                              hintText: "Location",
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text("Phone number"),
                          SizedBox(
                            height: 5,
                          ),
                          TextField(
                            decoration: InputDecoration(
                              hintText: "Phone number",
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            )),
            footer(context)
          ],
        ),
      );
    });
  }

  String getValue(String value) {
    if (value == "Perfect") {
      return "4000";
    }
    if (value == "Medium") {
      return "3000";
    }
    if (value == "Damaged") {
      return "2000";
    }
    return "";
  }

  footer(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(left: 30),
                child: Text(
                  "Estimated Credits: ",
                  style: CustomTextStyle.textFormFieldMedium
                      .copyWith(color: Colors.grey, fontSize: 12),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(right: 30),
                child: Text(
                  getValue(context.watch<TradeInNotifier>().cond ?? ""),
                  style: CustomTextStyle.textFormFieldBlack
                      .copyWith(color: const Color(0xFF2F2F87), fontSize: 14),
                ),
              ),
            ],
          ),
          Utils.getSizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FractionallySizedBox(
              widthFactor: 1,
              child: InkWell(
                onTap: () {
                  final p = context
                      .read<TradeInNotifier>()
                      .tradeInProductsList
                      .firstWhere((element) =>
                          element.name ==
                          context.read<TradeInNotifier>().seleced!);
                  context.read<TradeInNotifier>().addProduct(
                        TradeInProduct(
                          context.read<TradeInNotifier>().cond!,
                          "Pending",
                          getValue(context.read<TradeInNotifier>().cond!),
                          id: 1,
                          assetsLink: p.assetsLink,
                          description: p.description,
                          name: p.name,
                          price: p.price,
                          quantity: 1,
                        ),
                      );
                  context.read<TradeInNotifier>().cond = null;
                  context.read<TradeInNotifier>().seleced = null;
                  _character = null;
                  context.read<TradeInNotifier>().notifyListeners();
                  Navigator.pop(context);
                  // push(context, "new-trade-in");
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
                      "Submit",
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

  // createCartList(BuildContext context) {
  //   final p = context.watch<TradeInNotifier>().tradeInProducts;
  //   return ListView.builder(
  //     // shrinkWrap: true,
  //     primary: false,
  //     itemBuilder: (context, position) {
  //       return createCartListItem(p.elementAt(position), position);
  //     },
  //     itemCount: p.length,
  //   );
  // }

  // createCartListItem(TradeInProduct p, int pos) {
  //   return Stack(
  //     children: <Widget>[
  //       Container(
  //         margin: EdgeInsets.only(left: 16, right: 16, top: 16),
  //         decoration: BoxDecoration(
  //             color: Colors.white,
  //             borderRadius: BorderRadius.all(Radius.circular(16))),
  //         child: Row(
  //           children: <Widget>[
  //             Container(
  //               margin: EdgeInsets.only(right: 8, left: 8, top: 8, bottom: 8),
  //               width: 80,
  //               height: 80,
  //               decoration: BoxDecoration(
  //                 borderRadius: BorderRadius.all(Radius.circular(14)),
  //                 // color: Color(0xFF2F2F87).shade200,
  //                 image: DecorationImage(
  //                   image: AssetImage(p.assetsLink),
  //                   fit: BoxFit.fitWidth,
  //                 ),
  //               ),
  //             ),
  //             Expanded(
  //               child: Container(
  //                 padding: const EdgeInsets.all(8.0),
  //                 child: Column(
  //                   mainAxisSize: MainAxisSize.max,
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: <Widget>[
  //                     Container(
  //                       padding: EdgeInsets.only(right: 8, top: 4),
  //                       child: Text(
  //                         p.name,
  //                         maxLines: 2,
  //                         softWrap: true,
  //                         style: CustomTextStyle.textFormFieldSemiBold
  //                             .copyWith(fontSize: 14),
  //                       ),
  //                     ),
  //                     Utils.getSizedBox(height: 6),
  //                     Text(
  //                       "Condition: " + p.condition,
  //                       style: CustomTextStyle.textFormFieldRegular
  //                           .copyWith(color: Colors.grey, fontSize: 14),
  //                     ),
  //                     Container(
  //                       child: Row(
  //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                         children: <Widget>[
  //                           Text(
  //                             "Estimated Credits: " + p.credit,
  //                             style: CustomTextStyle.textFormFieldRegular
  //                                 .copyWith(color: Colors.grey, fontSize: 14),
  //                           ),
  //                           Text(
  //                             "Status: ${p.status}",
  //                             style: CustomTextStyle.textFormFieldBlack
  //                                 .copyWith(color: Color(0xFF2F2F87)),
  //                           ),
  //                         ],
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //               flex: 100,
  //             )
  //           ],
  //         ),
  //       ),
  //     ],
  //   );
  // }
}
