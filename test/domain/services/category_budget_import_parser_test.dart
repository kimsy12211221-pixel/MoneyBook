import 'package:flutter_test/flutter_test.dart';

import 'package:personal_spending_app/domain/services/category_budget_import_parser.dart';

void main() {
  const parser = CategoryBudgetImportParser();

  test('parses Korean monthly budget table and ignores total row', () {
    final rows = parser.parseBudgetTable('''
| 카테고리 | 월 예산 |
| --- | --- |
| DATE | 40만 |
| EAT | 20,000원 |
| 합계 | 60만 |
''');

    expect(rows.map((row) => row.categoryName), ['DATE', 'EAT']);
    expect(rows.map((row) => row.amount), [400000, 20000]);
  });

  test('parses category blocks into today spend rows', () {
    final rows = parser.parseTodaySpend('''
DATE
- 점심|60000원
- 영화|1.5만

SHOP
- 셔츠|39,000원
''');

    expect(rows.length, 3);
    expect(rows[0].categoryName, 'DATE');
    expect(rows[1].amount, 15000);
    expect(rows[2].categoryName, 'SHOP');
  });
}
