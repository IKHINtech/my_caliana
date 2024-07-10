import 'package:flutter/material.dart';
import 'package:my_caliana/const/colors.dart';

class LimitedLengthText extends StatelessWidget {
  final String text;
  final int maxLength;

  const LimitedLengthText({
    super.key,
    required this.text,
    required this.maxLength,
  });

  @override
  Widget build(BuildContext context) {
    String displayedText =
        text.length > maxLength ? '${text.substring(0, maxLength)}...' : text;

    return Text(
      displayedText,
      style: TextStyle(fontSize: 14, color: customGrey),
    );
  }
}
