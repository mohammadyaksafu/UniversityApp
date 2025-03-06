import 'package:flutter/material.dart';

class GuardButton extends StatelessWidget {
  final bool condition;
  final VoidCallback onPressed;
  final Widget child;

  const GuardButton({
    required this.condition,
    required this.onPressed,
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: condition ? onPressed : null,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        textStyle: TextStyle(fontSize: 18),
      ),
      child: child,
    );
  }
}