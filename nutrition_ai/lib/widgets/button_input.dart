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
  final bool removeMargin;

  const ButtonInput({
    super.key,
    required this.onTap,
    required this.icon,
    required this.message,
    required this.theme,
    this.removeMargin = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        margin: EdgeInsets.symmetric(horizontal: removeMargin ? 0 : 40),
        decoration: BoxDecoration(
          color: theme == ButtonInputTheme.primary
              ? Theme.of(context).primaryColor
              : theme == ButtonInputTheme.secondary
              ? Colors.grey
              : Colors.red,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: Colors.white,
                size: 18,
              ),
              const SizedBox(width: 10),
              Text(
                message,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}