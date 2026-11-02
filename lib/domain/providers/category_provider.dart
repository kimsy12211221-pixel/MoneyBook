import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/category.dart';
import 'repositories_provider.dart';

final activeCategoriesProvider = StreamProvider<List<Category>>((ref) {
  return ref.watch(categoryRepositoryProvider).watchActiveCategories();
});

final allCategoriesProvider = StreamProvider<List<Category>>((ref) {
  return ref.watch(categoryRepositoryProvider).watchAllCategories();
});

final categoryNameMapProvider = Provider<Map<int, Category>>((ref) {
  final items =
      ref.watch(activeCategoriesProvider).valueOrNull ?? const <Category>[];
  return {
    for (final item in items) item.id: item,
  };
});
