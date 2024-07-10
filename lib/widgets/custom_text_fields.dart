import 'package:flutter/material.dart';
import 'package:my_caliana/const/colors.dart';

TextFormField customTextField({
  required TextEditingController controller,
  required bool required,
  required Function(String?) onSaved,
  VoidCallback? onTap,
  Function(String?)? onChange,
  String? hint,
  Widget? prefixIcon,
  bool? isEmail,
  int? maxLines,
  required bool isBorder,
  TextInputType? inputType,
}) {
  return TextFormField(
    onTap: onTap,
    keyboardType: inputType,
    maxLines: maxLines,
    controller: controller,
    decoration: InputDecoration(
      errorStyle: TextStyle(fontStyle: FontStyle.italic),
      contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
      fillColor: Colors.white,
      isDense: true,
      prefixIcon: prefixIcon,
      prefixIconColor: controller.text == "" ? customGrey : mainColor,
      border: isBorder == true
          ? OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(11),
              ),
              borderSide: BorderSide(
                color: controller.text == "" ? Colors.grey : mainColor,
              ),
            )
          : InputBorder.none,
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: controller.text == "" ? Colors.grey : mainColor,
          width: 0.5,
        ), // Ubah warna fokus di sini
        borderRadius: BorderRadius.all(
          Radius.circular(11),
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: controller.text == "" ? Colors.grey : mainColor,
          width: 0.5,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(11),
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: controller.text == "" ? Colors.grey : mainColor,
          width: 0.5,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(11),
        ),
      ),
      hintText: hint ?? "Masukan Data",
      hintStyle: TextStyle(fontSize: 13),
      // helperStyle: TextStyle(fontStyle: FontStyle.italic),
    ),
    onChanged: onChange,
    validator: required
        ? (value) {
            if (value!.isEmpty) {
              return "Wajib diisi !";
            }
            if (isEmail != null && isEmail == true) {
              if (!RegExp(r"^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+$")
                  .hasMatch(value)) {
                return 'Format email tidak valid';
              }
            }
            return null;
          }
        : (value) {
            if (value!.isNotEmpty) {
              if (isEmail != null && isEmail == true) {
                if (!RegExp(r"^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+$")
                    .hasMatch(value)) {
                  return 'Format email tidak valid';
                }
              }
            }
            return null;
          },
    onSaved: onSaved,
  );
}
