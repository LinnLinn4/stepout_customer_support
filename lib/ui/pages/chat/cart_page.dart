import 'package:stepout_customer_support/cart_notifier.dart';
import 'package:stepout_customer_support/utility/color.dart';
import 'package:flutter/material.dart';
import 'package:stepout_customer_support/utils/CustomTextStyle.dart';
import 'package:stepout_customer_support/utils/CustomUtils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<CartNotifier>(builder: (context, p, _) {
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
            createSubTitle(context),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 30),
                child: Text(
                  "Total",
                  style: CustomTextStyle.textFormFieldMedium
                      .copyWith(color: Colors.grey, fontSize: 12),
                ),
              ),
              Container(
                margin: EdgeInsets.only(right: 30),
                child: Text(
                  "B ${context.watch<CartNotifier>().products.isEmpty ? '0.00' : context.watch<CartNotifier>().products.first.getTotalPrice().toString()}",
                  style: CustomTextStyle.textFormFieldBlack
                      .copyWith(color: Color(0xFF2F2F87), fontSize: 14),
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
                onTap: () {},
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
                      "CheckOut",
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
      margin: EdgeInsets.only(top: 16),
    );
  }

  createHeader() {
    return Container(
      alignment: Alignment.topLeft,
      child: Text(
        "SHOPPING CART",
        style: CustomTextStyle.textFormFieldBold
            .copyWith(fontSize: 16, color: Colors.black),
      ),
      margin: EdgeInsets.only(left: 12, top: 12),
    );
  }

  createSubTitle(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      child: Text(
        "Total ${context.read<CartNotifier>().products.length} Items",
        style: CustomTextStyle.textFormFieldBold
            .copyWith(fontSize: 12, color: Colors.grey),
      ),
      margin: EdgeInsets.only(left: 12, top: 4),
    );
  }

  createCartList(BuildContext context) {
    final p = context.watch<CartNotifier>().products;
    return ListView.builder(
      // shrinkWrap: true,
      primary: false,
      itemBuilder: (context, position) {
        return createCartListItem(p.elementAt(position), position);
      },
      itemCount: p.length,
    );
  }

  createCartListItem(Product p, int pos) {
    return Stack(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(left: 16, right: 16, top: 16),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(16))),
          child: Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(right: 8, left: 8, top: 8, bottom: 8),
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(14)),
                  // color: Color(0xFF2F2F87).shade200,
                  image: DecorationImage(
                    image: AssetImage("assets/nike.png"),
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(right: 8, top: 4),
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
                        p.description,
                        style: CustomTextStyle.textFormFieldRegular
                            .copyWith(color: Colors.grey, fontSize: 14),
                      ),
                      Text(
                        "size: 7",
                        style: CustomTextStyle.textFormFieldRegular
                            .copyWith(color: Colors.grey, fontSize: 14),
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "B ${p.price}",
                              style: CustomTextStyle.textFormFieldBlack
                                  .copyWith(color: Color(0xFF2F2F87)),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: () {
                                      p.decrementQuantity();
                                      context
                                          .read<CartNotifier>()
                                          .notifyListeners();
                                    },
                                    child: Icon(
                                      Icons.remove,
                                      size: 24,
                                      color: Colors.grey.shade700,
                                    ),
                                  ),
                                  Container(
                                    color: Colors.grey.shade200,
                                    padding: const EdgeInsets.only(
                                        bottom: 2, right: 12, left: 12),
                                    child: Text(
                                      p.quantity.toString(),
                                      style:
                                          CustomTextStyle.textFormFieldSemiBold,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      p.incrementQuantity();
                                      context
                                          .read<CartNotifier>()
                                          .notifyListeners();
                                    },
                                    child: Icon(
                                      Icons.add,
                                      size: 24,
                                      color: Colors.grey.shade700,
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                flex: 100,
              )
            ],
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: Container(
            width: 24,
            height: 24,
            alignment: Alignment.center,
            margin: EdgeInsets.only(right: 10, top: 8),
            child: GestureDetector(
              onTap: () {
                context.read<CartNotifier>().products.removeLast();
                context.read<CartNotifier>().notifyListeners();
              },
              child: Icon(
                Icons.close,
                color: Colors.white,
                size: 20,
              ),
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(4)),
                color: Color(0xFF2F2F87)),
          ),
        )
      ],
    );
  }
}
