import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_spacing.dart';
import '../../../core/types/enums.dart';
import '../../../core/utils/currency_formatter.dart';
import '../../../domain/models/wishlist_item.dart';
import '../../../domain/providers/safe_to_spend_provider.dart';
import '../../../domain/providers/wishlist_provider.dart';
import '../../../domain/services/wishlist_cooldown_service.dart';
import '../../../shared/widgets/app_divider.dart';
import '../../../shared/widgets/app_scaffold.dart';
import '../../../shared/widgets/empty_state.dart';
import '../../../shared/widgets/meta_label.dart';
import '../../../shared/widgets/section_header.dart';
import 'add_wishlist_screen.dart';
import 'wishlist_detail_screen.dart';
import 'widgets/wishlist_row.dart';

class WishlistScreen extends ConsumerWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final spacing = Theme.of(context).extension<AppSpacing>()!;
    final buckets = ref.watch(wishlistBucketsProvider);
    final service = ref.watch(wishlistCooldownServiceProvider);
    final dailySafe =
        ref.watch(safeToSpendSnapshotProvider).valueOrNull?.dailySafe ?? 0;
    final notSpent = ref.watch(currentMonthNotSpentProvider);
    final items = <WishlistItem>[
      ...buckets.ready,
      ...buckets.cooling,
      ...buckets.waiting,
    ];

    return AppScaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute<void>(
              builder: (_) => const AddWishlistScreen(),
            ),
          );
        },
        label: const Text('+ WANT'),
      ),
      child: ListView(
        children: [
          SizedBox(height: spacing.lg),
          const SectionHeader('WANT'),
          SizedBox(height: spacing.sm),
          MetaLabel(
              '${buckets.cooling.length} COOLING · ${buckets.ready.length} READY'),
          SizedBox(height: spacing.xl),
          if (items.isEmpty)
            const EmptyState(title: 'WANT NOTHING.')
          else
            for (final item in items) ...[
              WishlistRow(
                name: item.name,
                price: CurrencyFormatter.formatKrw(item.price),
                status: _statusLabel(service, item),
                impact: dailySafe <= 0
                    ? 'NO DAILY SAFE LEFT'
                    : '${(item.price / dailySafe).toStringAsFixed(1)} DAYS OF SPENDING',
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (_) => WishlistDetailScreen(item: item),
                    ),
                  );
                },
              ),
              SizedBox(height: spacing.md),
              const AppDivider(),
              SizedBox(height: spacing.md),
            ],
          SizedBox(height: spacing.xl),
          const MetaLabel('NOT SPENT THIS MONTH'),
          const SizedBox(height: 8),
          Text(
            CurrencyFormatter.formatKrw(notSpent),
            style: Theme.of(context).textTheme.displayMedium,
          ),
        ],
      ),
    );
  }

  String _statusLabel(WishlistCooldownService service, WishlistItem item) {
    final now = DateTime.now();
    final status = service.resolveStatus(item, now);
    final remaining = service.remainingTime(item, now).inHours;
    switch (status) {
      case WishlistStatus.cooling:
        return '$remaining H LEFT';
      case WishlistStatus.ready:
        return 'READY';
      case WishlistStatus.waiting:
        return 'WAITING';
      case WishlistStatus.purchased:
        return 'PURCHASED';
      case WishlistStatus.letGo:
        return 'LET GO';
    }
  }
}
