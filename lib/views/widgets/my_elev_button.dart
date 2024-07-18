import 'package:flutter/material.dart';

class MyElevButton extends StatelessWidget {
  final Widget icon;
  final VoidCallback? onTap;

  const MyElevButton({
    required this.icon,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(20),
      ),
      onPressed: onTap,
      child: icon,
    );
  }
}
