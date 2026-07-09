import 'package:flutter/material.dart';

class DropdownFieldWidget<T> extends StatelessWidget {
  final String label;
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final bool isMandatory;
  final void Function(T?)? onChanged;
  final String? Function(T?)? validator;

  const DropdownFieldWidget({
    super.key,
    required this.label,
    required this.value,
    required this.items,
    required this.isMandatory,
    this.onChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      initialValue: value,
      decoration: InputDecoration(
        label: Text.rich(TextSpan(text: label, children: [
          if (isMandatory == true) ... [
            TextSpan(text: ' *', style: TextStyle(color: Colors.red))
          ]
        ])),
        border: const OutlineInputBorder(),
      ),
      items: items,
      onChanged: onChanged,
      validator: validator,
    );
  }
}
