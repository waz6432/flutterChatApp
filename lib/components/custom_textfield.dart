import 'package:flutter/material.dart';
import 'package:mychat/constans.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    this.hintText,
    this.onChanged,
    this.keyboardType,
    this.textInputAction,
  });
  final TextInputType? keyboardType;
  final String? hintText;
  final Function(String)? onChanged;
  final TextInputAction? textInputAction;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      style: TextStyle(
        fontSize: 15.0,
      ),
      cursorColor: Colors.black,
      decoration: kTextFieldDecoration.copyWith(hintText: hintText),
      obscureText: keyboardType == TextInputType.visiblePassword ? true : false,
      onChanged: onChanged,
      textInputAction: textInputAction,
    );
  }
}
