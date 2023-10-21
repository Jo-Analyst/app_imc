import 'package:flutter/material.dart';

class InputText extends StatelessWidget {
  final String label;
  final Function(double value) getValueInput;

  const InputText({
    required this.getValueInput,
    required this.label,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: key,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(labelText: label),
      style: const TextStyle(fontSize: 20),
      onChanged: (value) {
        getValueInput(value.isEmpty ? 0 : double.parse(value));
      },
    );
  }
}
