import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_nim_game/constants.dart';

typedef OnValidateCallback = String? Function(String? value);

class TTextField extends StatelessWidget {
  const TTextField({
    super.key,
    required this.title,
    required this.placeholder,
    required this.controller,
    this.validator,
  });

  final String title;
  final String placeholder;
  final OnValidateCallback? validator;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      inputFormatters: [
        FilteringTextInputFormatter.allow(
          RegExp(r'[0-9]'),
        ),
        LengthLimitingTextInputFormatter(2),
      ],
      controller: controller,
      validator: validator,
      keyboardType: TextInputType.number,
      cursorColor: const Color(gray),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(32.0),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(gray)),
          borderRadius: BorderRadius.circular(6),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(gray)),
          borderRadius: BorderRadius.circular(6),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(primary)),
          borderRadius: BorderRadius.circular(6),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(primary)),
          borderRadius: BorderRadius.circular(6),
        ),
        hintText: placeholder,
        label: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontFamily: "Inter",
            fontSize: 20.0,
          ),
        ),
        hintStyle: const TextStyle(color: Color(0xFF616B7C)),
        errorMaxLines: 2,
        errorStyle: const TextStyle(
          color: Color(primary),
          fontSize: 16.0,
        ),
        filled: true,
        fillColor: const Color(background),
        focusColor: const Color(background),
      ),
      style: const TextStyle(fontFamily: "Inter", color: Colors.white),
    );
  }
}
