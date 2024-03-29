import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proypet/config/global_variables.dart';

Widget appBar(
    {@required String texto, @required List<Widget> acc, bool logo = true}) {
  if (mediaAncho < 600) {
    return AppBar(
      leading: null,
      centerTitle: false,
      title: Row(children: [Text(texto)]),
      actions: acc,
    );
  } else {
    //pantallas grandes
    return AppBar(
      leading: null,
      centerTitle: false,
      backgroundColor: Colors.transparent,
      automaticallyImplyLeading: false,
      textTheme: TextTheme(
        headline6: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.w500,
          color: Get.textTheme.subtitle2.color,
        ),
      ),
      actionsIconTheme: IconThemeData(color: Get.textTheme.subtitle2.color),
      iconTheme: IconThemeData(color: Get.textTheme.subtitle2.color),
      title: Text(texto),
      actions: acc,
    );
  }
}
