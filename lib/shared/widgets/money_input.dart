import 'package:flutter/material.dart';

class MoneyInput extends StatelessWidget {
  const MoneyInput({
    required this.controller,
    this.label,
    this.autofocus = false,
    this.errorText,
    super.key,
  });

  final TextEditingController controller;
  final String? label;
  final bool autofocus;
  final String? errorText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      autofocus: autofocus,
      keyboardType: TextInputType.number,
      style: Theme.of(context).textTheme.displayMedium,
      decoration: InputDecoration(
        labelText: label,
        prefixText: '₩ ',
        hintText: '0',
        errorText: errorText,
      ),
    );
  }
}
