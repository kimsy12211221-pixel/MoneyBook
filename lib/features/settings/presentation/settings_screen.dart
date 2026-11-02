import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/app_settings_keys.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../domain/providers/app_launch_provider.dart';
import '../../../domain/providers/maintenance_provider.dart';
import '../../../domain/providers/repositories_provider.dart';
import '../../../shared/widgets/app_divider.dart';
import '../../../shared/widgets/app_scaffold.dart';
import '../../../shared/widgets/meta_label.dart';
import '../../../shared/widgets/section_header.dart';
import '../../reports/presentation/monthly_summary_screen.dart';
import 'budget_management_screen.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final spacing = Theme.of(context).extension<AppSpacing>()!;
    return AppScaffold(
      child: ListView(
        children: [
          SizedBox(height: spacing.lg),
          const SectionHeader('ME'),
          SizedBox(height: spacing.xl),
          _SettingsItem(
            title: 'BUDGET',
            meta: 'MANAGE',
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (_) => const BudgetManagementScreen(),
              ),
            ),
          ),
          SizedBox(height: spacing.md),
          const AppDivider(),
          SizedBox(height: spacing.md),
          _SettingsItem(
            title: 'EXPENSE SUMMARY',
            meta: 'VIEW',
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (_) => const MonthlySummaryScreen(),
              ),
            ),
          ),
          SizedBox(height: spacing.md),
          const AppDivider(),
          SizedBox(height: spacing.md),
          _SettingsItem(
            title: 'DATA EXPORT',
            meta: 'JSON',
            onTap: () => _exportData(context, ref),
          ),
          SizedBox(height: spacing.md),
          const AppDivider(),
          SizedBox(height: spacing.md),
          _SettingsItem(
            title: 'RESET DATA',
            meta: 'DANGER',
            onTap: () => _resetData(context, ref),
          ),
        ],
      ),
    );
  }

  Future<void> _exportData(BuildContext context, WidgetRef ref) async {
    final exportScope = await showDialog<_ExportScope>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('DATA EXPORT'),
        content: const Text(
          'FULL BACKUP includes every saved record. Monthly export includes only transactions from the selected month.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('CANCEL'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(_ExportScope.month),
            child: const Text('SELECT MONTH'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(_ExportScope.full),
            child: const Text('FULL BACKUP'),
          ),
        ],
      ),
    );
    if (exportScope == null || !context.mounted) {
      return;
    }

    try {
      String savedUri;
      String fileLabel;
      if (exportScope == _ExportScope.full) {
        savedUri = await ref.read(maintenanceControllerProvider).exportJson();
        fileLabel = 'FULL BACKUP';
      } else {
        final today = DateTime.now();
        final selectedDate = await showDialog<DateTime>(
          context: context,
          builder: (_) => _ExportMonthDialog(
            initialMonth: DateTime(today.year, today.month),
          ),
        );
        if (selectedDate == null || !context.mounted) {
          return;
        }
        fileLabel =
            '${selectedDate.year}-${selectedDate.month.toString().padLeft(2, '0')} JSON';
        savedUri = await ref
            .read(maintenanceControllerProvider)
            .exportMonthJson(selectedDate);
      }

      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('$fileLabel SAVED TO DOWNLOADS')),
      );
      debugPrint('Saved export: $savedUri');
    } catch (error, stackTrace) {
      debugPrint('JSON export failed: $error');
      debugPrintStack(stackTrace: stackTrace);
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('EXPORT FAILED: $error')),
      );
    }
  }

  Future<void> _resetData(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('RESET DATA'),
          content: const Text('THIS DELETES ALL LOCAL DATA.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('CANCEL'),
            ),
            FilledButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('RESET'),
            ),
          ],
        );
      },
    );
    if (confirmed != true) {
      return;
    }

    await ref.read(maintenanceControllerProvider).resetData();
    await ref
        .read(appSettingsRepositoryProvider)
        .setSetting(AppSettingsKeys.setupCompleted, 'false');
    ref.invalidate(appLaunchProvider);
  }
}

enum _ExportScope { full, month }

class _SettingsItem extends StatelessWidget {
  const _SettingsItem({
    required this.title,
    required this.meta,
    this.onTap,
  });

  final String title;
  final String meta;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Expanded(
            child: Text(title, style: Theme.of(context).textTheme.bodyLarge),
          ),
          MetaLabel(meta),
        ],
      ),
    );
  }
}

class _ExportMonthDialog extends StatefulWidget {
  const _ExportMonthDialog({required this.initialMonth});

  final DateTime initialMonth;

  @override
  State<_ExportMonthDialog> createState() => _ExportMonthDialogState();
}

class _ExportMonthDialogState extends State<_ExportMonthDialog> {
  late int _year = widget.initialMonth.year;

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final isCurrentYear = _year == now.year;
    return AlertDialog(
      title: const Text('SELECT EXPORT MONTH'),
      content: SizedBox(
        width: 300,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                IconButton(
                  onPressed:
                      _year <= 2020 ? null : () => setState(() => _year -= 1),
                  icon: const Icon(Icons.chevron_left),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      '$_year',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                ),
                IconButton(
                  onPressed:
                      isCurrentYear ? null : () => setState(() => _year += 1),
                  icon: const Icon(Icons.chevron_right),
                ),
              ],
            ),
            const SizedBox(height: 8),
            GridView.count(
              crossAxisCount: 4,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 1.45,
              children: List.generate(12, (index) {
                final month = index + 1;
                final isFuture = _year == now.year && month > now.month;
                return OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    minimumSize: Size.zero,
                    padding: EdgeInsets.zero,
                  ),
                  onPressed: isFuture
                      ? null
                      : () => Navigator.of(context).pop(
                            DateTime(_year, month),
                          ),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(month.toString().padLeft(2, '0')),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('CANCEL'),
        ),
      ],
    );
  }
}
