import 'package:flutter/material.dart';

import '../../../../shared/widgets/meta_label.dart';

class WishlistRow extends StatelessWidget {
  const WishlistRow({
    required this.name,
    required this.price,
    required this.status,
    required this.impact,
    this.onTap,
    super.key,
  });

  final String name;
  final String price;
  final String status;
  final String impact;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(name, style: Theme.of(context).textTheme.bodyLarge),
          const SizedBox(height: 6),
          Text(price, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 6),
          MetaLabel(status),
          const SizedBox(height: 6),
          MetaLabel(impact),
        ],
      ),
    );
  }
}
