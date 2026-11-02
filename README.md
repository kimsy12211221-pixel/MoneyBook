# Project Spec — Personal Spending App

## 0. Project Summary

Flutter 기반의 개인용 모바일 가계부 애플리케이션을 개발한다.

이 앱은 일반적인 가계부처럼 “어디에 얼마를 썼는지 기록하고 분석하는 것”을 최우선 목표로 하지 않는다.

핵심 질문은 단 하나다.

> 지금 내가 얼마까지 써도 되는가?

사용자는 앱을 열자마자 다음 세 가지 값을 직관적으로 확인할 수 있어야 한다.

- 오늘 사용할 수 있는 금액
- 이번 주 사용할 수 있는 금액
- 이번 달 사용할 수 있는 금액

모든 거래 기록, 예산, 예정 지출, 위시리스트 기능은 궁극적으로 이 질문에 답하기 위한 보조 시스템이다.

또한 충동적으로 물건을 구매하는 행동을 줄이기 위해 Wishlist를 제공한다.

Wishlist는 단순한 상품 저장 기능이 아니다.

“사고 싶다 → 바로 산다” 사이에 의도적인 시간적 마찰을 삽입하여 구매 의사결정을 늦추는 장치다.

이 프로젝트는 상용 서비스가 아니라 **단일 사용자를 위한 personal software**다.

따라서 다음을 우선한다.

1. 내가 실제로 매일 쓰고 싶은가
2. 화면이 아름답고 즉각적으로 이해되는가
3. 입력하는 데 귀찮지 않은가
4. 현재 소비 가능 금액이 정확하게 계산되는가

다중 사용자, 로그인, 소셜 기능, 복잡한 금융 인프라는 MVP 범위에서 제외한다.

---

# 1. Product Philosophy

## 1.1 기존 가계부와의 차이

일반적인 가계부:

> 내가 돈을 어디에 썼는가?

이 앱:

> 지금 이 돈을 써도 괜찮은가?

기존 가계부는 과거를 분석한다.

이 앱은 과거의 지출 데이터를 이용해서 **현재의 소비 결정을 돕는다.**

따라서 앱의 중심 데이터는 Transaction 자체가 아니다.

앱의 중심 개념은:

# Safe to Spend

이다.

---

# 2. Product Goals

## Primary Goal

사용자가 앱을 열고 1~2초 안에

> “오늘 이 정도까지는 써도 괜찮다.”

라는 판단을 할 수 있게 한다.

## Secondary Goals

- 이번 주 소비 여력을 빠르게 파악
- 월말까지 사용할 수 있는 총 금액 확인
- 예정된 지출 때문에 실제 가용 금액을 과대평가하지 않도록 함
- 소비 내역을 최소한의 조작으로 기록
- 충동구매를 바로 결제로 연결하지 않고 Wishlist로 보냄
- 사지 않은 물건도 기록해 소비 억제의 성과를 확인
- 월별 소비 패턴을 재미있고 아름답게 회고

---

# 3. Non-Goals

초기 버전에서는 다음 기능을 구현하지 않는다.

- 회원가입
- 서버 기반 사용자 관리
- 은행 계좌 자동 연동
- 카드사 연동
- Open Banking
- 여러 사람과 가계부 공유
- 가족 가계부
- 투자 자산 관리
- 주식/코인 포트폴리오
- 복잡한 회계 기능
- 영수증 OCR
- AI 자동 분류
- 커뮤니티
- 광고
- 구독 결제

개인 사용을 위한 로컬 앱으로 시작한다.

---

# 4. Core User Experience

앱을 실행했을 때 가장 먼저 보여야 하는 것은 차트도 거래내역도 아니다.

가장 먼저 보여야 하는 것은:

> YOU CAN SPEND  
> ₩42,800  
> TODAY

이다.

사용자가 가장 많이 수행하는 행동 순서는 다음과 같다.

### Flow A — 소비 가능 금액 확인

앱 실행

→ Today Safe to Spend 확인

→ 필요하면 Week / Month 확인

→ 앱 종료

이 흐름은 최대한 빠르고 마찰이 없어야 한다.

---

### Flow B — 지출 기록

앱 실행

→ Add 버튼

→ 금액 입력

→ 카테고리 선택

→ 저장

목표 입력 시간:

5초 이내

---

### Flow C — 사고 싶은 물건 발견

사고 싶은 물건 발견

→ Wishlist에 추가

→ 금액 입력

→ Cooling 상태

→ 일정 시간이 지난 후 다시 판단

→ Buy / Wait / Let Go

---

# 5. Information Architecture

Bottom Navigation은 최대 4개 탭으로 제한한다.

## 1. HOME

현재 소비 가능 금액을 보여주는 핵심 화면.

## 2. LOG

거래 내역 및 지출 기록.

## 3. WANT

Wishlist / 구매 보류 시스템.

## 4. ME

예산, 고정비, 카테고리, 설정, 리포트.

Bottom navigation의 label은 짧고 강하게 유지한다.

HOME  
LOG  
WANT  
ME

---

# 6. HOME

HOME은 이 앱에서 가장 중요한 화면이다.

전체 디자인 우선순위의 50% 이상을 HOME에 투자한다.

## 6.1 Hero Area

화면 상단 대부분을 소비 가능 금액에 사용한다.

예시:

YOU CAN SPEND

₩42,800

TODAY

숫자는 화면에서 가장 큰 Typography를 사용한다.

정보 우선순위:

1. 금액
2. TODAY
3. YOU CAN SPEND

---

## 6.2 Period Selector

Today / Week / Month를 선택할 수 있어야 한다.

예:

TODAY  
WEEK  
MONTH

선택 시 hero 숫자가 자연스럽게 변경된다.

페이지 전체가 이동하지 않고 숫자 중심으로 변화한다.

---

## 6.3 Supporting Information

Hero 아래에는 작은 텍스트로 다음 정도만 보여준다.

예:

8 DAYS LEFT  
₩413,200 SPENT

또는

AVAILABLE ₩342,000  
UPCOMING ₩120,000

보조 정보는 Hero보다 시각적으로 확실히 약해야 한다.

---

## 6.4 Recent Transactions

최근 거래 3~5개만 보여준다.

예:

COFFEE  
₩5,800

DINNER  
₩24,000

TAXI  
₩13,400

전체 거래는 LOG에서 확인한다.

HOME을 거래내역 화면으로 만들지 않는다.

---

# 7. Safe to Spend Calculation

핵심 계산 엔진.

## 7.1 Monthly Available

monthlyAvailable =

monthlyVariableBudget  
- spentThisMonth  
- upcomingReservedExpense

예:

월 변동비 예산

1,500,000

현재까지 지출

500,000

예정 지출

300,000

monthlyAvailable

700,000

---

# 7.2 Daily Safe to Spend

기본 계산:

dailySafe = monthlyAvailable / remainingDaysIncludingToday

예:

monthlyAvailable = 700,000

remainingDays = 14

dailySafe = 50,000

---

# 7.3 Weekly Safe

이번 주 남은 날짜에 해당하는 예상 사용 가능 금액.

weeklySafe = dailySafe × remainingDaysInCurrentWeek

단 월말을 넘어가는 날짜는 포함하지 않는다.

---

# 7.4 Spending Adjustment

오늘 적게 사용했다고 unused daily budget을 소멸시키지 않는다.

매일 전체 잔여 예산을 다시 계산한다.

예:

오늘 Safe to Spend

50,000

오늘 실제 소비

20,000

다음 날에는 남은 30,000원이 전체 잔액에 남아 있으므로 dailySafe가 자연스럽게 증가한다.

반대로:

오늘 100,000 소비

→ 남은 monthlyAvailable 감소

→ 이후 dailySafe 감소

즉 일일 예산을 미리 고정하지 않는다.

항상 remaining budget을 기반으로 재계산한다.

---

# 7.5 Upcoming Expense

예정 지출은 아직 결제되지 않았더라도 소비 가능 금액에서 미리 제외한다.

예:

10일 후 미용실

₩180,000

Spotify

₩11,900

교통 정기비

₩50,000

이 금액들은 Upcoming Expense로 예약한다.

---

# 8. Transactions

## Transaction Model

필드:

id

amount

type

categoryId

date

memo

createdAt

updatedAt

type:

expense  
income

MVP에서는 expense를 중심으로 구현한다.

---

# 9. Transaction Input UX

입력 화면은 매우 단순해야 한다.

화면 진입 시 바로 숫자 키패드를 노출한다.

예:

₩

42,000

아래에 Category.

FOOD

CAFE

SHOP

BEAUTY

MOVE

FUN

HOME

ETC

카테고리 선택 후:

SAVE

Memo는 optional.

날짜 기본값은 현재 시간.

---

# 10. Categories

초기 기본 Category:

FOOD

CAFE

SHOP

BEAUTY

MOVE

FUN

HOME

HEALTH

ETC

카테고리를 지나치게 세분화하지 않는다.

사용자는 ME에서 category 추가/수정 가능.

Category Model:

id

name

icon

sortOrder

isActive

---

# 11. Budget

## Monthly Budget

매월 사용할 수 있는 변동비 예산을 설정한다.

예:

MONTHLY SPENDING BUDGET

₩1,500,000

고정비는 별도의 Fixed Expense로 관리할 수 있다.

초기 구조에서는:

Income  
- Fixed Expenses  
- Saving Goal

을 자동 계산하는 시스템보다,

사용자가 직접

“이번 달 내가 자유롭게 쓸 수 있는 금액”

을 입력하는 UX를 우선한다.

즉 금융 시스템 전체를 모델링하려 하지 않는다.

---

# 12. Upcoming Expenses

예정 지출 등록 기능.

필드:

id

title

amount

scheduledDate

categoryId

isRecurring

recurrenceType

isPaid

createdAt

예:

HAIR

₩180,000

SEP 04

예정 지출이 실제로 발생하면 Transaction으로 변환 가능해야 한다.

---

# 13. Wishlist — WANT

Wishlist는 이 앱의 두 번째 핵심 기능이다.

단순 북마크가 아니다.

# Impulse Purchase Friction System

으로 설계한다.

---

# 14. Wishlist Item

필드:

id

name

price

url

imagePath

memo

createdAt

cooldownUntil

status

purchasedAt

releasedAt

status:

cooling

ready

waiting

purchased

letGo

---

# 15. Wishlist Flow

새 아이템 추가.

예:

NEW BALANCE 1906R

₩189,000

사용자가 저장하면 바로 구매 상태가 아니다.

기본:

COOLING FOR 72H

상태로 이동한다.

---

# 16. Cooling UX

Wishlist Card 예:

NEW BALANCE 1906R

₩189,000

COOLING

47H LEFT

가능하면 남은 시간을 시각적으로 표현한다.

하지만 지나치게 게임화하지 않는다.

---

# 17. Ready State

Cooling 시간이 끝나면:

STILL WANT IT?

버튼:

BUY

WAIT MORE

LET IT GO

WAIT MORE 선택 시:

3 DAYS  
7 DAYS  
14 DAYS  
30 DAYS

등을 선택할 수 있다.

---

# 18. Spending Impact

Wishlist 상품에는 단순 가격뿐 아니라 구매가 현재 예산에 미치는 영향을 보여준다.

예:

₩189,000

=

4.5 DAYS OF SPENDING

또는:

IF YOU BUY THIS

₩42K → ₩31K / DAY

이 정보가 Wishlist에서 매우 중요하다.

사용자가 가격을 현재 생활비와 연결해서 인식하도록 한다.

계산:

spendingDaysEquivalent = price / currentDailySafe

---

# 19. Let It Go

구매하지 않기로 결정한 물건은 삭제하지 않는다.

LET IT GO 상태로 보존한다.

이를 이용해:

NOT SPENT

통계를 만든다.

예:

AUGUST

₩1,046,000

NOT SPENT.

이 숫자는 실제 저축액이라고 표현하지 않는다.

“안 쓴 금액”이다.

---

# 20. Monthly Reflection

매월 간단한 소비 회고 화면을 제공한다.

전통적인 금융 Dashboard보다 SNS에서 공유할 수 있을 정도로 시각적으로 매력적인 카드 형태를 목표로 한다.

예:

AUGUST

SPENT

₩1.24M

---

NOT SPENT

₩640K

---

BIGGEST CATEGORY

FOOD

---

IMPULSE BUYS KILLED

7

---

AVG DAILY SPEND

₩38K

이 화면은 추후 이미지 Export 기능을 추가할 수 있도록 독립적인 Widget 구조로 만든다.

---

# 21. Design Philosophy

# DESIGN IS A CORE FEATURE.

이 프로젝트에서 디자인은 기능 구현 이후 적용하는 decoration이 아니다.

UI 자체가 제품 경험의 핵심이다.

기능이 동작하더라도 디자인 요구사항을 충족하지 못하면 완료된 것으로 간주하지 않는다.

---

# 22. Visual Direction

스타일 키워드:

Editorial

Bold

Minimal

Youthful

Fashion

Social

Utility

Global

Contemporary

목표:

“금융앱”보다

“Gen Z lifestyle app + editorial design”

에 가까워야 한다.

Instagram / X / fashion brand / modern media app의 감각을 금융 데이터 UI에 적용한다.

---

# 23. Explicitly Avoid

다음 스타일을 피한다.

- 전형적인 은행앱
- 토스 카피
- 파스텔톤 금융 앱
- 과도한 gradient
- 캐릭터
- 돼지 저금통 icon
- 동전 illustration
- 지나치게 둥근 card
- 모든 정보를 card container 안에 넣는 디자인
- meaningless graph
- 원형 progress chart 남발
- 작은 dashboard widget 여러 개
- emoji 중심 UX
- “이번 달도 잘하고 있어요 ❤️” 형태의 infantilizing copy

---

# 24. Layout Principle

Card-based dashboard보다:

Typography

Whitespace

Divider

Alignment

Hierarchy

를 활용한다.

화면 하나에 10개의 카드가 떠다니는 구조를 피한다.

예:

BAD

┌─────┐  
│ card │  
└─────┘

┌─────┐  
│ card │  
└─────┘

┌─────┐  
│ card │  
└─────┘

GOOD

YOU CAN SPEND

₩42,800

TODAY

────────────

8 DAYS LEFT

₩412K REMAINING

────────────

RECENT

---

# 25. Typography

Typography가 UI identity의 핵심이다.

최소한 다음 역할을 분리한다.

## Hero Number

매우 큰 숫자.

예:

₩42,800

권장 범위:

56~80sp

weight:

700~900

가능하면 tabular figures 사용.

---

## Display Text

예:

YOU CAN SPEND

TODAY

AUGUST

24~40sp

Bold.

---

## Body

14~17sp

Regular / Medium.

---

## Meta

10~12sp

ALL CAPS 허용.

letter spacing 약간 증가.

예:

8 DAYS LEFT

AUG 30

22:41

---

# 26. Font

우선 Google Fonts 또는 Flutter에서 안정적으로 사용할 수 있는 글로벌 Sans Serif를 사용한다.

후보:

Inter

Space Grotesk

Manrope

DM Sans

Archivo

초기 권장:

Space Grotesk + Inter

또는

Inter 단일 family.

숫자 표현이 아름다운 폰트를 우선한다.

---

# 27. Color System

컬러 사용을 제한한다.

기본:

Background

Text

Muted Text

Divider

Accent

Danger

정도만 사용.

Accent는 단일 컬러를 중심으로 한다.

Light / Dark theme 둘 다 고려한다.

초기 버전에서는 Dark Mode가 매우 중요하다.

추천 방향:

BLACK

OFF-WHITE

ONE ELECTRIC ACCENT

예:

acid green

electric blue

hot red

violet

등.

정확한 색은 Theme Token으로 관리하여 쉽게 변경 가능하게 한다.

---

# 28. Design Tokens

Flutter ThemeExtension 등을 활용해 token 기반으로 구현한다.

예:

AppSpacing

xs = 4

sm = 8

md = 16

lg = 24

xl = 32

xxl = 48

hero = 64

---

Radius:

small = 6

medium = 12

large = 18

pill = 999

과도하게 모든 요소에 24~32 radius를 적용하지 않는다.

---

# 29. Motion

Motion은 적지만 의미 있게 사용한다.

좋은 예:

Safe to Spend 금액 변경 시 number transition

Today → Week 변경 시 subtle slide/fade

Transaction 저장 시 숫자가 감소하는 animation

Wishlist Cooling 완료 상태 전환

나쁜 예:

불필요한 bouncing

confetti 남발

floating blob

게임 UI 같은 particle

Motion duration:

150~350ms 중심.

---

# 30. Haptics

핵심 interaction에 haptic feedback 사용 가능.

예:

Transaction save

Wishlist LET IT GO

Period toggle

과도하게 사용하지 않는다.

---

# 31. Navigation

Flutter:

NavigationBar 또는 custom bottom navigation.

화면:

HomeScreen

LogScreen

WishlistScreen

MeScreen

Nested navigation은 최소화한다.

---

# 32. Flutter Technical Stack

Flutter latest stable.

Dart latest stable compatible version.

추천 구조:

lib/

core/

theme/

utils/

constants/

data/

models/

repositories/

services/

features/

home/

transactions/

wishlist/

budget/

reports/

settings/

shared/

widgets/

---

# 33. State Management

추천:

Riverpod

사용 이유:

- 테스트 용이
- dependency 관리 명확
- 계산 상태 관리에 적합
- Flutter ecosystem 안정적

Provider 예:

budgetProvider

transactionProvider

upcomingExpenseProvider

safeToSpendProvider

wishlistProvider

---

# 34. Local Database

개인용 앱이므로 Local-first architecture.

추천:

Drift + SQLite

또는 Isar.

1순위:

Drift.

이유:

Transaction / Budget / Wishlist 간 관계와 날짜 기반 query가 많기 때문이다.

향후 backup/export 구현에도 유리하다.

---

# 35. Repository Pattern

UI에서 DB를 직접 호출하지 않는다.

예:

TransactionRepository

BudgetRepository

WishlistRepository

UpcomingExpenseRepository

ReportRepository

각 Feature는 repository를 통해 데이터를 사용한다.

---

# 36. SafeToSpendService

계산 로직은 Widget 내부에 작성하지 않는다.

별도 Domain Service로 구현한다.

예:

SafeToSpendService

methods:

calculateMonthlyAvailable()

calculateDailySafe()

calculateWeeklySafe()

calculateWishlistImpact()

이를 통해 UI와 계산 logic을 분리한다.

---

# 37. Date Handling

날짜 계산은 timezone 영향을 고려한다.

사용자 기준 Local Time으로 처리한다.

월 시작:

local month start

월 종료:

local month end

remainingDays 계산 시 오늘을 포함한다.

예:

8월 20일

8월 20~31일

= 12 days

---

# 38. Currency

초기 기본 currency:

KRW.

표시:

₩42,800

큰 숫자는 필요에 따라 compact display 가능.

₩1.24M

단 내부 데이터는 정수 원 단위로 저장한다.

floating point 금지.

amount:

int

---

# 39. Settings

ME에서 다음 설정 제공.

Monthly Budget

Fixed / Upcoming Expenses

Categories

Default Wishlist Cooling Time

Theme

Accent Color

Currency

Data Export

Reset Data

---

# 40. Data Backup

MVP 후반 우선순위.

최소:

JSON Export

JSON Import

또는 SQLite backup.

개인 데이터이므로 클라우드 서버가 없어도 사용자가 데이터를 보존할 수 있어야 한다.

---

# 41. Empty States

빈 화면 디자인도 중요하다.

예:

거래 없음

NOTHING SPENT YET.

위시리스트 없음

WANT NOTHING.

또는

NOTHING WAITING.

지나치게 친절하거나 감정적인 설명은 피한다.

---

# 42. Copywriting Style

앱 전체 문구는 짧고 직접적이어야 한다.

좋음:

YOU CAN SPEND

NOT SPENT

STILL WANT IT?

LET IT GO

WAIT MORE

8 DAYS LEFT

BAD:

“오늘도 현명한 소비 생활을 시작해볼까요?”

“이번 달 소비 목표를 위해 조금만 더 노력해보세요!”

“대단해요! 충동구매를 참았어요!”

앱은 사용자에게 훈계하거나 칭찬하지 않는다.

정보를 보여주고 결정은 사용자에게 맡긴다.

---

# 43. Accessibility

큰 숫자의 contrast 확보.

색상만으로 상태를 전달하지 않는다.

Text Scaling 대응.

터치 영역 최소 44~48dp.

---

# 44. MVP Screens

반드시 구현:

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

---

# 45. Initial Setup

첫 실행:

WELCOME 등의 긴 onboarding은 만들지 않는다.

최대 2~3단계.

예:

HOW MUCH CAN YOU SPEND THIS MONTH?

₩ ______

NEXT

UPCOMING EXPENSES?

SKIP / ADD

DONE

바로 Home으로 이동.

---

# 46. Home Example

레이아웃 reference:

08 / 30

YOU CAN  
SPEND

₩42,800

TODAY

TODAY / WEEK / MONTH

────────────

8 DAYS LEFT

₩342,400 AVAILABLE

────────────

RECENT

COFFEE                -5,800

DINNER               -24,000

TAXI                 -13,400

────────────

+ ADD

카드 UI를 최소화한다.

---

# 47. WANT Example

WANT

3 COOLING

────────────

NEW BALANCE 1906R

₩189,000

47H LEFT

4.5 DAYS OF SPENDING

────────────

HEADPHONES

₩349,000

READY

STILL WANT IT?

────────────

NOT SPENT THIS MONTH

₩428,000

---

# 48. Monthly Report Example

AUGUST

────────────

SPENT

₩1.24M

────────────

NOT SPENT

₩640K

────────────

BIGGEST WEAKNESS

FOOD

────────────

IMPULSE BUYS KILLED

7

────────────

AVG / DAY

₩38K

---

# 49. Performance

앱 실행 후 Home 데이터가 즉시 보이는 것이 중요하다.

가능하면:

cold launch 이후 빠른 render.

Safe to Spend 계산은 local data만 사용하므로 blocking network 작업 없음.

DB query와 계산량은 매우 작아야 한다.

---

# 50. Testing

최소 Unit Test:

SafeToSpendService.

특히 다음 edge case 테스트:

월 첫날

월 마지막 날

예산 0

예산 초과

upcoming expense > remaining budget

transaction 삭제

transaction 수정

future transaction

Wishlist 가격이 dailySafe보다 큰 경우

dailySafe가 0인 경우

---

# 51. Safe to Spend Edge Cases

remaining budget <= 0이면:

₩0

또는 초과 금액을 별도로 보여준다.

예:

OVER

₩124,000

negative daily safe를:

-₩4,000

처럼 메인 Hero에 표시하지 않는 것을 권장한다.

대신:

NO SPEND LEFT

OVER BY ₩124K

같은 UX 사용.

---

# 52. Architecture Principle

다음 순서를 유지한다.

Database

↓

Repository

↓

Domain Service

↓

Riverpod Provider

↓

UI

Widget 내부에 business calculation을 넣지 않는다.

---

# 53. Design Component Library

재사용 가능한 Widget을 먼저 구축한다.

AppScaffold

HeroAmount

PeriodSwitcher

MetaLabel

SectionHeader

TransactionRow

WishlistRow

PrimaryButton

TextButton

MoneyInput

CategoryPicker

Divider

BottomNav

ModalSheet

모든 화면에서 typography와 spacing consistency를 유지한다.

---

# 54. Development Priority

개발 순서:

## Phase 1

Design System

Typography

Color

Spacing

Navigation skeleton

## Phase 2

Local DB

Budget

Transaction CRUD

## Phase 3

Safe to Spend engine

Home

## Phase 4

Wishlist

Cooldown

Wishlist Impact

## Phase 5

Upcoming Expenses

## Phase 6

Monthly Report

## Phase 7

Polish

Animation

Haptic

Dark Mode

Empty states

---

# 55. Definition of Done

기능이 동작하는 것만으로 완료로 간주하지 않는다.

각 화면은 다음 조건을 만족해야 한다.

- visual hierarchy가 명확함
- 첫 1초에 가장 중요한 정보가 보임
- 화면에 불필요한 정보가 없음
- spacing이 일관적임
- Typography hierarchy가 명확함
- Light/Dark 환경에서 contrast가 적절함
- interaction animation이 자연스러움
- 기본 Flutter Material App처럼 보이지 않음
- 흔한 금융 Dashboard template처럼 보이지 않음

---

# 56. Most Important Product Constraint

이 앱을 개발하면서 기능이 추가될 때마다 질문한다.

> 이 기능이 “지금 내가 얼마를 써도 되는가?”를 더 잘 판단하게 해주는가?

아니라면 핵심 화면에서 제거하거나 구현 우선순위를 낮춘다.

Wishlist 기능에서는 질문한다.

> 이 기능이 “사고 싶다 → 바로 산다” 사이에 좋은 마찰을 만들어주는가?

아니라면 추가하지 않는다.

---

# 57. Product Identity

이 프로젝트를:

“Budget Tracker”

로 만들지 않는다.

정확히는:

# Personal Spending Decision Interface

에 가깝다.

기존 금융 앱은 돈을 기록한다.

이 앱은 돈을 쓰기 직전의 판단을 지원한다.

---

# 58. Codex Implementation Instruction

구현 시 functionality-first prototype을 만든 뒤 나중에 디자인을 덧입히는 방식을 사용하지 않는다.

각 feature를 구현할 때:

1. 해당 화면의 visual hierarchy 설계
2. Design token 사용
3. reusable UI component 구축
4. business logic 연결
5. micro interaction 추가
6. edge case 처리

순서로 진행한다.

기본 Material Widget을 그대로 노출하지 않는다.

Material component를 사용할 경우에도 App Theme에 맞게 반드시 customize한다.

특히:

Home

Wishlist

Monthly Report

세 화면은 이 제품의 identity를 결정하는 화면이므로 일반적인 CRUD application처럼 구현하지 않는다.

---

# Final Product Principle

이 앱은 세상에서 가장 기능이 많은 가계부를 목표로 하지 않는다.

이미 그런 앱은 충분히 많다.

이 앱이 가져야 하는 이유는 하나다.

> 내가 직접 쓰고 싶기 때문이다.

그래서 기능의 양보다:

clarity

speed

visual identity

behavioral usefulness

를 우선한다.

앱을 열었을 때 복잡한 금융 정보를 공부해야 하는 것이 아니라,

커다란 숫자 하나를 보고

“아, 오늘은 이 정도 써도 되는구나.”

라고 바로 느낄 수 있어야 한다.

그리고 사고 싶은 물건이 생겼을 때,

“사야지.”

가 아니라

“일단 WANT에 넣어두자.”

가 자연스러운 행동이 되는 것이 최종 목표다.