# Fix Gradle Sync Issue: Task 'prepareKotlinBuildScriptModel' not found

The project is failing to sync due to a conflict in Android preference environment variables and a potentially inconsistent Gradle/AGP/Kotlin configuration. The error `Task 'prepareKotlinBuildScriptModel' not found` is a symptom of the Gradle evaluation failing early due to an `AndroidLocationsException`.

## User Review Required

> [!IMPORTANT]
> **Environment Variable Conflict:**
> Your system has both `ANDROID_PREFS_ROOT` and `ANDROID_USER_HOME` environment variables set to the same path (`C:\Users\timot\.android`). The Android Gradle Plugin (AGP) 8.11+ requires that only **one** of these be set to avoid ambiguity.
>
> **Recommended Action:** Remove the `ANDROID_PREFS_ROOT` environment variable from your Windows System Settings and keep only `ANDROID_USER_HOME`.

## Proposed Changes

### Gradle Configuration

#### [MODIFY] [gradle-wrapper.properties](file:///C:/Users/timot/Desktop/chatwit/chatwit_flutter/android/gradle/wrapper/gradle-wrapper.properties)
- Downgrade Gradle to `8.10.2` (a stable version known to work well with current Flutter/AGP releases) to rule out incompatibilities with the very recent `8.14.5`.

#### [MODIFY] [settings.gradle.kts](file:///C:/Users/timot/Desktop/chatwit/chatwit_flutter/android/settings.gradle.kts)
- Downgrade AGP to `8.7.3` and Kotlin to `2.1.0` for better stability.
- Ensure plugin IDs are consistent.

#### [MODIFY] [gradle.properties](file:///C:/Users/timot/Desktop/chatwit/chatwit_flutter/android/gradle.properties)
- Remove `android.builtInKotlin=false` and `android.newDsl=false` or set them to `true` to allow modern Kotlin DSL features, which are required for `build.gradle.kts` files to function correctly with newer AGP versions.
- Attempt to override the conflicting environment variables via system properties as a temporary workaround.

#### [MODIFY] [app/build.gradle.kts](file:///C:/Users/timot/Desktop/chatwit/chatwit_flutter/android/app/build.gradle.kts)
- Update plugin IDs to use the fully qualified names (e.g., `org.jetbrains.kotlin.android`).

## Verification Plan

### Automated Tests
- Run `./gradlew tasks` to ensure the project evaluates correctly.
- Trigger an Android Studio Gradle Sync.

### Manual Verification
- Verify that the `prepareKotlinBuildScriptModel` task is now recognized by the IDE (this happens automatically once evaluation succeeds).
