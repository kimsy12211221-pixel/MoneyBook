import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/types/enums.dart';
import '../../../domain/models/wishlist_item.dart';
import '../../../domain/providers/repositories_provider.dart';
import '../../../shared/widgets/app_scaffold.dart';
import '../../../shared/widgets/money_input.dart';
import '../../../shared/widgets/primary_button.dart';

class AddWishlistScreen extends ConsumerStatefulWidget {
  const AddWishlistScreen({super.key});

  @override
  ConsumerState<AddWishlistScreen> createState() => _AddWishlistScreenState();
}

class _AddWishlistScreenState extends ConsumerState<AddWishlistScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _urlController = TextEditingController();
  final TextEditingController _memoController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _urlController.dispose();
    _memoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      child: ListView(
        children: [
          Text('ADD WANT', style: Theme.of(context).textTheme.displayMedium),
          const SizedBox(height: 24),
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(labelText: 'NAME'),
          ),
          const SizedBox(height: 24),
          MoneyInput(controller: _priceController),
          const SizedBox(height: 24),
          TextField(
            controller: _urlController,
            decoration: const InputDecoration(labelText: 'URL'),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _memoController,
            decoration: const InputDecoration(labelText: 'MEMO'),
          ),
          const SizedBox(height: 24),
          const Text('COOLING FOR 72H'),
          const SizedBox(height: 24),
          PrimaryButton(label: 'SAVE', onPressed: _save),
        ],
      ),
    );
  }

  Future<void> _save() async {
    final price = int.tryParse(_priceController.text.replaceAll(',', ''));
    if (_nameController.text.trim().isEmpty || price == null || price <= 0) {
      return;
    }
    final now = DateTime.now();
    await ref.read(wishlistRepositoryProvider).createWishlistItem(
          WishlistItem(
            id: 0,
            name: _nameController.text.trim(),
            price: price,
            url: _urlController.text.trim().isEmpty
                ? null
                : _urlController.text.trim(),
            imagePath: null,
            memo: _memoController.text.trim().isEmpty
                ? null
                : _memoController.text.trim(),
            cooldownHours: 72,
            createdAt: now,
            cooldownUntil: now.add(const Duration(hours: 72)),
            status: WishlistStatus.cooling,
            waitingUntil: null,
            purchasedAt: null,
            releasedAt: null,
            linkedTransactionId: null,
            createdDailySafeSnapshot: 0,
            updatedAt: now,
          ),
        );
    if (mounted) {
      Navigator.of(context).pop();
    }
  }
}
