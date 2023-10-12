import 'package:flutter/material.dart';

class SelectInput extends StatefulWidget {
  final TextEditingController controller;
  final String name;
  final List<DropdownMenuItem<String>> items;

  const SelectInput({
    super.key,
    required this.controller,
    required this.name,
    required this.items,
  });

  @override
  State<SelectInput> createState() => _SelectInputState();
}

class _SelectInputState extends State<SelectInput> {
  String? _dropdownValue;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
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
          DropdownButton<String>(
            value: _dropdownValue ?? widget.items.first.value,
            items: widget.items,
            onChanged: (String? value) {
              setState(() {
                _dropdownValue = value;
                widget.controller.text = value ?? '';
              });
            },
            isExpanded: true,
          ),
        ],
      ),
    );
  }
}