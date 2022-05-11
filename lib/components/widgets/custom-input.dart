// ignore_for_file: prefer_typing_uninitialized_variables, file_names

import 'package:flutter/material.dart';



class CustomInput extends StatelessWidget {
  final onPressed;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final bool? isPasswordField;

  final String text;
  const CustomInput(
      {Key? key,
      required this.onPressed,
      required this.text,
      this.onChanged,
      this.onSubmitted,
      this.focusNode,
      this.textInputAction,
      this.isPasswordField})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _isPasswordField = isPasswordField ?? false;
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: size.height * 0.08,
        width: size.width * 0.9,
        margin: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 24,
        ),
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(
            12,
          ),
        ),
        child: TextField(
          obscureText: _isPasswordField,
          textInputAction: textInputAction,
          focusNode: focusNode,
          onChanged: onChanged,
          onSubmitted: onSubmitted,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: text,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 18,
            ),
          ),
        ),
      ),
    );
  }
}
