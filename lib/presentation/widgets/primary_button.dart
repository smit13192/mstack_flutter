import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final void Function() onTap;
  final String text;

  const PrimaryButton({required this.onTap, required this.text, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: Colors.black87,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: Colors.grey[50],
              fontWeight: FontWeight.w700,
              letterSpacing: 2,
            ),
          ),
        ),
      ),
    );
  }
}
