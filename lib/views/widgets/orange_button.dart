import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OrangeButton extends StatelessWidget {
  final String buttonText;
  final void Function() onTap;

  const OrangeButton({
    required this.onTap,
    required this.buttonText,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 60,
        decoration: BoxDecoration(
          color: const Color(0xFFF8E2D3),
          border: Border.all(
            color: const Color(0xffE16A1D),
            width: 3,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            buttonText,
            style: const TextStyle(
              fontSize: 26,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
