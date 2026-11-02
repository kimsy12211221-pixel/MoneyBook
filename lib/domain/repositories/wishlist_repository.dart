import '../models/wishlist_item.dart';

abstract class WishlistRepository {
  Future<void> createWishlistItem(WishlistItem item);
  Future<void> waitMore(int id, Duration duration);
  Future<void> markPurchased(int id, {int? linkedTransactionId});
  Future<void> markLetGo(int id);
  Stream<List<WishlistItem>> watchActiveWishlistItems();
  Stream<List<WishlistItem>> watchAllWishlistItems();
  Future<int> sumLetGoAmountForMonth(String yearMonth);
}
