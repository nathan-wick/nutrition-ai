import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextInput extends StatefulWidget {
  final TextEditingController controller;
  final String name;
  final String? defaultValue;
  final void Function(String)? onChanged;
  final bool obscureText;
  final bool multipleLines;
  final bool numbersOnly;

  const TextInput({
    super.key,
    required this.controller,
    required this.name,
    this.defaultValue,
    this.onChanged,
    this.obscureText = false,
    this.multipleLines = false,
    this.numbersOnly = false,
  });

  @override
  State<TextInput> createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            widget.name,
            style: const TextStyle(
              fontSize: 14,
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
          keyboardType: widget.multipleLines
              ? TextInputType.text
              : widget.numbersOnly
                  ? TextInputType.number
                  : TextInputType.text,
          inputFormatters: widget.numbersOnly
              ? [FilteringTextInputFormatter.digitsOnly]
              : null,
          maxLines: widget.multipleLines ? null : 1,
          minLines: widget.multipleLines ? 3 : 1,
          decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.circular(50),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Theme.of(context).primaryColor),
                borderRadius: BorderRadius.circular(50),
              ),
              fillColor: Colors.white,
              filled: true,
              hintText: 'Enter ${widget.name}',
              hintStyle: const TextStyle(color: Colors.grey)),
        ),
      ],
    );
  }
}
