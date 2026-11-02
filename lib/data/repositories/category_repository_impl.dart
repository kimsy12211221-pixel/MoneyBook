import 'package:drift/drift.dart';

import '../../domain/models/category.dart';
import '../../domain/repositories/category_repository.dart';
import '../db/app_database.dart';
import '../db/default_categories.dart';
import '../mappers/category_mapper.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  const CategoryRepositoryImpl(this._database);

  final AppDatabase _database;

  @override
  Future<void> createCategory(Category category) async {
    await _database
        .into(_database.categoriesTable)
        .insert(category.toCompanion());
  }

  @override
  Future<Category?> getByName(String name) async {
    final query = _database.select(_database.categoriesTable)
      ..where((tbl) => tbl.name.equals(name));
    final row = await query.getSingleOrNull();
    return row == null
        ? null
        : Category(
            id: row.id,
            name: row.name,
            icon: row.icon,
            description: row.description,
            colorToken: row.colorToken,
            sortOrder: row.sortOrder,
            isActive: row.isActive,
            isDefault: row.isDefault,
            createdAt: row.createdAt,
            updatedAt: row.updatedAt,
          );
  }

  @override
  Future<List<Category>> getDefaultCategories() async {
    final now = DateTime.now();
    return defaultCategories
        .map(
          (item) => Category(
            id: item.sortOrder + 1,
            name: item.name,
            icon: item.icon,
            description: item.description,
            colorToken: null,
            sortOrder: item.sortOrder,
            isActive: true,
            isDefault: true,
            createdAt: now,
            updatedAt: now,
          ),
        )
        .toList(growable: false);
  }

  @override
  Future<void> seedDefaultCategoriesIfNeeded() async {
    final existingRows =
        await _database.select(_database.categoriesTable).get();

    if (existingRows.isNotEmpty) {
      await _migrateLegacyCategories(existingRows);
      await _syncDefaultCategoryDescriptions();
      return;
    }

    final now = DateTime.now();
    await _database.batch((batch) {
      batch.insertAll(
        _database.categoriesTable,
        defaultCategories
            .map(
              (item) => CategoriesTableCompanion.insert(
                name: item.name,
                icon: Value(item.icon),
                description: Value(item.description),
                colorToken: const Value(null),
                sortOrder: item.sortOrder,
                isActive: const Value(true),
                isDefault: const Value(true),
                createdAt: now,
                updatedAt: now,
              ),
            )
            .toList(growable: false),
      );
    });
  }

  Future<void> _migrateLegacyCategories(
    List<CategoriesTableData> existingRows,
  ) async {
    await _mergeCategory(existingRows, 'FOOD', 'EAT');
    await _mergeCategory(existingRows, 'CAFE', 'EAT');
    await _mergeCategory(existingRows, 'HOME', 'LIFE');
    await _mergeCategory(existingRows, 'HEALTH', 'LIFE');

    final current = await _database.select(_database.categoriesTable).get();
    final existingNames = current.map((row) => row.name).toSet();
    final now = DateTime.now();
    final missing = defaultCategories
        .where((item) => !existingNames.contains(item.name))
        .map(
          (item) => CategoriesTableCompanion.insert(
            name: item.name,
            icon: Value(item.icon),
            description: Value(item.description),
            colorToken: const Value(null),
            sortOrder: item.sortOrder,
            isActive: const Value(true),
            isDefault: const Value(true),
            createdAt: now,
            updatedAt: now,
          ),
        )
        .toList(growable: false);
    if (missing.isNotEmpty) {
      await _database.batch(
        (batch) => batch.insertAll(_database.categoriesTable, missing),
      );
    }
  }

  Future<void> _syncDefaultCategoryDescriptions() async {
    final now = DateTime.now();
    await _database.batch((batch) {
      for (final category in defaultCategories) {
        batch.update(
          _database.categoriesTable,
          CategoriesTableCompanion(
            description: Value(category.description),
            updatedAt: Value(now),
          ),
          where: (table) =>
              table.name.equals(category.name) & table.description.isNull(),
        );
      }
    });
  }

  Future<void> _mergeCategory(
    List<CategoriesTableData> existingRows,
    String legacyName,
    String targetName,
  ) async {
    final legacy = existingRows.cast<CategoriesTableData?>().firstWhere(
          (row) => row?.name == legacyName,
          orElse: () => null,
        );
    if (legacy == null) {
      return;
    }
    final target = await (_database.select(_database.categoriesTable)
          ..where((tbl) => tbl.name.equals(targetName)))
        .getSingleOrNull();
    if (target == null) {
      await (_database.update(_database.categoriesTable)
            ..where((tbl) => tbl.id.equals(legacy.id)))
          .write(CategoriesTableCompanion(name: Value(targetName)));
      return;
    }
    await (_database.update(_database.transactionsTable)
          ..where((tbl) => tbl.categoryId.equals(legacy.id)))
        .write(TransactionsTableCompanion(categoryId: Value(target.id)));
    await (_database.update(_database.upcomingExpensesTable)
          ..where((tbl) => tbl.categoryId.equals(legacy.id)))
        .write(UpcomingExpensesTableCompanion(categoryId: Value(target.id)));
    await (_database.delete(_database.categoriesTable)
          ..where((tbl) => tbl.id.equals(legacy.id)))
        .go();
  }

  @override
  Future<void> updateCategory(Category category) async {
    await _database
        .update(_database.categoriesTable)
        .replace(category.toCompanion());
  }

  @override
  Stream<List<Category>> watchActiveCategories() {
    final query = _database.select(_database.categoriesTable)
      ..where((tbl) => tbl.isActive.equals(true))
      ..orderBy([(tbl) => OrderingTerm.asc(tbl.sortOrder)]);

    return _mapRows(query.watch());
  }

  @override
  Stream<List<Category>> watchAllCategories() {
    final query = _database.select(_database.categoriesTable)
      ..orderBy([(tbl) => OrderingTerm.asc(tbl.sortOrder)]);

    return _mapRows(query.watch());
  }

  Stream<List<Category>> _mapRows(Stream<List<CategoriesTableData>> source) {
    return source.map(
      (rows) => rows
          .map(
            (row) => Category(
              id: row.id,
              name: row.name,
              icon: row.icon,
              description: row.description,
              colorToken: row.colorToken,
              sortOrder: row.sortOrder,
              isActive: row.isActive,
              isDefault: row.isDefault,
              createdAt: row.createdAt,
              updatedAt: row.updatedAt,
            ),
          )
          .toList(growable: false),
    );
  }
}
