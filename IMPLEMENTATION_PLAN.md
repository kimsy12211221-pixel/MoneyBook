# Personal Spending App Implementation Plan

`README.md`를 구현 지시서로 재구성한 문서다. 목적은 Codex가 기능 추가 시마다 설계 의도, 화면 우선순위, 데이터 구조, 구현 순서를 흔들리지 않게 따르도록 만드는 것이다.

기준 문서 작성일: 2026-08-30

## 1. Product North Star

핵심 질문은 하나다.

> 지금 내가 얼마까지 써도 되는가?

모든 기능은 아래 두 질문 중 하나에 직접 기여해야 한다.

1. 사용자가 지금 소비 가능한 금액을 더 정확하고 빠르게 판단하게 해주는가
2. 사용자가 충동구매를 즉시 결제로 넘기지 않고 잠시 멈추게 해주는가

위 두 질문과 직접 연결되지 않으면 MVP 우선순위를 낮춘다.

## 2. Build Rules For Codex

모든 기능은 아래 순서로 구현한다.

1. 화면의 visual hierarchy 정의
2. design token 연결
3. reusable UI component 우선 구축
4. domain/service 연결
5. interaction polish 추가
6. empty/error/edge case 처리

금지사항:

- 화면 구현 후 디자인을 나중에 덧입히는 방식
- widget 내부에 비즈니스 계산식 작성
- Material 기본 외형을 거의 그대로 노출하는 방식
- Home을 거래내역 대시보드처럼 만드는 구성
- Wishlist를 단순 북마크처럼 처리하는 UX

## 3. Delivery Scope

MVP 포함 범위:

- 초기 예산 설정
- Home safe-to-spend 화면
- 거래 추가/수정/삭제/목록
- 카테고리 관리
- Upcoming expenses
- Wishlist cooling flow
- Monthly summary
- 설정
- 로컬 데이터 저장
- JSON 전체 백업 및 선택 월 거래내역 내보내기

MVP 제외 범위:

- 로그인/회원 관리
- 서버 동기화
- 금융기관 연동
- OCR
- AI 자동 분류
- 다중 사용자/공유
- 투자 관리

## 4. Recommended Tech Decisions

필수 스택:

- Flutter latest stable
- Dart stable compatible
- Riverpod
- Drift + SQLite
- intl
- timezone 또는 local date utility layer
- go_router 또는 기본 Navigator 2 없이 단순 route 관리

권장 추가 패키지:

- `google_fonts`
- `flutter_animate` 또는 매우 얇은 커스텀 transition layer
- `freezed` + `json_serializable` if model ergonomics are needed
- `path_provider`
- `share_plus` for later export

## 5. Target Folder Structure

```text
lib/
  app/
    app.dart
    router.dart
    bootstrap.dart
  core/
    constants/
      app_constants.dart
      app_copy.dart
    types/
      enums.dart
      result.dart
    utils/
      currency_formatter.dart
      date_range_utils.dart
      number_utils.dart
    theme/
      app_theme.dart
      app_colors.dart
      app_typography.dart
      app_spacing.dart
      app_radius.dart
      theme_extensions.dart
    navigation/
      app_shell.dart
      app_bottom_nav.dart
  data/
    db/
      app_database.dart
      tables/
        budgets_table.dart
        transactions_table.dart
        categories_table.dart
        upcoming_expenses_table.dart
        wishlist_items_table.dart
        wishlist_events_table.dart
    mappers/
      transaction_mapper.dart
      budget_mapper.dart
      wishlist_mapper.dart
    repositories/
      budget_repository_impl.dart
      transaction_repository_impl.dart
      category_repository_impl.dart
      upcoming_expense_repository_impl.dart
      wishlist_repository_impl.dart
      report_repository_impl.dart
  domain/
    models/
      budget.dart
      transaction.dart
      category.dart
      upcoming_expense.dart
      wishlist_item.dart
      monthly_summary.dart
      safe_to_spend_snapshot.dart
    repositories/
      budget_repository.dart
      transaction_repository.dart
      category_repository.dart
      upcoming_expense_repository.dart
      wishlist_repository.dart
      report_repository.dart
    services/
      safe_to_spend_service.dart
      wishlist_cooldown_service.dart
      monthly_summary_service.dart
    providers/
      database_provider.dart
      repositories_provider.dart
      budget_provider.dart
      transaction_provider.dart
      category_provider.dart
      upcoming_expense_provider.dart
      wishlist_provider.dart
      safe_to_spend_provider.dart
      monthly_summary_provider.dart
  features/
    onboarding/
      presentation/
        onboarding_screen.dart
        monthly_budget_step.dart
        upcoming_expense_step.dart
        onboarding_actions.dart
    home/
      presentation/
        home_screen.dart
        widgets/
          home_hero.dart
          period_switcher.dart
          safe_summary_row.dart
          recent_transactions_section.dart
    transactions/
      presentation/
        transaction_log_screen.dart
        add_transaction_sheet.dart
        edit_transaction_screen.dart
        widgets/
          transaction_row.dart
          amount_keypad.dart
          category_picker.dart
    wishlist/
      presentation/
        wishlist_screen.dart
        add_wishlist_screen.dart
        wishlist_detail_screen.dart
        widgets/
          wishlist_row.dart
          cooldown_badge.dart
          impact_meter.dart
    upcoming/
      presentation/
        upcoming_expenses_screen.dart
        add_upcoming_expense_sheet.dart
    reports/
      presentation/
        monthly_summary_screen.dart
        widgets/
          summary_metric_block.dart
          summary_poster_card.dart
    settings/
      presentation/
        settings_screen.dart
        category_management_screen.dart
        appearance_screen.dart
  shared/
    widgets/
      app_scaffold.dart
      app_divider.dart
      hero_amount.dart
      meta_label.dart
      section_header.dart
      primary_button.dart
      secondary_button.dart
      money_input.dart
      empty_state.dart
      bottom_sheet_container.dart
      app_text_field.dart
```

### Folder Responsibility Rules

- `core/`: 앱 전역 공통 토큰, 포맷터, enum, navigation shell
- `data/`: Drift 테이블, DAO 성격 구현, repository implementation
- `domain/`: feature에 독립적인 모델/인터페이스/계산 서비스
- `features/`: 화면과 사용자 interaction
- `shared/widgets/`: 2개 이상 화면에서 재사용되는 UI

## 6. Database Schema

금액은 모두 `int`로 저장한다. 단위는 기본 KRW 원.

### 6.1 budgets

| column | type | notes |
|---|---|---|
| id | integer PK | single-row 사용 가능하지만 확장 위해 PK 유지 |
| monthlyBudget | integer | 이번 달 변동비 예산 |
| currencyCode | text | default `KRW` |
| effectiveMonth | text | `YYYY-MM` |
| createdAt | text | ISO local timestamp |
| updatedAt | text | ISO local timestamp |

용도:

- 월별 예산 스냅샷 보존
- 월 변경 시 새 row 생성 가능

### 6.2 categories

| column | type | notes |
|---|---|---|
| id | integer PK | |
| name | text | unique candidate |
| icon | text | icon key or asset name |
| colorToken | text | optional accent alias |
| sortOrder | integer | |
| isActive | integer | boolean 0/1 |
| isDefault | integer | boolean 0/1 |
| createdAt | text | |
| updatedAt | text | |

### 6.3 transactions

| column | type | notes |
|---|---|---|
| id | integer PK | |
| amount | integer | positive integer only |
| type | text | `expense`, `income` |
| categoryId | integer | FK categories.id nullable 허용 가능 |
| occurredAt | text | 실제 사용 시각 |
| memo | text | nullable |
| source | text | `manual`, `upcoming_converted` |
| linkedUpcomingExpenseId | integer | nullable |
| createdAt | text | |
| updatedAt | text | |
| deletedAt | text | nullable, soft delete optional |

인덱스:

- `idx_transactions_occurred_at`
- `idx_transactions_category_id`
- `idx_transactions_type_occurred_at`

### 6.4 upcoming_expenses

| column | type | notes |
|---|---|---|
| id | integer PK | |
| title | text | |
| amount | integer | |
| scheduledDate | text | local date `YYYY-MM-DD` |
| categoryId | integer | FK nullable |
| isRecurring | integer | boolean |
| recurrenceType | text | `none`, `monthly`, `weekly`, `custom` |
| recurrenceInterval | integer | optional |
| isPaid | integer | boolean |
| paidTransactionId | integer | nullable |
| note | text | nullable |
| createdAt | text | |
| updatedAt | text | |

인덱스:

- `idx_upcoming_scheduled_date`
- `idx_upcoming_is_paid`

### 6.5 wishlist_items

| column | type | notes |
|---|---|---|
| id | integer PK | |
| name | text | |
| price | integer | |
| url | text | nullable |
| imagePath | text | nullable |
| memo | text | nullable |
| cooldownHours | integer | default 72 |
| createdAt | text | |
| cooldownUntil | text | |
| status | text | `cooling`, `ready`, `waiting`, `purchased`, `let_go` |
| waitingUntil | text | nullable |
| purchasedAt | text | nullable |
| releasedAt | text | nullable |
| linkedTransactionId | integer | nullable |
| createdDailySafeSnapshot | integer | 추가 당시 daily safe |
| updatedAt | text | |

인덱스:

- `idx_wishlist_status`
- `idx_wishlist_cooldown_until`

### 6.6 wishlist_events

상태 변화 추적용. Monthly reflection 계산에 유리하다.

| column | type | notes |
|---|---|---|
| id | integer PK | |
| wishlistItemId | integer | FK wishlist_items.id |
| eventType | text | `created`, `ready`, `wait_more`, `purchased`, `let_go` |
| eventAt | text | |
| payloadJson | text | nullable |

### 6.7 app_settings

| column | type | notes |
|---|---|---|
| key | text PK | |
| value | text | |
| updatedAt | text | |

저장 예시:

- `default_currency`
- `default_wishlist_cooldown_hours`
- `theme_mode`
- `accent_color`

## 7. Domain Models

최소 모델:

- `Budget`
- `Transaction`
- `Category`
- `UpcomingExpense`
- `WishlistItem`
- `WishlistEvent`
- `SafeToSpendSnapshot`
- `MonthlySummary`

### 7.1 SafeToSpendSnapshot

필드:

- `period`
- `amount`
- `monthlyAvailable`
- `dailyCredit`
- `creditBalance`
- `weeklyCreditBalance`
- `remainingDaysInMonth`
- `remainingDaysInWeek`
- `spentThisMonth`
- `upcomingReserved`
- `isOverBudget`
- `overBudgetAmount`

## 8. Core Calculation Rules

### 8.1 Monthly Available

```text
monthlyAvailable =
  monthlyBudget
  - spentThisMonth
  - reservedUpcomingThisMonth
```

### 8.2 Daily Credit

```text
creditedThroughDay = floor(monthlyBudget * dayOfMonth / daysInMonth)
dailyCredit = creditedThroughDay(dayOfMonth) - creditedThroughDay(dayOfMonth - 1)
creditBalance = creditedThroughDay - spentThisMonth - reservedUpcomingThisMonth
```

규칙:

- 소비하지 않은 `creditBalance`는 다음 날에도 누적한다.
- 초과 소비는 `creditBalance`를 음수로 만들며, 다음 충전액이 먼저 해소한다.
- 일간/주간 부채를 별도 저장하지 않는다.

### 8.3 Weekly Credit

```text
weeklyCreditBalance = creditBalance + creditsChargedAfterTodayUntilSunday
```

월요일 소비 전에는 주간 값이 일일 크레딧의 7일치가 된다.

### 8.4 Monthly Safe

`monthlySafe = max(monthlyAvailable, 0)`이며 Home의 MONTH 탭은 음수도 표시할 수 있도록 `monthlyAvailable`을 직접 사용한다.

### 8.5 Wishlist Impact

```text
spendingDaysEquivalent =
  if creditBalance <= 0 then null
  else price / creditBalance
```

```text
postPurchaseCredit = creditBalance - price
```

### 8.6 Reserved Upcoming Query Rule

집계 대상:

- `scheduledDate`가 현재 월 안에 있음
- `isPaid = false`

주의:

- 이미 transaction으로 전환된 upcoming expense는 중복 차감 금지
- 과거 scheduledDate인데 미지급 상태인 경우 정책 결정 필요

권장 정책:

- 과거일이지만 `isPaid = false`면 여전히 reserved로 포함

## 9. Screen Inventory

반드시 구현할 화면:

1. Onboarding / Initial Budget Setup
2. Home
3. Add Transaction
4. Transaction Log
5. Transaction Edit
6. Wishlist
7. Add Wishlist
8. Wishlist Detail
9. Upcoming Expenses
10. Settings
11. Monthly Summary

## 10. Screen-by-Screen UI Spec

### 10.1 Onboarding / Initial Budget Setup

목적:

- 앱 첫 실행 후 2~3 step 안에 Home 진입
- 긴 설명 없이 예산과 예정 지출 최소 설정

필수 구성:

- Step indicator or progress copy
- 월 예산 금액 입력
- Upcoming expense 추가/건너뛰기
- 완료 버튼

레이아웃 규칙:

- full-screen editorial typography
- step당 핵심 질문 1개만
- 기본 keypad 우선 노출

상태:

- pristine
- valid input
- empty input error

액션:

- `NEXT`
- `SKIP`
- `DONE`

구현 메모:

- 첫 실행 여부는 `app_settings`로 관리
- 완료 시 현재 월 budget row 생성

### 10.2 Home

목적:

- 앱 진입 1초 내 safe-to-spend 판단 제공

정보 우선순위:

1. Safe amount
2. Period label
3. Supporting meta
4. Recent transactions
5. Add transaction CTA

필수 섹션:

- 현재 날짜 메타
- Hero amount
- Today / Week / Month switcher
- supporting summary row
- recent transactions 3~5개
- add action

상태:

- normal
- no budget configured
- over budget
- no transactions yet

UI 규칙:

- hero 숫자는 가장 큰 텍스트
- list보다 여백과 divider 중심
- 한 화면에 카드 남발 금지

애니메이션:

- period switch 시 amount transition
- transaction 저장 직후 amount decrement animation

### 10.3 Add Transaction

목적:

- 5초 이내 지출 기록

필수 요소:

- amount display
- custom numeric keypad or focused number input
- category quick picker
- optional memo
- optional date override
- save CTA

기본값:

- type = expense
- date = now
- last used category 기억 optional

상태:

- amount 없음
- category 미선택
- 저장 가능

UX 규칙:

- 화면 진입 시 바로 금액 입력 가능 상태
- memo는 primary flow 방해 금지

### 10.4 Transaction Log

목적:

- 전체 거래 내역 확인 및 수정 진입

필수 요소:

- 월별 또는 날짜별 grouping
- filter chip optional: category, month
- row tap to edit
- add CTA

상태:

- no transactions
- filtered empty

UI 규칙:

- financial dashboard 느낌보다 editorial ledger 느낌
- 금액 정렬 명확히

### 10.5 Transaction Edit

목적:

- 거래 수정/삭제

필수 요소:

- amount
- category
- memo
- date
- save
- delete

주의:

- 수정/삭제 시 safe-to-spend 즉시 재계산

### 10.6 Wishlist List

목적:

- cooling / ready / waiting 상태를 한눈에 구분

필수 요소:

- status grouped list or section
- item name
- price
- cooldown left or ready status
- spending impact
- monthly not-spent metric preview

상태:

- cooling items only
- ready items present
- empty

UI 규칙:

- status 텍스트가 핵심
- playful하지만 game-like하지 않음

### 10.7 Add Wishlist

목적:

- 사고 싶은 물건을 즉시 기록해 구매 마찰 생성

필수 요소:

- name
- price
- optional url
- optional memo
- optional image
- cooldown duration preview
- save

기본값:

- cooldown = app setting default

저장 결과:

- status = cooling
- cooldownUntil = now + cooldownHours

### 10.8 Wishlist Detail

목적:

- 구매 판단 지원

필수 요소:

- item core info
- status badge
- time remaining or ready prompt
- current spending impact
- actions: `BUY`, `WAIT MORE`, `LET IT GO`

상태 규칙:

- `cooling`: action 제한
- `ready`: full actions 노출
- `waiting`: 대기 종료 시간 표시
- `purchased`: linked transaction 정보 표시
- `let_go`: not spent 기여 표시

### 10.9 Upcoming Expenses

목적:

- 미래 지출을 safe-to-spend 계산에 반영

필수 요소:

- upcoming list sorted by scheduledDate
- add/edit
- mark as paid / convert to transaction
- recurring 여부 표시

상태:

- no upcoming items
- overdue unpaid item

UX 규칙:

- paid 처리 시 transaction 생성 플로우 분기 명확화

### 10.10 Settings / Me

목적:

- 사용자 정의값 관리

필수 메뉴:

- Monthly Budget
- Upcoming Expenses
- Categories
- Default Wishlist Cooling Time
- Theme
- Accent Color
- Currency
- Data Export
- Reset Data

주의:

- destructive action은 confirm modal 필요

### 10.11 Monthly Summary

목적:

- 한 달을 간결하고 강한 visual summary로 회고

필수 메트릭:

- spent
- not spent
- biggest category
- impulse buys killed
- avg daily spend

확장 가능 메트릭:

- highest single expense
- most used category
- total transactions

UI 규칙:

- poster/card export 가능한 독립 widget 구조
- 일반 차트 대시보드보다 shareable visual card에 가깝게

## 11. Reusable UI Components Spec

필수 컴포넌트와 책임:

- `AppScaffold`: 일관된 safe area, background, navigation slot
- `HeroAmount`: 큰 금액, over-budget variant 포함
- `PeriodSwitcher`: today/week/month toggle
- `MetaLabel`: 작은 all-caps 정보 텍스트
- `SectionHeader`: 섹션 제목
- `TransactionRow`: 카테고리/메모/금액 표시
- `WishlistRow`: 상태/가격/impact 표시
- `PrimaryButton`: 주요 CTA
- `SecondaryButton`: 보조 CTA
- `MoneyInput`: 원화 입력 formatting
- `CategoryPicker`: 빠른 단일 선택
- `BottomSheetContainer`: add/edit 공용 시트 뼈대
- `EmptyState`: 빈 화면 카피 + 액션

## 12. Design Token Spec

### 12.1 Typography

- `heroAmount`: 64-80sp / 700-900 / tabular figures
- `displayLg`: 32-40sp / bold
- `displayMd`: 24-28sp / bold
- `body`: 14-17sp / regular-medium
- `meta`: 10-12sp / medium / tracking 증가

### 12.2 Spacing

- `xs = 4`
- `sm = 8`
- `md = 16`
- `lg = 24`
- `xl = 32`
- `xxl = 48`
- `hero = 64`

### 12.3 Radius

- `sm = 6`
- `md = 12`
- `lg = 18`
- `pill = 999`

### 12.4 Color Roles

- `bgPrimary`
- `bgSecondary`
- `textPrimary`
- `textMuted`
- `divider`
- `accent`
- `danger`
- `successMuted`

원칙:

- accent는 1개만 강하게 사용
- dark mode 우선 품질 확보

## 13. Navigation Spec

탭:

- `HOME`
- `LOG`
- `WANT`
- `ME`

권장 route 구조:

```text
/
/add-transaction
/transactions/:id/edit
/wishlist/add
/wishlist/:id
/upcoming
/settings
/settings/categories
/reports/monthly/:yearMonth
```

구현 원칙:

- bottom nav 상위 4탭 고정
- add flow는 modal sheet 또는 fullscreen sheet
- nested navigation 최소화

## 14. Provider Graph

핵심 provider:

- `appDatabaseProvider`
- `budgetRepositoryProvider`
- `transactionRepositoryProvider`
- `upcomingExpenseRepositoryProvider`
- `wishlistRepositoryProvider`
- `budgetForCurrentMonthProvider`
- `transactionsForCurrentMonthProvider`
- `upcomingForCurrentMonthProvider`
- `safeToSpendSnapshotProvider`
- `recentTransactionsProvider`
- `wishlistActiveItemsProvider`
- `monthlySummaryProvider(yearMonth)`

의존성 원칙:

- screen provider는 repository or service만 참조
- UI widget은 raw DB query 금지

## 15. Repository Contract Outline

### BudgetRepository

- `Future<Budget?> getBudgetForMonth(YearMonth month)`
- `Future<void> upsertBudget(Budget budget)`
- `Stream<Budget?> watchBudgetForMonth(YearMonth month)`

### TransactionRepository

- `Future<void> createTransaction(Transaction item)`
- `Future<void> updateTransaction(Transaction item)`
- `Future<void> deleteTransaction(int id)`
- `Stream<List<Transaction>> watchRecentTransactions(int limit)`
- `Stream<List<Transaction>> watchTransactionsForMonth(YearMonth month)`
- `Future<int> sumExpensesForMonth(YearMonth month)`

### UpcomingExpenseRepository

- `Future<void> createUpcomingExpense(...)`
- `Future<void> markAsPaid(int id, {int? linkedTransactionId})`
- `Stream<List<UpcomingExpense>> watchUpcomingExpenses()`
- `Future<int> sumReservedForMonth(YearMonth month)`

### WishlistRepository

- `Future<void> createWishlistItem(...)`
- `Future<void> markReadyItems()`
- `Future<void> waitMore(int id, Duration duration)`
- `Future<void> markPurchased(int id, {int? linkedTransactionId})`
- `Future<void> markLetGo(int id)`
- `Stream<List<WishlistItem>> watchActiveWishlistItems()`
- `Future<int> sumLetGoAmountForMonth(YearMonth month)`

## 16. Service Responsibilities

### SafeToSpendService

책임:

- 월 가용액 계산
- 일/주/월 safe 값 계산
- over-budget 상태 계산
- wishlist impact 계산

입력:

- monthly budget
- monthly spent
- reserved upcoming
- local date now

출력:

- `SafeToSpendSnapshot`

### WishlistCooldownService

책임:

- cooldown 종료 여부 판정
- wait-more 기간 계산
- 상태 전이 규칙 캡슐화

### MonthlySummaryService

책임:

- month aggregate 생성
- not spent 계산
- biggest category 계산
- impulse buys killed count 계산

## 17. State Transition Rules

### 17.1 Wishlist Status

```text
create -> cooling
cooling finished -> ready
ready + wait more -> waiting
waiting finished -> ready
ready + buy -> purchased
ready + let go -> let_go
```

규칙:

- `cooling`, `waiting` 상태에서 `BUY` 직접 노출 여부는 정책 결정 필요
- MVP 권장: `BUY`는 `ready`에서만 노출

### 17.2 Upcoming Expense

```text
created unpaid
-> paid without transaction link
-> paid with converted transaction
```

권장:

- paid 처리 시 transaction 생성 여부를 묻는 액션 제공

## 18. Empty / Error / Edge Specs

### Home

- 예산 없음: `SET MONTHLY BUDGET`
- 초과 지출: `NO SPEND LEFT`
- 거래 없음: `NOTHING SPENT YET.`

### Wishlist

- empty: `WANT NOTHING.` 또는 `NOTHING WAITING.`

### Upcoming

- empty: `NOTHING RESERVED.`

### Edge Cases

- remaining budget <= 0
- monthly budget = 0
- upcoming reserved > remaining budget
- transaction edit moves item across months
- unpaid overdue upcoming item
- wishlist dailySafe = 0

## 19. Test Plan

### Unit Tests

우선순위 1:

- `SafeToSpendService`
- `WishlistCooldownService`
- `MonthlySummaryService`

반드시 포함할 케이스:

- 월 첫날
- 월 마지막 날
- 오늘 포함 남은 날짜 계산
- 예산 0
- 예산 초과
- upcoming > remaining
- transaction 수정
- transaction 삭제
- 미래 거래가 월 합계에 미치는 영향
- dailySafe = 0일 때 wishlist impact

### Widget Tests

- Home hero 렌더링 우선순위
- Period switcher 상태 변화
- Add transaction validation
- Wishlist ready state action visibility

### Integration Tests

- onboarding 후 home 진입
- transaction 추가 후 home 금액 감소
- upcoming paid 전환 후 중복 차감 방지
- wishlist let-go 후 monthly summary 반영

## 20. Implementation Phases

### Phase 1. Foundation

산출물:

- app shell
- theme tokens
- typography/color system
- reusable base widgets
- tab navigation skeleton

체크리스트:

- [ ] theme extension 정의
- [ ] light/dark palette 정의
- [ ] typography scale 적용
- [ ] bottom nav 뼈대 구현
- [ ] app scaffold/hero/meta/button 공용화

### Phase 2. Data Layer

산출물:

- drift database
- tables
- repository implementations
- seed categories

체크리스트:

- [ ] DB schema 생성
- [ ] migration strategy 작성
- [ ] default category seed
- [ ] CRUD smoke test

### Phase 3. Budget + Onboarding

산출물:

- first-run flow
- monthly budget 저장
- upcoming expense 초기 등록

체크리스트:

- [ ] onboarding route 구현
- [ ] first-run state 판단
- [ ] budget 입력 저장
- [ ] skip/add upcoming 분기

### Phase 4. Safe-To-Spend Engine + Home

산출물:

- safe-to-spend service
- home screen
- recent transactions preview

체크리스트:

- [ ] daily/weekly/monthly 계산
- [ ] over-budget variant
- [ ] recent transaction stream 연결
- [ ] home animation 적용

### Phase 5. Transactions

산출물:

- add transaction
- log
- edit/delete

체크리스트:

- [ ] keypad or money input UX
- [ ] category picker
- [ ] transaction log grouping
- [ ] edit/delete 후 재계산 검증

### Phase 6. Upcoming Expenses

산출물:

- list/add/edit
- paid/convert flow

체크리스트:

- [ ] reserved sum query
- [ ] overdue display 처리
- [ ] transaction conversion path 구현

### Phase 7. Wishlist

산출물:

- add wishlist
- list/detail
- cooling/wait/let go/buy flow
- impact calculation

체크리스트:

- [ ] status transition 구현
- [ ] cooldown timer 표시
- [ ] days-of-spending calculation
- [ ] let-go metrics 집계

### Phase 8. Monthly Summary

산출물:

- summary aggregates
- visual poster-like monthly screen

체크리스트:

- [ ] spent
- [ ] not spent
- [ ] biggest category
- [ ] impulse buys killed
- [ ] avg/day

### Phase 9. Settings + Backup

산출물:

- settings menu
- category management
- theme/accent config
- JSON export/import skeleton

체크리스트:

- [ ] settings persistence
- [ ] destructive confirm flow
- [ ] export JSON schema 설계

### Phase 10. Polish

산출물:

- motion
- haptics
- empty states
- accessibility pass
- performance tuning

체크리스트:

- [ ] 150-350ms motion 통일
- [ ] hero amount animation 품질 확인
- [ ] contrast 점검
- [ ] touch target 점검
- [ ] cold launch 성능 확인

## 21. Suggested Build Order Inside Each Feature

예시 절차:

1. 디자인 토큰 연결
2. stateless screen skeleton 제작
3. reusable component 추출
4. provider/repository 연결
5. loading/empty/error 처리
6. animation/haptic 적용
7. widget/integration test 작성

## 22. Definition Of Done

각 화면은 아래를 모두 만족해야 한다.

- 첫 1초에 핵심 정보가 보인다
- typography hierarchy가 명확하다
- spacing이 일관적이다
- business logic이 UI에서 분리되어 있다
- light/dark 둘 다 읽기 쉽다
- empty/error/over-budget 상태가 자연스럽다
- 기본 Flutter 앱처럼 보이지 않는다
- README의 product tone을 해치지 않는다

## 23. Immediate Next Task Recommendation

Codex가 바로 구현에 들어간다면 아래 순서를 권장한다.

1. `Phase 1 Foundation`
2. `Phase 2 Data Layer`
3. `Phase 3 Budget + Onboarding`
4. `Phase 4 Safe-To-Spend Engine + Home`

이 순서가 완료되면 앱의 핵심 가치인 "얼마까지 써도 되는가"를 가장 먼저 검증할 수 있다.
# Annual Special Budget Extension

Implemented design: a transaction has both a base spending category and a budget
type. `MONTHLY` uses the existing monthly-credit system. `ANNUAL_SPECIAL` uses a
yearly total and one of `TRAVEL`, `GIFT`, `EVENT`, `MAINTENANCE`, `MEDICAL`, or
`OTHER`, without changing monthly credit or monthly category budgets.

# Saving Tab Extension

## Purpose

`LOG` records where money was spent. `SAVING` records whether payday money was
protected first. It is a monthly process tracker, not a second expense ledger.

## Monthly Saving Plan

Default monthly salary plan: `₩4,000,000`.

| Step | Default target | Completion |
| --- | ---: | --- |
| ETF | ₩1,000,000 | Mark done after transfer |
| Annual Special reserve | ₩330,000 | Mark done after reserve transfer |
| Living account | ₩1,200,000 | Mark done after transfer |
| Housing savings | ₩114,750 | Mark done after transfer |
| Fixed-cost reserve | ₩1,355,250 | Mark done after securing it |

All five steps complete the payday setup. Each completion timestamp is stored
against its year-month, so a new month starts with a clean checklist.

## Linked Balances

- Spending Account: current monthly budget minus `MONTHLY` LOG spending.
- Credit Card: `CREDIT CARD` monthly transactions against a ₩300,000 target.
- Prepayment: a card transaction can be marked prepaid without changing its
  spending amount or category.
- Month-end Sweep: the positive living-account remainder is frozen once and
  recorded as a housing-savings contribution.

## Saving Data Schema

- `transactions.payment_method`: `cash` or `creditCard`.
- `transactions.prepaid_at`: nullable completion timestamp.
- `saving_plans_table`: one row per `year_month`, with targets, step timestamps,
  and the fixed Sweep amount.

## Top-Level Reporting

- `WEALTH`: completed ETF + completed housing savings + completed Sweep.
- `RESERVE`: completed Annual Special allocation.

Annual Special remains separate because it is spending reserve money, not pure
wealth accumulation.

Saving plan targets and labels are editable from `ME > BUDGET > SAVING BUDGET`
for the current month. The initial labels are `신한투자 / ETF투자`, `토스나눠모으기 /
ANNUAL SPECIAL`, `토스나눠모으기 / 비상금`, `토스통장 / 고정비확보`, and `케이뱅크 /
생활비이체`. Editing a target or label never clears that month's completed steps
or Sweep record.
