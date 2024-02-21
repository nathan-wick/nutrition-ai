import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'button_input.dart';

class DateInput extends StatefulWidget {
  final void Function(DateTime) onSelectedDateChanged;
  final String name;
  final DateTime? defaultValue;
  final DateTime? firstDate;
  final DateTime? lastDate;

  const DateInput({
    super.key,
    required this.onSelectedDateChanged,
    required this.name,
    this.defaultValue,
    this.firstDate,
    this.lastDate,
  });

  @override
  State<DateInput> createState() => _DateInputState();
}

class _DateInputState extends State<DateInput> {
  late DateTime selectedDate;

  @override
  void initState() {
    super.initState();
    selectedDate = widget.defaultValue ?? DateTime.now();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: widget.firstDate ??
          DateTime.now().subtract(const Duration(days: 36500)),
      lastDate: widget.lastDate ?? DateTime.now(),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        widget.onSelectedDateChanged(selectedDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
        ButtonInput(
          onTap: () {
            _selectDate(context);
          },
          message: DateFormat('MMMM d, y').format(selectedDate),
          icon: Icons.date_range,
          theme: ButtonInputTheme.primary,
        ),
      ],
    );
  }
}
