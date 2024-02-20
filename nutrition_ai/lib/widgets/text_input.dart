import 'package:flutter/material.dart';

class TextInput extends StatefulWidget {
  final TextEditingController controller;
  final String name;
  final String? defaultValue;
  final void Function(String)? onChanged;
  final bool obscureText;
  final bool multipleLines;

  const TextInput({
    super.key,
    required this.controller,
    required this.name,
    this.defaultValue,
    this.onChanged,
    this.obscureText = false,
    this.multipleLines = false,
  });

  @override
  State<TextInput> createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
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
              widget.name,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(height: 6),
          TextField(
            controller: widget.controller..text = widget.defaultValue ?? '',
            onSubmitted: (String value) {
              if (widget.onChanged != null) {
                widget.onChanged!(value);
              }
            },
            obscureText: widget.obscureText,
            keyboardType: widget.multipleLines ? TextInputType.text : TextInputType.text,
            maxLines: widget.multipleLines ? null : 1,
            minLines: widget.multipleLines ? 3 : 1,
            decoration: InputDecoration(
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                fillColor: Colors.white,
                filled: true,
                hintText: 'Enter ${widget.name}',
                hintStyle: const TextStyle(color: Colors.grey)),
          ),
        ],
      ),
    );
  }
}