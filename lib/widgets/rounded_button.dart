import 'package:flutter/material.dart';
import 'package:my_caliana/const/colors.dart';

class RoundedButton extends StatelessWidget {
  final String title;
  final bool isMain;
  final bool? isSmal;
  final VoidCallback? onPressed;

  const RoundedButton({
    super.key,
    required this.title,
    required this.isMain,
    this.onPressed,
    this.isSmal,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.all(isSmal == true ? 8 : 14),
        width: double.infinity,
        decoration: BoxDecoration(
          color: !isMain ? null : mainColor,
          borderRadius: BorderRadius.circular(isSmal == true ? 18 : 24),
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
