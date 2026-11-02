import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/types/enums.dart';
import '../../../core/utils/date_range_utils.dart';
import '../../../domain/models/transaction.dart';
import '../../../domain/providers/category_provider.dart';
import '../../../domain/providers/repositories_provider.dart';
import '../../../shared/widgets/app_scaffold.dart';
import '../../../shared/widgets/money_input.dart';
import '../../../shared/widgets/primary_button.dart';
import 'widgets/category_picker.dart';

class AddTransactionSheet extends ConsumerStatefulWidget {
  const AddTransactionSheet({super.key});

  @override
  ConsumerState<AddTransactionSheet> createState() =>
      _AddTransactionSheetState();
}

class _AddTransactionSheetState extends ConsumerState<AddTransactionSheet> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _memoController = TextEditingController();
  int? _selectedCategoryId;
  BudgetType _budgetType = BudgetType.monthly;
  SpecialCategory? _specialCategory;
  PaymentMethod _paymentMethod = PaymentMethod.cash;
  DateTime _occurredAt = DateTime.now();
  String? _errorText;

  @override
  void dispose() {
    _amountController.dispose();
    _memoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final categories =
        ref.watch(activeCategoriesProvider).valueOrNull ?? const [];

    return AppScaffold(
      child: ListView(
        children: [
          Text('ADD', style: Theme.of(context).textTheme.displayMedium),
          const SizedBox(height: 24),
          MoneyInput(
            controller: _amountController,
            autofocus: true,
            errorText: _errorText,
          ),
          const SizedBox(height: 24),
          Text('BUDGET TYPE', style: Theme.of(context).textTheme.labelLarge),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: BudgetType.values
                .map(
                  (type) => ChoiceChip(
                    label: Text(type.label),
                    selected: _budgetType == type,
                    onSelected: (_) => setState(() {
                      _budgetType = type;
                      if (type == BudgetType.monthly) {
                        _specialCategory = null;
                      } else {
                        _selectedCategoryId = null;
                      }
                    }),
                  ),
                )
                .toList(growable: false),
          ),
          if (_budgetType == BudgetType.annualSpecial) ...[
            const SizedBox(height: 16),
            Text(
              'SPECIAL CATEGORY',
              style: Theme.of(context).textTheme.labelLarge,
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: SpecialCategory.values
                  .map(
                    (category) => ChoiceChip(
                      label: Text(category.label),
                      selected: _specialCategory == category,
                      onSelected: (_) => setState(
                        () => _specialCategory = category,
                      ),
                    ),
                  )
                  .toList(growable: false),
            ),
          ],
          if (_budgetType == BudgetType.monthly) ...[
            const SizedBox(height: 24),
            CategoryPicker(
              categories: categories,
              selectedCategoryId: _selectedCategoryId,
              onSelected: (value) {
                setState(() {
                  _selectedCategoryId = value;
                });
              },
            ),
            const SizedBox(height: 8),
            Text(
              '카테고리를 길게 누르면 사용 기준을 볼 수 있어요.',
              style: Theme.of(context).textTheme.labelSmall,
            ),
            const SizedBox(height: 20),
            Text('PAYMENT', style: Theme.of(context).textTheme.labelLarge),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: PaymentMethod.values
                  .map(
                    (method) => ChoiceChip(
                      label: Text(method.label),
                      selected: _paymentMethod == method,
                      onSelected: (_) => setState(
                        () => _paymentMethod = method,
                      ),
                    ),
                  )
                  .toList(growable: false),
            ),
          ],
          const SizedBox(height: 24),
          TextField(
            controller: _memoController,
            decoration: const InputDecoration(
              labelText: 'MEMO',
            ),
          ),
          const SizedBox(height: 12),
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('DATE'),
            subtitle: Text(DateRangeUtils.monthDayLabel(_occurredAt)),
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
      initialDate: _occurredAt,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (selected == null) {
      return;
    }
    setState(() {
      _occurredAt = selected;
    });
  }

  Future<void> _save() async {
    final amount = int.tryParse(_amountController.text.replaceAll(',', ''));
    if (amount == null ||
        amount <= 0 ||
        (_budgetType == BudgetType.monthly && _selectedCategoryId == null) ||
        (_budgetType == BudgetType.annualSpecial && _specialCategory == null)) {
      setState(() {
        _errorText = _budgetType == BudgetType.monthly
            ? 'AMOUNT AND CATEGORY REQUIRED'
            : 'AMOUNT AND SPECIAL CATEGORY REQUIRED';
      });
      return;
    }

    await ref.read(transactionRepositoryProvider).createTransaction(
          SpendingTransaction(
            id: 0,
            amount: amount,
            type: TransactionType.expense,
            budgetType: _budgetType,
            specialCategory: _specialCategory,
            paymentMethod: _paymentMethod,
            prepaidAt: null,
            categoryId:
                _budgetType == BudgetType.monthly ? _selectedCategoryId : null,
            occurredAt: _occurredAt,
            memo: _memoController.text.trim().isEmpty
                ? null
                : _memoController.text.trim(),
            source: 'manual',
            linkedUpcomingExpenseId: null,
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
            deletedAt: null,
          ),
        );
    HapticFeedback.mediumImpact();
    if (mounted) {
      Navigator.of(context).pop();
    }
  }
}
