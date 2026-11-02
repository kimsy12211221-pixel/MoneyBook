enum BudgetWidgetStyle {
  classic('classic', 'CLASSIC', 'CLEAN CARD'),
  wave('wave', 'SOFT WAVE', 'BOTTOM GRAPHIC'),
  garden('garden', 'GARDEN', 'SPROUT + STATUS'),
  runway('runway', 'RUNWAY', 'PROGRESS TRACK');

  const BudgetWidgetStyle(this.key, this.label, this.meta);

  final String key;
  final String label;
  final String meta;

  static BudgetWidgetStyle fromKey(String? key) {
    return BudgetWidgetStyle.values.firstWhere(
      (style) => style.key == key,
      orElse: () => BudgetWidgetStyle.wave,
    );
  }
}
