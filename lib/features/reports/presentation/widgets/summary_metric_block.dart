import 'package:flutter/material.dart';

import '../../../../shared/widgets/meta_label.dart';

class SummaryMetricBlock extends StatelessWidget {
  const SummaryMetricBlock({
    required this.label,
    required this.value,
    super.key,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MetaLabel(label),
        const SizedBox(height: 8),
        Text(value, style: Theme.of(context).textTheme.headlineMedium),
      ],
    );
  }
}
