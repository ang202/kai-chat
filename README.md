# kai_chat

A new Flutter project.

## Getting Started
These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.
### Prerequisites
- [Flutter SDK](https://flutter.dev/docs/get-started/install)
- [Android Studio](https://developer.android.com/studio) or [Visual Studio Code](https://code.visualstudio.com/) with Flutter extensions installed
- [OpenAI Key](https://platform.openai.com/api-keys)
- [Fastlane](https://docs.fastlane.tools/)
### Installing
1. Clone the repository to your local machine using Git or download the ZIP file.
2. Open the project in your preferred IDE.
3. Refer `.env.example` and create new files named `.env.dev`,`.env.prod`,`.env.uat`,`.env.sit` in the root directory of the project.
4. Run `flutter pub get` to install the project dependencies.
5. Run `flutter run --debug --flavor dev -t lib/main_dev.dart` to start the app in debug mode.

## Important credential for building this project

```
AuthKey.p8 (iOS Testflight), 
fastlane-supply.json (Firebase App Distribution)
```

## Building

### App Environment
```
DEV, UAT, PROD
```
### Prerequisites
Install `Fastlane` 
```
brew install fastlane (macOS)
sudo gem install fastlane (macOS/Linux/Windows)
```
For more, please visit [Fastlane Doc](https://docs.fastlane.tools/)

**To build apk:**

```
cd android
fastlane buildApk
```

**To use Firebase App Distribution:**
1. Setup Firebase
1. Include `[project]/android/app/google-service.json` from firebase
3. Create service account from [Google Cloud Console](https://console.cloud.google.com/projectselector2/iam-admin/serviceaccounts) or get it from project owener
4. Add the Firebase App Distribution Admin role.
5. Create a private json key
6. Change the json file name and include in `[project]/fastlane-supply.json`

For more, please visit [Firebase Distribution Fastlane](https://firebase.google.com/docs/app-distribution/android/distribute-fastlane)
```
cd android
fastlane firebaseDistribute
```

**To run app:**
```
flutter run --debug --flavor dev --dart-define=environment=dev -t lib/main_dev.dart
flutter run --profile --flavor sit --dart-define=environment=sit -t lib/main_sit.dart
flutter run --profile --flavor uat --dart-define=environment=uat -t lib/main_uat.dart
flutter run --release --flavor prod --dart-define=environment=prod -t lib/main.dart
```

**To build appbundle:**
1. Get the keystore file from the project owner.
2. Create a file named `[project]/android/key.properties` that contains a reference to your keystore. Don’t include the angle brackets (< >). They indicate that the text serves as a placeholder for your values.

```bash
storePassword=<password-from-previous-step>
keyPassword=<password-from-previous-step>
keyAlias=upload
storeFile=<keystore-file-location>
```

3. Run `flutter clean` to clean the build.
4. Run `flutter pub get` to install the project dependencies.
5. Refer the commands list below

```
cd android
fastlane appbundle
```

For more info, please visit https://docs.flutter.dev/deployment/android#signing-the-app

**To build ipa:**
```
// Staging UAT Testing (AppStore TestFlight)

flutter build ipa --release --flavor uat --dart-define=environment=uat -t lib/main_uat.dart

// Generate production ipa
// Do not use --obfuscate --split-debug-info in iOS because Dart is yet to support iOS. https://docs.sentry.io/platforms/flutter/upload-debug/

flutter build ipa --release --flavor prod --dart-define=environment=prod -t lib/main.dart
```

## Test Your Code
**Make sure your simulator is running before run test**

To run integration test:
```bash
flutter test integration_test/app_test.dart
```
Or you can run unit test:
```bash
flutter test test/main_test.dart
```

## Learn more about Flutter
This project is a starting point for a Flutter application.
A few resources to get you started if this is your first Flutter project:
- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)
For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
