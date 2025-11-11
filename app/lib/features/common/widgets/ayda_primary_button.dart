import 'package:flutter/material.dart';

class AydaPrimaryButton extends StatelessWidget {
  const AydaPrimaryButton({
    super.key,
    required this.label,
    this.onPressed,
    this.icon,
    this.isExpanded = true,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool isExpanded;

  @override
  Widget build(BuildContext context) {
    final buttonChild = icon != null
        ? Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon),
              const SizedBox(width: 8),
              Text(label),
            ],
          )
        : Text(label);

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: Size(isExpanded ? double.infinity : 0, 48),
      ),
      child: buttonChild,
    );
  }
}
