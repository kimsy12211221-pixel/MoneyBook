import 'package:flutter/material.dart';

import '../../../../shared/widgets/meta_label.dart';

class CooldownBadge extends StatelessWidget {
  const CooldownBadge(this.label, {super.key});

  final String label;

  @override
  Widget build(BuildContext context) {
    return MetaLabel(label);
  }
}
