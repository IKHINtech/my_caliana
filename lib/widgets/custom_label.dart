import 'package:flutter/material.dart';
import 'package:my_caliana/const/colors.dart';

RichText customLabel(String title, String? subtitle, bool isBold) {
  return RichText(
    text: TextSpan(
      text: title,
      style: TextStyle(
          fontWeight: isBold == false ? FontWeight.normal : FontWeight.bold,
          color: Colors.black),
      children: subtitle != null
          ? <TextSpan>[
              TextSpan(
                text: subtitle,
                style: TextStyle(
                    fontStyle: FontStyle.italic,
                    color: customGrey,
                    fontWeight: FontWeight.w300),
              ),
            ]
          : null,
    ),
  );
}
