# Category Budget Import Spec

작성 기준일: 2026-08-31

## 0. Current Category Standard

앱의 기본 카테고리는 다음 8개로 정의한다.

| Code | Scope |
| --- | --- |
| `DATE` | 여자친구와 쓰는 식사, 카페, 영화, 데이트 쇼핑 전부 |
| `EAT` | 혼자 먹는 외식, 카페, 간식, 배달 |
| `SHOP` | 옷, 잡화, 쿠팡, 사고 싶은 물건 |
| `BEAUTY` | 화장품, 미용실, 네일 |
| `MOVE` | 기름, 택시, 대중교통, 주차 |
| `FUN` | 게임, 전시, 책, 술, 취미 |
| `LIFE` | 집/생활용품, 병원, 약 |
| `ETC` | 어느 카테고리에도 해당하지 않는 소비 |

카테고리 관리에서는 이름, 활성 상태, 현재 월 예산을 수정할 수 있다. 기존 `FOOD/CAFE`는 `EAT`, `HOME/HEALTH`는 `LIFE`로 거래와 예약을 보존하며 자동 통합한다.

## 1. Feasibility

가능하다.

이 기능은 현재 앱 구조와 잘 맞는다.

- 앱은 이미 local-first 구조다.
- `Transaction` 기반으로 Home의 safe-to-spend를 계산한다.
- 따라서 텍스트 입력을 `카테고리별 예산`과 `오늘자 거래`로 변환해 저장하면, 별도 계산 분기 없이 기존 계산 엔진이 바로 반영할 수 있다.

## 2. User Problem

현재는 사용자가

1. 월 전체 예산을 잡고
2. 거래를 하나씩 입력해야 한다.

하지만 실제 사용에서는 다음처럼 한 번에 정리된 텍스트가 이미 있는 경우가 많다.

```text
데이트 식사·카페·술
- 점심|60000원
- 카페|10000원

쇼핑
- 셔츠|39000원
```

또는 월 카테고리 예산 표가 이미 있다.

```markdown
| 카테고리 | 월 예산 |
| --- | --- |
| 데이트 식사·카페·술 | 400000 |
| 교통·자동차 변동비 | 200000 |
| 쇼핑 | 150000 |
| 자유 버퍼 | 150000 |
| 합계 | 1200000 |
```

원하는 경험은:

> 내가 표와 텍스트만 붙여넣으면 앱이 카테고리 예산과 오늘 소비를 자동 반영해준다.

## 3. Feature Summary

새 기능:

`CATEGORY BUDGET IMPORT`

사용자는 Settings에서 다음 두 입력을 붙여넣을 수 있다.

1. 월 카테고리 예산 표
2. 오늘 소비 텍스트 블록

앱은 이를 파싱해서:

- 카테고리별 월 예산 저장
- 총 월 예산 자동 합산 후 `Budget` 갱신
- 오늘자 `Transaction` 자동 생성
- Home / Log / Summary에 즉시 반영

## 4. Input Formats

### 4.1 Monthly Category Budget Table

허용 포맷:

- Markdown table
- `카테고리 | 금액`
- `카테고리 | 40만`
- `카테고리 | 400000원`

예시:

```markdown
| 카테고리 | 월 예산 |
| --- | --- |
| 데이트 식사·카페·술 | 40만 |
| 교통·자동차 변동비 | 20만 |
| 쇼핑 | 15만 |
| 개인 취미·여가 | 10만 |
| 생활·미용·의료 | 10만 |
| 편의점·잡화 | 10만 |
| 자유 버퍼 | 15만 |
| 합계 | 120만 |
```

파싱 규칙:

- 헤더 row 무시
- `합계` row 무시
- 금액에서 `원`, `,`, 공백 제거
- `만` 단위 허용

### 4.2 Today Spend Block

예시:

```text
데이트 식사·카페·술
- 점심|60000원
- 카페|10000원

쇼핑
- 셔츠|39000원
```

파싱 규칙:

- bullet 전의 줄을 현재 category block 이름으로 사용
- item format: `메모|금액`
- 금액에서 `원`, `,`, 공백 제거
- block category가 없으면 에러

## 5. Data Model

신규 테이블:

`category_budget_allocations`

컬럼:

- `id`
- `categoryId`
- `yearMonth`
- `budgetAmount`
- `createdAt`
- `updatedAt`

제약:

- `(categoryId, yearMonth)` unique

## 6. Import Flow

1. 사용자가 Settings > `CATEGORY BUDGET IMPORT` 진입
2. 월 예산 표 입력
3. 오늘 소비 텍스트 입력
4. `PREVIEW` 또는 `IMPORT`
5. 앱이 파싱
6. category name 기준으로 기존 category 매칭
7. 없으면 새 category 생성
8. category budget allocation 저장
9. total sum 계산 후 current month `Budget.monthlyBudget` 갱신
10. today spend block을 today `Transaction`으로 저장
11. Home / Log / Summary 자동 갱신

## 7. Validation Rules

- 잘못된 표 row는 import 실패
- `메모|금액` 형식이 아니면 import 실패
- 금액 <= 0이면 실패
- 중복 category budget row는 마지막 row를 우선

## 8. UX Rules

- import screen은 붙여넣기 중심
- preview summary 제공:
  - parsed budget count
  - parsed today transaction count
  - computed total monthly budget
- 결과 snack bar 제공

## 9. Expected Benefit

- 월 예산 세팅 속도 크게 단축
- 하루 거래를 일괄 반영 가능
- 기존 safe-to-spend 철학 유지
- “수동 기록 스트레스” 감소

## 10. Initial Scope

이번 구현 범위:

- parser
- DB table
- import service
- settings entry
- import screen
- preview
- today transaction auto-create

추가 구현 범위:

- 기본 카테고리 8개 seed 및 legacy category migration
- 카테고리 이름 수정
- 카테고리별 현재 월 예산 설정
- Settings의 bulk import 진입점 및 preview

이번 구현 제외:

- OCR
- CSV/Excel import
- duplicate import detection
- undo import batch
