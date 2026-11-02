import 'package:flutter/material.dart';

class ImpactMeter extends StatelessWidget {
  const ImpactMeter({
    required this.primaryText,
    required this.secondaryText,
    super.key,
  });

  final String primaryText;
  final String secondaryText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(primaryText, style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 4),
        Text(secondaryText, style: Theme.of(context).textTheme.bodyMedium),
      ],
    );
  }
}
