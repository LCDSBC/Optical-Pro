import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NumberField extends StatelessWidget {
  const NumberField({
    required this.controller,
    required this.label,
    this.suffix,
    this.integerOnly = false,
    super.key,
  });

  final TextEditingController controller;
  final String label;
  final String? suffix;
  final bool integerOnly;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(labelText: label, suffixText: suffix),
      keyboardType: const TextInputType.numberWithOptions(
        decimal: true,
        signed: true,
      ),
      inputFormatters: [
        FilteringTextInputFormatter.allow(
          integerOnly ? RegExp(r'[-0-9]') : RegExp(r'[-0-9,.]'),
        ),
      ],
      validator: (value) {
        final normalized = value?.replaceAll(',', '.').trim() ?? '';
        if (normalized.isEmpty || double.tryParse(normalized) == null) {
          return 'Informe um numero valido';
        }
        return null;
      },
    );
  }
}
