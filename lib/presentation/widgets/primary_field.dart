import 'package:flutter/material.dart';

import '../../core/theme/textfield_border.dart';

class PrimaryField extends StatelessWidget {
  final bool seen;

  final TextEditingController controller;
  final String hintText;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final Widget? suffixIcon;

  const PrimaryField({
    required this.controller,
    required this.hintText,
    required this.validator,
    required this.keyboardType,
    this.seen = false,
    this.suffixIcon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      obscureText: seen,
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        hintText: hintText,
        enabledBorder: enabledBorder,
        focusedBorder: focusedBorder,
        errorBorder: errorBorder,
        focusedErrorBorder: focusedErrorBorder,
        filled: true,
        fillColor: Colors.grey[50],
      ),
    );
  }
}
