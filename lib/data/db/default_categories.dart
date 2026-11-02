final defaultCategories = <CategorySeed>[
  CategorySeed(
    name: 'DATE',
    icon: 'favorite',
    sortOrder: 0,
    description: '여자친구와 함께 쓴 데이트 비용',
  ),
  CategorySeed(
    name: 'EAT',
    icon: 'restaurant',
    sortOrder: 1,
    description: '혼자 쓴 식사·카페·간식·배달',
  ),
  CategorySeed(
    name: 'SHOP',
    icon: 'shopping_bag',
    sortOrder: 2,
    description: '의류·잡화·온라인쇼핑',
  ),
  CategorySeed(
    name: 'BEAUTY',
    icon: 'face',
    sortOrder: 3,
    description: '화장품·미용',
  ),
  CategorySeed(
    name: 'MOVE',
    icon: 'directions_car',
    sortOrder: 4,
    description: '교통·주유·주차·택시',
  ),
  CategorySeed(
    name: 'FUN',
    icon: 'sports_esports',
    sortOrder: 5,
    description: '취미·문화·개인 여가',
  ),
  CategorySeed(
    name: 'LIFE',
    icon: 'home',
    sortOrder: 6,
    description: '생활용품·병원·약 등 생활 유지비',
  ),
  CategorySeed(
    name: 'ETC',
    icon: 'more_horiz',
    sortOrder: 7,
    description: '그 외',
  ),
];

class CategorySeed {
  const CategorySeed({
    required this.name,
    required this.icon,
    required this.sortOrder,
    required this.description,
  });

  final String name;
  final String icon;
  final int sortOrder;
  final String description;
}
