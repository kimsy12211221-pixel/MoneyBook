# Annual Special Budget

## Purpose

`ANNUAL_SPECIAL` is a separate budget source for irregular, planned spending.
It never reduces the monthly budget, daily credit balance, weekly credit balance,
or monthly category allocation.

## Budget Types

| Type | Applies to | Required fields |
| --- | --- | --- |
| `MONTHLY` | Monthly budget and daily credit | Base category |
| `ANNUAL_SPECIAL` | Annual special budget | Special category |

## Special Categories

`TRAVEL`, `GIFT`, `EVENT`, `MAINTENANCE`, `MEDICAL`, `OTHER`

Annual-special transactions are classified only by their special category. For
example, a replacement bra can be recorded as `ANNUAL_SPECIAL + OTHER`.

## Calculations

- Monthly credit calculations use only `MONTHLY` expense transactions.
- Category budget remaining values use only `MONTHLY` expense transactions.
- Annual special remaining is: `annual budget for year - annual-special expenses in year`.
- Annual special has no daily credit accrual and resets at the calendar-year boundary.

## Migration And Backup

- Existing transactions migrate to `MONTHLY` with no special category.
- JSON export includes `annualSpecialBudgets` and each transaction's
  `budgetType` and `specialCategory`.
