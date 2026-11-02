import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/utils/currency_formatter.dart';
import '../../../domain/providers/repositories_provider.dart';
import '../../../domain/services/category_budget_import_parser.dart';
import '../../../shared/widgets/app_scaffold.dart';
import '../../../shared/widgets/primary_button.dart';
import '../../../shared/widgets/section_header.dart';

class CategoryBudgetImportScreen extends ConsumerStatefulWidget {
  const CategoryBudgetImportScreen({super.key});

  @override
  ConsumerState<CategoryBudgetImportScreen> createState() =>
      _CategoryBudgetImportScreenState();
}

class _CategoryBudgetImportScreenState
    extends ConsumerState<CategoryBudgetImportScreen> {
  final _budgetController = TextEditingController();
  final _spendController = TextEditingController();
  final _parser = const CategoryBudgetImportParser();
  String? _errorText;
  _ImportPreview? _preview;
  bool _isSaving = false;

  @override
  void dispose() {
    _budgetController.dispose();
    _spendController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      child: ListView(
        children: [
          const SizedBox(height: 24),
          const SectionHeader('BULK IMPORT'),
          const SizedBox(height: 12),
          const Text('예산표와 오늘 소비 내역을 붙여넣으면 한 번에 반영합니다. MONTHLY 전용입니다.'),
          const SizedBox(height: 24),
          TextField(
            controller: _budgetController,
            minLines: 5,
            maxLines: 10,
            decoration: const InputDecoration(
              labelText: 'MONTHLY CATEGORY BUDGET TABLE',
              hintText: '| CATEGORY | BUDGET |\n| DATE | 400000원 |',
              alignLabelWithHint: true,
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _spendController,
            minLines: 5,
            maxLines: 12,
            decoration: const InputDecoration(
              labelText: "TODAY'S SPEND",
              hintText: 'DATE\n- 점심|60000원\n- 영화|15000원',
              alignLabelWithHint: true,
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          if (_errorText != null)
            Text(
              _errorText!,
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
          if (_preview != null) ...[
            const SizedBox(height: 16),
            _PreviewCard(preview: _preview!),
          ],
          const SizedBox(height: 24),
          OutlinedButton(
            onPressed: _isSaving ? null : _previewInput,
            child: const Text('PREVIEW'),
          ),
          const SizedBox(height: 12),
          PrimaryButton(
            label: _isSaving ? 'IMPORTING...' : 'IMPORT ALL',
            onPressed: _isSaving ? null : _import,
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  void _previewInput() {
    try {
      final budgets = _parser.parseBudgetTable(_budgetController.text);
      final spends = _parser.parseTodaySpend(_spendController.text);
      if (budgets.isEmpty && spends.isEmpty) {
        throw const FormatException('가져올 데이터가 없습니다.');
      }
      setState(() {
        _errorText = null;
        _preview = _ImportPreview(budgets: budgets, spends: spends);
      });
    } on FormatException catch (error) {
      setState(() {
        _preview = null;
        _errorText = error.message;
      });
    }
  }

  Future<void> _import() async {
    try {
      setState(() {
        _isSaving = true;
        _errorText = null;
      });
      final result = await ref.read(categoryBudgetImportServiceProvider).import(
            budgetText: _budgetController.text,
            spendText: _spendController.text,
          );
      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            '예산 ${result.budgetCount}개, 소비 ${result.transactionCount}개 반영됨',
          ),
        ),
      );
      Navigator.of(context).pop();
    } on FormatException catch (error) {
      setState(() => _errorText = error.message);
    } finally {
      if (mounted) {
        setState(() => _isSaving = false);
      }
    }
  }
}

class _ImportPreview {
  const _ImportPreview({required this.budgets, required this.spends});

  final List<ParsedBudgetRow> budgets;
  final List<ParsedSpendRow> spends;
}

class _PreviewCard extends StatelessWidget {
  const _PreviewCard({required this.preview});

  final _ImportPreview preview;

  @override
  Widget build(BuildContext context) {
    final total = preview.budgets.fold<int>(0, (sum, row) => sum + row.amount);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('IMPORT PREVIEW'),
            const SizedBox(height: 8),
            Text(
                'BUDGETS ${preview.budgets.length} · ${CurrencyFormatter.formatKrw(total)}'),
            Text('TODAY SPENDS ${preview.spends.length}'),
          ],
        ),
      ),
    );
  }
}
