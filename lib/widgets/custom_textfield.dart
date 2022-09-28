import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.suffixIcon,
    this.inputType,
    this.validatorFunction,
    this.obscureText = false,
  });

  final TextEditingController controller;
  final String hintText;
  final Widget? suffixIcon;
  final TextInputType? inputType;
  final bool obscureText;

  final String? Function(String?)? validatorFunction;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.transparent, width: 0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.transparent, width: 0),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        filled: true,
        fillColor: const Color(0xFFF5F6FA),
        hintText: hintText,
        suffixIcon: suffixIcon,
      ),
      keyboardType: inputType,
      validator: validatorFunction,
    );
  }
}
