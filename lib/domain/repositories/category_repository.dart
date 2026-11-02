import '../models/category.dart';

abstract class CategoryRepository {
  Stream<List<Category>> watchActiveCategories();
  Stream<List<Category>> watchAllCategories();
  Future<List<Category>> getDefaultCategories();
  Future<void> seedDefaultCategoriesIfNeeded();
  Future<void> createCategory(Category category);
  Future<Category?> getByName(String name);
  Future<void> updateCategory(Category category);
}
