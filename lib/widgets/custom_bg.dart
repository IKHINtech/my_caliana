import 'package:flutter/material.dart';

List<Widget> customBg(BuildContext context, Widget child) {
  return [
    Container(
      color: Colors.white,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
    ),
    Positioned(
      bottom: -150,
      left: 0,
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width + 140,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            opacity: 0.06,
            image: AssetImage(
              "assets/images/icon-removebg-preview.png",
            ),
          ),
        ),
      ),
    ),
    child
  ];
}
