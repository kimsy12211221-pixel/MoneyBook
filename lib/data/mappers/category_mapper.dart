import 'package:drift/drift.dart';

import '../../domain/models/category.dart';
import '../db/app_database.dart';

extension CategoryMapper on Category {
  CategoriesTableCompanion toCompanion() {
    return CategoriesTableCompanion(
      id: id == 0 ? const Value.absent() : Value(id),
      name: Value(name),
      icon: Value(icon),
      description: Value(description),
      colorToken: Value(colorToken),
      sortOrder: Value(sortOrder),
      isActive: Value(isActive),
      isDefault: Value(isDefault),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }
}
