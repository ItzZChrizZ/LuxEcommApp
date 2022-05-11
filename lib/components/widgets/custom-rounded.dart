// ignore_for_file: unused_local_variable, prefer_typing_uninitialized_variables, file_names

import 'package:flutter/material.dart';

class CustomButtonRounded extends StatelessWidget {
  final onPressed;

  final String text;

  final bool outlineBtn;
  final bool isLoading;

  const CustomButtonRounded({
    Key? key,
    required this.text,
    required this.onPressed,
    this.outlineBtn = true,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _outlineBtn = outlineBtn;
    bool _isLoading = isLoading;
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 24,
        ),
        height: size.height * 0.08,
        width: size.width * 0.9,
        decoration: BoxDecoration(
          color: _outlineBtn ? Colors.white : Colors.black,
          border: Border.all(
            color: Colors.black,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Stack(
          children: [
            Visibility(
              visible: isLoading ? false : true,
              child: Center(
                child: Text(
                  text,
                  style: TextStyle(
                    color: _outlineBtn ? Colors.black : Colors.white,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
            Visibility(
              visible: isLoading ? true : false,
              child: const Center(
                child: SizedBox(
                  height: 30,
                  width: 30,
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
