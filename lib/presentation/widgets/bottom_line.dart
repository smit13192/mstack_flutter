import 'package:flutter/material.dart';

class BottomLine extends StatelessWidget {
  final void Function() onTap;
  final String text1;
  final String text2;
  const BottomLine(
      {required this.text1,
      required this.text2,
      required this.onTap,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text1,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        GestureDetector(
          onTap: onTap,
          child: Text(
            text2,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
        ),
      ],
    );
  }
}
