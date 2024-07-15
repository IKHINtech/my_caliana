import 'package:flutter/material.dart';
import 'package:my_caliana/const/colors.dart';

AppBar customAppbar(BuildContext context, String title) {
  return AppBar(
    leading: IconButton(
      icon: Icon(
        Icons.arrow_back_ios_rounded,
        color: customGrey,
      ),
      onPressed: () => Navigator.maybePop(context),
    ),
    centerTitle: true,
    title: Text(
      title,
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
    ),
  );
}
