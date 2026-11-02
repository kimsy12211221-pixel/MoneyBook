# Play Store Release Checklist

## Purpose

Personal Spending App first-release checklist for Google Play. Mark each item
only after it has been verified in a release build or Play Console.

## 1. Product Readiness

- [ ] Home monthly-budget button opens the monthly budget editor.
- [ ] Upcoming expense rows support an intentional action: edit, delete, or are
  clearly presented as non-interactive.
- [ ] Transaction and upcoming-expense forms show clear validation messages for
  missing or invalid required values.
- [ ] Category budgets show remaining amount and spending progress in the app.
- [ ] Bulk budget import shows a preview, validation errors, and the final
  applied result.
- [ ] Widget can be added from the launcher on at least two Android devices.
- [ ] Each widget style renders correctly with no budget, normal budget, and
  over-budget data.
- [ ] Exported data can be shared outside the app and restored on a fresh
  install, or the app clearly explains that export is local-only.
- [ ] Reset data has a confirmation step and explains that it cannot be undone.
- [ ] All user-visible copy is Korean, except deliberate product labels.

## 2. Quality Assurance

- [ ] `flutter analyze` passes.
- [ ] `flutter test` passes.
- [ ] A debug build installs and launches on a physical Android device.
- [ ] A release build installs and launches on a physical Android device.
- [ ] Test onboarding: set monthly budget, skip/add an upcoming expense, and
  reach Home.
- [ ] Test daily use: add, edit, and delete a transaction.
- [ ] Test budget behavior: normal, near-limit, and over-budget states.
- [ ] Test categories: edit category, set category budget, and run bulk import.
- [ ] Test data safety: export, reset, reinstall, and restore if restore is
  supported.
- [ ] Test device rotation, large font size, dark system setting, and Android
  back navigation.
- [ ] Run Play Console pre-launch report from the internal test track.

## 3. Android Release Configuration

- [ ] Choose a final app name and replace `personal_spending_app`.
- [ ] Choose a permanent unique application ID. Do not use
  `com.example.personal_spending_app` for the published app.
- [ ] Replace the default launcher icon with the final app icon.
- [ ] Set the production version in `pubspec.yaml`, for example `1.0.0+1`.
- [ ] Increment `versionCode` for every subsequent Play upload.
- [ ] Create a release upload key and keep its keystore and passwords outside
  the repository.
- [ ] Configure the release signing config. The release build must not use the
  debug signing key.
- [ ] Confirm the app targets Android API level 36 or newer.
- [ ] Build the signed app bundle with `flutter build appbundle --release`.
- [ ] Keep the generated `.aab` and mapping files for the release record.

## 4. Privacy And Policy

- [ ] Publish a public privacy-policy web page before creating the store
  listing. It must explain that spending data is stored locally, whether any
  data leaves the device, and how export/reset works.
- [ ] Add the privacy-policy link inside the app as well as in Play Console.
- [ ] Complete Data safety in Play Console. Verify every Flutter package and
  native dependency before declaring that no data is collected or shared.
- [ ] Declare that the app does not contain ads, unless an ad SDK is added.
- [ ] Complete Target audience and content.
- [ ] Complete the IARC content-rating questionnaire.
- [ ] Confirm there are no restricted permissions or undeclared sensitive APIs.
- [ ] Provide reviewer access instructions if any future version requires login.

## 5. Store Listing Assets

- [ ] Final app name.
- [ ] Developer support email address.
- [ ] Short description, up to 80 characters.
- [ ] Full Korean description with the app's core value, local-data behavior,
  widget, category budgets, and bulk input.
- [ ] Store icon: 512 x 512 PNG with alpha, under 1 MB.
- [ ] Feature graphic: 1024 x 500 JPEG or 24-bit PNG without alpha.
- [ ] At least 2 real device screenshots; prepare 4 portrait screenshots at
  1080 x 1920 for stronger store presentation.
- [ ] Screenshot sequence: Home budget view, quick expense entry, category
  budget management, and the Tamagotchi widget.
- [ ] Review every screenshot for personal spending data, notifications, and
  status-bar information before upload.

## 6. Testing And Launch

- [ ] Create the app in Play Console and accept Play App Signing.
- [ ] Upload the signed `.aab` to Internal testing first.
- [ ] Verify installation, updates, widgets, and database migration through
  Google Play delivery.
- [ ] Create a Closed testing track and collect feedback.
- [ ] For personal developer accounts created after 2023-11-13: retain at least
  12 opted-in closed testers for 14 continuous days before applying for
  production access.
- [ ] Record tester feedback, fixes, and the test scenarios each tester used.
- [ ] Apply for production access and answer the testing/readiness questions.
- [ ] Start production with a staged rollout, then review crashes, ANRs, and
  user feedback before increasing rollout.

## Current Known Gaps

- [ ] Release build still uses the debug signing key.
- [ ] Application ID is still `com.example.personal_spending_app`.
- [ ] Display name is still `personal_spending_app`.
- [ ] Home monthly-budget button currently has no action.
- [ ] Upcoming-expense row tap currently has no action.
- [ ] Data export is saved inside app storage and is not yet shareable or
  restorable.
- [ ] No public privacy-policy URL is configured.
- [ ] Store icon, feature graphic, and store screenshots are not prepared.

## Useful Official References

- Target API requirement: https://developer.android.com/google/play/requirements/target-sdk
- Data safety: https://support.google.com/googleplay/android-developer/answer/10787469
- App content and privacy policy: https://support.google.com/googleplay/android-developer/answer/9859455
- Store listing assets: https://support.google.com/googleplay/android-developer/answer/9866151
- Personal account test requirement: https://support.google.com/googleplay/android-developer/answer/14151465
