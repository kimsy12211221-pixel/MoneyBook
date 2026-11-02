class WishlistEvent {
  const WishlistEvent({
    required this.id,
    required this.wishlistItemId,
    required this.eventType,
    required this.eventAt,
    required this.payloadJson,
  });

  final int id;
  final int wishlistItemId;
  final String eventType;
  final DateTime eventAt;
  final String? payloadJson;
}
