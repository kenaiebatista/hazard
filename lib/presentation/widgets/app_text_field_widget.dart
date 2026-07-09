import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFieldWidget extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool obscureText;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  final bool isMandatory;
  final List<TextInputFormatter>? inputFormatters;
  final void Function(String)? onChanged;

  const TextFieldWidget({
    super.key,
    required this.label,
    required this.controller,
    required this.isMandatory,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.suffixIcon,
    this.inputFormatters,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      validator: validator,
      inputFormatters: inputFormatters,
      onChanged: onChanged,
      decoration: InputDecoration(
        label: Text.rich(TextSpan(text: label, children: [
          if (isMandatory == true) ... [
            TextSpan(text: ' *', style: TextStyle(color: Colors.red))
          ]
        ])),
        suffixIcon: suffixIcon,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),

      ),
    );
  }
}
