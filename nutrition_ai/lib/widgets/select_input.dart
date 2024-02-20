import 'package:flutter/material.dart';

class SelectInput extends StatefulWidget {
  final TextEditingController controller;
  final String name;
  final List<DropdownMenuItem<String>> items;
  final String? defaultValue;
  final void Function(String)? onChanged;

  const SelectInput({
    super.key,
    required this.controller,
    required this.name,
    required this.items,
    this.defaultValue,
    this.onChanged,
  });

  @override
  State<SelectInput> createState() => _SelectInputState();
}

class _SelectInputState extends State<SelectInput> {
  late String _dropdownValue;

  @override
  void initState() {
    super.initState();
    _dropdownValue = widget.defaultValue ?? widget.items.first.value ?? '';
    widget.controller.text = _dropdownValue;
  }

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
            value: _dropdownValue,
            items: widget.items,
            onChanged: (String? value) {
              setState(() {
                _dropdownValue = value ?? '';
                widget.controller.text = value ?? '';
              });
              if (widget.onChanged != null) {
                widget.onChanged!(value ?? '');
              }
            },
            isExpanded: true,
          ),
        ],
      ),
    );
  }
}