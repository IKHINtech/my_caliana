import 'package:flutter/material.dart';
import 'package:my_caliana/const/colors.dart';

class RoundedButton extends StatelessWidget {
  final String title;
  final bool isMain;
  final VoidCallback? onPressed;

  const RoundedButton(
      {super.key, required this.title, required this.isMain, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.all(14),
        width: double.infinity,
        decoration: BoxDecoration(
          color: !isMain ? null : mainColor,
          borderRadius: BorderRadius.circular(24),
          border: !isMain ? Border.all(color: mainColor) : null,
        ),
        child: Align(
          alignment: Alignment.center,
          child: Text(
            title,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: !isMain ? mainColor : Colors.white),
          ),
        ),
      ),
    );
  }
}
