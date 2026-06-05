import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ClinicalNumberField extends StatelessWidget {
  const ClinicalNumberField({
    super.key,
    required this.controller,
    required this.label,
    this.suffix,
    this.allowDecimal = true,
  });

  final TextEditingController controller;
  final String label;
  final String? suffix;
  final bool allowDecimal;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: const TextInputType.numberWithOptions(
        decimal: true,
        signed: true,
      ),
      inputFormatters: [
        FilteringTextInputFormatter.allow(
          allowDecimal ? RegExp(r'^-?\d*[,]?\d*\.?\d*') : RegExp(r'^-?\d*'),
        ),
      ],
      decoration: InputDecoration(labelText: label, suffixText: suffix),
    );
  }
}
