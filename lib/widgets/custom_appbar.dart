import 'package:flutter/material.dart';

AppBar customAppbar(BuildContext context, String title) {
  return AppBar(
    leading: IconButton(
      icon: Icon(
        Icons.arrow_back_ios_rounded,
      ),
      onPressed: () => Navigator.of(context).pop(),
    ),
    centerTitle: true,
    title: Text(
      title,
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
    ),
  );
}
