import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/types/enums.dart';
import '../../../core/utils/currency_formatter.dart';
import '../../../domain/models/transaction.dart';
import '../../../domain/models/wishlist_item.dart';
import '../../../domain/providers/repositories_provider.dart';
import '../../../domain/providers/safe_to_spend_provider.dart';
import '../../../domain/providers/wishlist_provider.dart';
import '../../../shared/widgets/app_scaffold.dart';
import '../../../shared/widgets/hero_amount.dart';
import '../../../shared/widgets/meta_label.dart';
import '../../../shared/widgets/primary_button.dart';
import '../../../shared/widgets/secondary_button.dart';
import 'widgets/cooldown_badge.dart';
import 'widgets/impact_meter.dart';

class WishlistDetailScreen extends ConsumerWidget {
  const WishlistDetailScreen({
    required this.item,
    super.key,
  });

  final WishlistItem item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final service = ref.watch(wishlistCooldownServiceProvider);
    final now = DateTime.now();
    final status = service.resolveStatus(item, now);
    final safeSnapshot = ref.watch(safeToSpendSnapshotProvider).valueOrNull;
    final dailySafe = safeSnapshot?.dailySafe ?? 0;
    final impactDays =
        dailySafe <= 0 ? null : (item.price / dailySafe).toStringAsFixed(1);
    final postPurchase = safeSnapshot == null
        ? 0
        : ref.read(safeToSpendServiceProvider).calculatePostPurchaseDailySafe(
              monthlyAvailable: safeSnapshot.monthlyAvailable,
              purchasePrice: item.price,
              remainingDaysInMonth: safeSnapshot.remainingDaysInMonth,
            );

    return AppScaffold(
      child: ListView(
        children: [
          Text(item.name, style: Theme.of(context).textTheme.displayMedium),
          const SizedBox(height: 16),
          HeroAmount(amount: CurrencyFormatter.formatKrw(item.price)),
          const SizedBox(height: 16),
          CooldownBadge(_statusLabel(status, service.remainingTime(item, now))),
          const SizedBox(height: 24),
          ImpactMeter(
            primaryText: impactDays == null
                ? 'NO DAILY SAFE LEFT'
                : '$impactDays DAYS OF SPENDING',
            secondaryText:
                'IF YOU BUY THIS, DAILY SAFE -> ${CurrencyFormatter.compactKrw(postPurchase)}',
          ),
          const SizedBox(height: 24),
          if (status == WishlistStatus.ready) ...[
            PrimaryButton(
              label: 'BUY',
              onPressed: () => _buy(context, ref),
            ),
            const SizedBox(height: 12),
            SecondaryButton(
              label: 'WAIT 7 DAYS',
              onPressed: () => _waitMore(context, ref, const Duration(days: 7)),
            ),
            const SizedBox(height: 12),
            SecondaryButton(
              label: 'LET IT GO',
              onPressed: () => _letGo(context, ref),
            ),
          ] else ...[
            const MetaLabel('ACTIONS UNLOCK WHEN READY'),
          ],
        ],
      ),
    );
  }

  String _statusLabel(WishlistStatus status, Duration remaining) {
    switch (status) {
      case WishlistStatus.cooling:
        return '${remaining.inHours}H LEFT';
      case WishlistStatus.ready:
        return 'READY';
      case WishlistStatus.waiting:
        return 'WAITING ${remaining.inHours}H';
      case WishlistStatus.purchased:
        return 'PURCHASED';
      case WishlistStatus.letGo:
        return 'LET GO';
    }
  }

  Future<void> _buy(BuildContext context, WidgetRef ref) async {
    final now = DateTime.now();
    await ref.read(transactionRepositoryProvider).createTransaction(
          SpendingTransaction(
            id: 0,
            amount: item.price,
            type: TransactionType.expense,
            budgetType: BudgetType.monthly,
            specialCategory: null,
            categoryId: null,
            occurredAt: now,
            memo: item.name,
            source: 'manual',
            linkedUpcomingExpenseId: null,
            createdAt: now,
            updatedAt: now,
            deletedAt: null,
          ),
        );
    await ref.read(wishlistRepositoryProvider).markPurchased(item.id);
    HapticFeedback.mediumImpact();
    if (context.mounted) {
      Navigator.of(context).pop();
    }
  }

  Future<void> _waitMore(
      BuildContext context, WidgetRef ref, Duration duration) async {
    await ref.read(wishlistRepositoryProvider).waitMore(item.id, duration);
    if (context.mounted) {
      Navigator.of(context).pop();
    }
  }

  Future<void> _letGo(BuildContext context, WidgetRef ref) async {
    await ref.read(wishlistRepositoryProvider).markLetGo(item.id);
    HapticFeedback.heavyImpact();
    if (context.mounted) {
      Navigator.of(context).pop();
    }
  }
}
