import 'package:flutter/material.dart';

TextFormField customTextField({
  required TextEditingController controller,
  required String label,
  required bool required,
  required Function(String?) onSaved,
  VoidCallback? onTap,
  String? hint,
  Widget? prefixIcon,
  bool? isEmail,
  int? maxLines,
  required bool border,
  TextInputType? inputType,
}) {
  return TextFormField(
    onTap: onTap,
    keyboardType: inputType,
    maxLines: maxLines,
    controller: controller,
    decoration: InputDecoration(
      fillColor: Colors.white,
      isDense: true,
      prefix: prefixIcon,
      border: border
          ? OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            )
          : InputBorder.none,
      // labelText: label,
      hintText: hint ?? "Masukan Data",
    ),
    validator: required
        ? (value) {
            if (value!.isEmpty) {
              return "$label Wajib diisi !";
            }
            if (isEmail != null && isEmail == true) {
              if (!RegExp(r"^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+$")
                  .hasMatch(value)) {
                return 'Enter a valid email address';
              }
            }
            return null;
          }
        : (value) {
            if (value!.isNotEmpty) {
              if (isEmail != null && isEmail == true) {
                if (!RegExp(r"^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+$")
                    .hasMatch(value)) {
                  return 'Enter a valid email address';
                }
              }
            }
            return null;
          },
    onSaved: onSaved,
  );
}
