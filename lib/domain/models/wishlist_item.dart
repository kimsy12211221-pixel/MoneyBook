import '../../core/types/enums.dart';

class WishlistItem {
  const WishlistItem({
    required this.id,
    required this.name,
    required this.price,
    required this.url,
    required this.imagePath,
    required this.memo,
    required this.cooldownHours,
    required this.createdAt,
    required this.cooldownUntil,
    required this.status,
    required this.waitingUntil,
    required this.purchasedAt,
    required this.releasedAt,
    required this.linkedTransactionId,
    required this.createdDailySafeSnapshot,
    required this.updatedAt,
  });

  final int id;
  final String name;
  final int price;
  final String? url;
  final String? imagePath;
  final String? memo;
  final int cooldownHours;
  final DateTime createdAt;
  final DateTime cooldownUntil;
  final WishlistStatus status;
  final DateTime? waitingUntil;
  final DateTime? purchasedAt;
  final DateTime? releasedAt;
  final int? linkedTransactionId;
  final int createdDailySafeSnapshot;
  final DateTime updatedAt;
}
