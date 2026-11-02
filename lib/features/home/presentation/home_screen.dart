import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/platform/budget_widget_sync.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/theme_extensions.dart';
import '../../../core/utils/currency_formatter.dart';
import '../../../core/utils/date_range_utils.dart';
import '../../../domain/providers/budget_provider.dart';
import '../../../domain/providers/annual_special_provider.dart';
import '../../../domain/providers/current_date_provider.dart';
import '../../../domain/providers/safe_to_spend_provider.dart';
import '../../../domain/providers/widget_settings_provider.dart';
import '../../../shared/widgets/app_divider.dart';
import '../../../shared/widgets/app_scaffold.dart';
import '../../../shared/widgets/hero_amount.dart';
import '../../../shared/widgets/meta_label.dart';
import '../../../shared/widgets/primary_button.dart';
import '../../transactions/presentation/add_transaction_sheet.dart';
import '../../settings/presentation/category_budget_import_screen.dart';
import '../../annual_special/presentation/annual_special_detail_screen.dart';
import 'widgets/period_switcher.dart';
import 'widgets/safe_summary_row.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen>
    with WidgetsBindingObserver {
  SpendingPeriod _selectedPeriod = SpendingPeriod.today;
  late DateTime _lastCreditDate;
  Timer? _creditRefreshTimer;

  @override
  void initState() {
    super.initState();
    _lastCreditDate = _dateOnly(DateTime.now());
    WidgetsBinding.instance.addObserver(this);
    // A foreground app can remain open across midnight without any database
    // event, so check for the date boundary while the screen is alive.
    _creditRefreshTimer = Timer.periodic(
      const Duration(minutes: 1),
      (_) => _refreshCreditForCurrentDay(),
    );
  }

  @override
  void dispose() {
    _creditRefreshTimer?.cancel();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _refreshCreditForCurrentDay(force: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final spacing = Theme.of(context).extension<AppSpacing>()!;
    final colors = Theme.of(context).extension<AppColorTokens>()!;
    final currentBudget = ref.watch(currentMonthBudgetAmountProvider);
    final snapshot = ref.watch(safeToSpendSnapshotProvider).valueOrNull;
    final annualSnapshot = ref.watch(annualSpecialSnapshotProvider).valueOrNull;
    final widgetStyle = ref.watch(budgetWidgetStyleProvider).valueOrNull;
    final amount = switch (_selectedPeriod) {
          SpendingPeriod.today => snapshot?.creditBalance,
          SpendingPeriod.week => snapshot?.weeklyCreditBalance,
          SpendingPeriod.month => snapshot?.monthlyAvailable,
        } ??
        0;
    final isCreditDebt = amount < 0;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      BudgetWidgetSync.update(
        budget: currentBudget ?? 0,
        spent: snapshot?.spentThisMonth ?? 0,
        creditBalance: snapshot?.creditBalance ?? 0,
        dailyCredit: snapshot?.dailyCredit ?? 0,
        monthlyAvailable: snapshot?.monthlyAvailable ?? 0,
        style: widgetStyle?.key,
      );
    });

    return AppScaffold(
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: spacing.sm),
        child: FloatingActionButton.extended(
          backgroundColor: colors.accent,
          foregroundColor: Colors.black,
          onPressed: () async {
            await Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (_) => const AddTransactionSheet(),
              ),
            );
            HapticFeedback.selectionClick();
          },
          label: const Text('+ ADD'),
        ),
      ),
      child: ListView(
        children: [
          SizedBox(height: spacing.md),
          MetaLabel(DateRangeUtils.shortDateLabel(DateTime.now())),
          SizedBox(height: spacing.xl),
          Text(
            '소비\n크레딧',
            style: Theme.of(context).textTheme.displayMedium,
          ),
          SizedBox(height: spacing.md),
          HeroAmount(
            amount: CurrencyFormatter.formatKrw(amount),
            caption: isCreditDebt
                ? 'CREDIT DEBT ${CurrencyFormatter.compactKrw(amount.abs())}'
                : _creditCaption(_selectedPeriod),
            isOverBudget: isCreditDebt,
          ),
          SizedBox(height: spacing.xl),
          PeriodSwitcher(
            selectedPeriod: _selectedPeriod,
            onChanged: (period) {
              setState(() {
                _selectedPeriod = period;
              });
            },
          ),
          SizedBox(height: spacing.lg),
          const AppDivider(),
          SizedBox(height: spacing.md),
          _BudgetLedgerRow(
            eyebrow: DateRangeUtils.yearMonthKey(DateTime.now()),
            title: 'MONTHLY BUDGET',
            amount: currentBudget == null
                ? 'NOT SET'
                : '${CurrencyFormatter.compactKrw(snapshot?.spentThisMonth ?? 0)} / ${CurrencyFormatter.compactKrw(currentBudget)}',
            detail:
                'TODAY ${CurrencyFormatter.compactKrw(snapshot?.creditBalance ?? 0)} CREDIT',
          ),
          SizedBox(height: spacing.md),
          const AppDivider(),
          SizedBox(height: spacing.md),
          _BudgetLedgerRow(
            eyebrow: '${DateTime.now().year}',
            title: 'ANNUAL SPECIAL',
            amount: annualSnapshot == null
                ? 'NOT SET'
                : '${CurrencyFormatter.compactKrw(annualSnapshot.spentAmount)} / ${CurrencyFormatter.compactKrw(annualSnapshot.budgetAmount)}',
            detail: annualSnapshot == null
                ? 'SET BUDGET IN ME'
                : 'LEFT ${CurrencyFormatter.compactKrw(annualSnapshot.remainingAmount)}',
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (_) => const AnnualSpecialDetailScreen(),
              ),
            ),
          ),
          SizedBox(height: spacing.md),
          const AppDivider(),
          SizedBox(height: spacing.md),
          SafeSummaryRow(
            leftLabel:
                'TODAY +${CurrencyFormatter.compactKrw(snapshot?.dailyCredit ?? 0)}',
            rightLabel:
                'MONTH ${CurrencyFormatter.compactKrw(snapshot?.spentThisMonth ?? 0)} SPENT',
          ),
          SizedBox(height: spacing.md),
          const AppDivider(),
          SizedBox(height: spacing.lg),
          PrimaryButton(
            label: 'BULK INPUT',
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (_) => const CategoryBudgetImportScreen(),
              ),
            ),
          ),
          SizedBox(height: spacing.xxl),
          Text(
            currentBudget == null
                ? '월 예산을 정하면 매일 크레딧이 충전돼요'
                : '안 쓴 크레딧은 계속 누적돼요',
            style: Theme.of(context).textTheme.labelSmall,
          ),
        ],
      ),
    );
  }

  String _creditCaption(SpendingPeriod period) {
    return switch (period) {
      SpendingPeriod.today => 'TODAY CREDIT',
      SpendingPeriod.week => 'WEEK CREDIT',
      SpendingPeriod.month => 'MONTH LEFT',
    };
  }

  void _refreshCreditForCurrentDay({bool force = false}) {
    final today = _dateOnly(DateTime.now());
    if (!force && today == _lastCreditDate) {
      return;
    }
    _lastCreditDate = today;
    ref.invalidate(currentDateProvider);
  }

  DateTime _dateOnly(DateTime value) =>
      DateTime(value.year, value.month, value.day);
}

class _BudgetLedgerRow extends StatelessWidget {
  const _BudgetLedgerRow({
    required this.eyebrow,
    required this.title,
    required this.amount,
    required this.detail,
    this.onTap,
  });

  final String eyebrow;
  final String title;
  final String amount;
  final String detail;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final spacing = Theme.of(context).extension<AppSpacing>()!;
    final content = Padding(
      padding: EdgeInsets.symmetric(vertical: spacing.xs),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MetaLabel(eyebrow),
                SizedBox(height: spacing.xs),
                Text(title, style: Theme.of(context).textTheme.titleMedium),
                SizedBox(height: spacing.xs),
                MetaLabel(detail),
              ],
            ),
          ),
          SizedBox(width: spacing.md),
          Text(amount, style: Theme.of(context).textTheme.titleMedium),
        ],
      ),
    );
    return onTap == null ? content : InkWell(onTap: onTap, child: content);
  }
}
