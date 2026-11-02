class Category {
  const Category({
    required this.id,
    required this.name,
    required this.icon,
    this.description,
    required this.colorToken,
    required this.sortOrder,
    required this.isActive,
    required this.isDefault,
    required this.createdAt,
    required this.updatedAt,
  });

  final int id;
  final String name;
  final String icon;
  final String? description;
  final String? colorToken;
  final int sortOrder;
  final bool isActive;
  final bool isDefault;
  final DateTime createdAt;
  final DateTime updatedAt;
}
