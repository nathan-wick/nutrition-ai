import 'package:flutter/material.dart';

enum ButtonInputTheme {
  primary,
  secondary,
  danger,
}

class ButtonInput extends StatelessWidget {
  final Function() onTap;
  final IconData icon;
  final String message;
  final ButtonInputTheme theme;
  final bool displayShadow;

  const ButtonInput({
    super.key,
    required this.onTap,
    required this.icon,
    required this.message,
    required this.theme,
    this.displayShadow = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: theme == ButtonInputTheme.primary
              ? Theme.of(context).primaryColor
              : theme == ButtonInputTheme.secondary
                  ? Colors.blueGrey
                  : Colors.pink,
          borderRadius: BorderRadius.circular(50),
          boxShadow: displayShadow
              ? [
                  BoxShadow(
                    color: Theme.of(context).shadowColor,
                    blurRadius: 2,
                    offset: const Offset(0, 1),
                  ),
                ]
              : [],
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: Colors.white,
                size: 14,
              ),
              const SizedBox(width: 8),
              Text(
                message,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
