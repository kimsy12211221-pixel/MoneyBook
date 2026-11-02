# Widget Character Message Spec

## Goal

Replace the empty decorative bottom area of the `Wave` widget with a tiny `👾` character and a speech bubble that reacts to the monthly budget state.

## Visual Rule

- Character sits on the lower-left area at roughly `1/10` of the widget footprint
- Speech bubble becomes the primary decorative element
- White background and green tone stay as the base look
- Character should feel like a tiny Tamagotchi-style pixel pet based on the original `👾` emoji silhouette
- Message should feel like:
  - supportive
  - lightly playful
  - short enough to scan in one glance

## Decision Inputs

- monthly budget exists or not
- over budget or not
- remaining budget percent
- current day progress inside the month
- spending pace versus month progress
- zero-spend early month state
- end-of-month on-track exception

## Message States

| State | Condition | Tone | Example |
| --- | --- | --- | --- |
| setup | no budget | onboarding | `이번 달 예산부터 같이 정해보자!` |
| over | spent > budget | gentle brake | `앗, 지금은 브레이크 타임!` |
| zero-spend | spent = 0 and day >= 5 | praise | `아직 0원! 완전 잘 버티는 중` |
| very-safe | pace ratio <= 0.85 | strong encouragement | `아주 좋아! 지금 페이스 완벽` |
| safe | pace ratio <= 1.0, or month end with on-track pace | calm support | `지금처럼만 가자` |
| balanced | pace ratio <= 1.12 | soft caution | `조금만 신경 쓰자` |
| caution | pace ratio <= 1.22 and remaining is still workable | caution | `오늘은 가볍게` |
| tight | pace ratio is clearly above target, or remaining is critically low too early | protective | `진짜 필요한 것만` |

## Copy Principles

- keep to 1-2 short lines
- no guilt, no scolding
- prefer coaching over warning
- if warning is needed, make it actionable and warm
- rotate among a few variants so the widget feels alive
- do not show an anxious message at month end when spending pace is still on track
- selection should consider more than day-of-month so repeated states still feel fresh

## Current Implementation

- Deterministic rotation using:
  - day of month
  - spent amount bucket
  - remaining percent
- `Wave` widget now renders:
  - state-based pixel `👾` character drawable
  - conditional speech bubble with pixel tail
  - compact status chip
  - monthly progress bar

## Character Expressions

| Expression | Used When |
| --- | --- |
| curious | budget not set yet |
| happy | very safe or zero-spend praise |
| smile | safe zone |
| neutral | balanced zone |
| worried | caution or tight zone |
| dizzy | over budget |
