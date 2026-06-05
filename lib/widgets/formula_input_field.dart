import 'package:flutter/material.dart';

class FormulaInputField extends StatelessWidget {
  const FormulaInputField({
    required this.controller,
    required this.label,
    this.suffixText,
    super.key,
  });

  final TextEditingController controller;
  final String label;
  final String? suffixText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: const TextInputType.numberWithOptions(
        decimal: true,
        signed: true,
      ),
      decoration: InputDecoration(
        labelText: label,
        suffixText: suffixText,
      ),
    );
  }
}
