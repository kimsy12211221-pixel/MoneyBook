# Widget Style Spec

## Goal

Add multiple 2x2 Android widget looks while keeping the same budget data model.

## Styles

| Key | Name | Visual Direction |
| --- | --- | --- |
| `calendar` | Calendar | Mini schedule card with budget status rail |
| `classic` | Classic | Clean white card with thin progress rail |
| `wave` | Soft Wave | Light green wave graphic across the lower area |
| `garden` | Garden | Small sprout illustration with budget status chip |
| `runway` | Runway | Structured track graphic with remaining percentage |

## Behavior

- All styles show:
  - title
  - remaining monthly budget
  - spent / budget caption
- Styles can be added directly from the Android launcher widget picker
- The default widget can still follow the in-app `WIDGET STYLE` setting
- Selected style is stored in app settings and synced to the Android widget host
- Widget remains `2x2` minimum size

## Technical Notes

- Flutter stores the selected style through `app_settings`
- Android widget renderer reads `budget`, `spent`, and `style` from shared preferences
- Each style maps to its own `RemoteViews` layout for easier maintenance
