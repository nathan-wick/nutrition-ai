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

  const ButtonInput({
    super.key,
    required this.onTap,
    required this.icon,
    required this.message,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: theme == ButtonInputTheme.primary
              ? Theme.of(context).primaryColor
              : theme == ButtonInputTheme.secondary
              ? Colors.grey
              : Colors.red,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: Colors.white,
                size: 20,
              ),
              const SizedBox(width: 14),
              Text(
                message,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}