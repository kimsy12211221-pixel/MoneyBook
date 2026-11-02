import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/types/enums.dart';
import '../../../core/utils/date_range_utils.dart';
import '../../../domain/models/upcoming_expense.dart';
import '../../../domain/providers/category_provider.dart';
import '../../../domain/providers/repositories_provider.dart';
import '../../../shared/widgets/app_scaffold.dart';
import '../../../shared/widgets/money_input.dart';
import '../../../shared/widgets/primary_button.dart';
import '../../transactions/presentation/widgets/category_picker.dart';

class AddUpcomingExpenseSheet extends ConsumerStatefulWidget {
  const AddUpcomingExpenseSheet({super.key});

  @override
  ConsumerState<AddUpcomingExpenseSheet> createState() =>
      _AddUpcomingExpenseSheetState();
}

class _AddUpcomingExpenseSheetState
    extends ConsumerState<AddUpcomingExpenseSheet> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  DateTime _scheduledDate = DateTime.now();
  int? _selectedCategoryId;

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final categories =
        ref.watch(activeCategoriesProvider).valueOrNull ?? const [];

    return AppScaffold(
      child: ListView(
        children: [
          Text('UPCOMING', style: Theme.of(context).textTheme.displayMedium),
          const SizedBox(height: 24),
          TextField(
            controller: _titleController,
            decoration: const InputDecoration(labelText: 'TITLE'),
          ),
          const SizedBox(height: 24),
          MoneyInput(controller: _amountController),
          const SizedBox(height: 24),
          CategoryPicker(
            categories: categories,
            selectedCategoryId: _selectedCategoryId,
            onSelected: (value) => setState(() => _selectedCategoryId = value),
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('SCHEDULED DATE'),
            subtitle: Text(DateRangeUtils.monthDayLabel(_scheduledDate)),
            onTap: _pickDate,
          ),
          const SizedBox(height: 24),
          PrimaryButton(label: 'SAVE', onPressed: _save),
        ],
      ),
    );
  }

  Future<void> _pickDate() async {
    final selected = await showDatePicker(
      context: context,
      initialDate: _scheduledDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (selected != null) {
      setState(() {
        _scheduledDate = selected;
      });
    }
  }

  Future<void> _save() async {
    final amount = int.tryParse(_amountController.text.replaceAll(',', ''));
    if (_titleController.text.trim().isEmpty || amount == null || amount <= 0) {
      return;
    }

    final now = DateTime.now();
    await ref.read(upcomingExpenseRepositoryProvider).createUpcomingExpense(
          UpcomingExpense(
            id: 0,
            title: _titleController.text.trim(),
            amount: amount,
            scheduledDate: _scheduledDate,
            categoryId: _selectedCategoryId,
            isRecurring: false,
            recurrenceType: UpcomingExpenseRecurrenceType.none,
            recurrenceInterval: null,
            isPaid: false,
            paidTransactionId: null,
            note: null,
            createdAt: now,
            updatedAt: now,
          ),
        );

    if (mounted) {
      Navigator.of(context).pop();
    }
  }
}
