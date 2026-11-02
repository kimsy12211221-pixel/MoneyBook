import 'package:flutter/material.dart';

import '../../../../domain/models/category.dart';
import '../../../../core/theme/app_spacing.dart';

class CategoryPicker extends StatelessWidget {
  const CategoryPicker({
    required this.categories,
    required this.selectedCategoryId,
    required this.onSelected,
    super.key,
  });

  final List<Category> categories;
  final int? selectedCategoryId;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    final spacing = Theme.of(context).extension<AppSpacing>()!;

    return Wrap(
      spacing: spacing.sm,
      runSpacing: spacing.sm,
      children: categories.map((category) {
        return GestureDetector(
          onLongPress: () => _showDescription(context, category),
          child: ChoiceChip(
            label: Text(category.name),
            selected: selectedCategoryId == category.id,
            onSelected: (_) => onSelected(category.id),
          ),
        );
      }).toList(growable: false),
    );
  }

  Future<void> _showDescription(BuildContext context, Category category) {
    return showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(category.name),
        content: Text(
          category.description?.trim().isNotEmpty == true
              ? category.description!
              : '이 카테고리에는 아직 설명이 없어요.',
        ),
        actions: [
          FilledButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('확인'),
          ),
        ],
      ),
    );
  }
}
