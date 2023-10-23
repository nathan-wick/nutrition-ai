import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  final TextEditingController controller;
  final String name;
  final String? defaultValue;
  final bool? obscureText;

  const TextInput({
    super.key,
    required this.controller,
    required this.name,
    this.defaultValue,
    this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              name,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(height: 6),
          TextField(
            controller: controller..text = defaultValue ?? '',
            obscureText: obscureText ?? false,
            decoration: InputDecoration(
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                fillColor: Colors.white,
                filled: true,
                hintText: 'Enter $name',
                hintStyle: const TextStyle(color: Colors.grey)),
          ),
        ],
      ),
    );
  }
}