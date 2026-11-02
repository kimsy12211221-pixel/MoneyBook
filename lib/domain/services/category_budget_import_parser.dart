class ParsedBudgetRow {
  const ParsedBudgetRow({required this.categoryName, required this.amount});

  final String categoryName;
  final int amount;
}

class ParsedSpendRow {
  const ParsedSpendRow({
    required this.categoryName,
    required this.memo,
    required this.amount,
  });

  final String categoryName;
  final String memo;
  final int amount;
}

class CategoryBudgetImportParser {
  const CategoryBudgetImportParser();

  List<ParsedBudgetRow> parseBudgetTable(String text) {
    final rows = <ParsedBudgetRow>[];
    for (final rawLine in text.split(RegExp(r'\r?\n'))) {
      final line = rawLine.trim();
      if (!line.contains('|')) {
        continue;
      }
      final cells = line
          .split('|')
          .map((cell) => cell.trim())
          .where((cell) => cell.isNotEmpty)
          .toList(growable: false);
      if (cells.length < 2 || _isDivider(cells)) {
        continue;
      }
      final category = cells[0];
      if (_isHeader(category) || _isTotal(category)) {
        continue;
      }
      rows.removeWhere((row) => row.categoryName == category);
      rows.add(
        ParsedBudgetRow(
          categoryName: category,
          amount: parseAmount(cells[1]),
        ),
      );
    }
    return rows;
  }

  List<ParsedSpendRow> parseTodaySpend(String text) {
    final rows = <ParsedSpendRow>[];
    String? currentCategory;
    for (final rawLine in text.split(RegExp(r'\r?\n'))) {
      final line = rawLine.trim();
      if (line.isEmpty) {
        continue;
      }
      final isBullet = line.startsWith('-') || line.startsWith('*');
      if (!isBullet) {
        currentCategory = line.replaceFirst(RegExp(r'^#+\s*'), '').trim();
        continue;
      }
      if (currentCategory == null || currentCategory.isEmpty) {
        throw const FormatException('거래 카테고리가 없습니다.');
      }
      final content = line.substring(1).trim();
      final separator = content.lastIndexOf('|');
      if (separator <= 0 || separator == content.length - 1) {
        throw FormatException('거래 형식 오류: $line');
      }
      final memo = content.substring(0, separator).trim();
      final amountText = content.substring(separator + 1).trim();
      if (memo.isEmpty) {
        throw FormatException('거래 메모가 없습니다: $line');
      }
      rows.add(
        ParsedSpendRow(
          categoryName: currentCategory,
          memo: memo,
          amount: parseAmount(amountText),
        ),
      );
    }
    return rows;
  }

  int parseAmount(String value) {
    var normalized = value.trim().replaceAll(',', '').replaceAll(' ', '');
    if (normalized.endsWith('원')) {
      normalized = normalized.substring(0, normalized.length - 1);
    }
    final multiplier = normalized.endsWith('만')
        ? 10000
        : normalized.endsWith('천')
            ? 1000
            : 1;
    if (multiplier != 1) {
      normalized = normalized.substring(0, normalized.length - 1);
    }
    final number = double.tryParse(normalized);
    if (number == null || number <= 0) {
      throw FormatException('금액을 해석할 수 없습니다: $value');
    }
    return (number * multiplier).round();
  }

  bool _isDivider(List<String> cells) {
    return cells.every((cell) => RegExp(r'^[-:]+$').hasMatch(cell));
  }

  bool _isHeader(String value) {
    final normalized = value.toLowerCase();
    return normalized.contains('카테고리') || normalized == 'category';
  }

  bool _isTotal(String value) {
    final normalized = value.toLowerCase();
    return normalized == '합계' || normalized == 'total';
  }
}
