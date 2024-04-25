import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Future<dynamic> push<E extends NavigationArgs?>(
    BuildContext context, String route,
    {E? args}) async {
  if (args?.route == route || args == null) {
    return await Navigator.of(context).pushNamed(route, arguments: args);
  } else {
    Fluttertoast.showToast(
      msg: "Wrong Arguments For Route",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
    );
  }
}

class NavigationArgs {
  NavigationArgs(this.route);
  final String route;
}
