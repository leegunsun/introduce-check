# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Flutter WebView application named "introduceme" that displays only the www.itsnotabug.store website. The app restricts navigation to this specific domain and uses Riverpod for state management.

**Tech Stack:**
- Flutter SDK 3.7.0+
- Dart programming language
- Material Design UI components  
- WebView Flutter (webview_flutter ^4.13.0)
- Riverpod State Management (flutter_riverpod ^2.5.1)
- URL restriction and navigation control

## Development Commands

### Essential Commands
```bash
# Install dependencies
flutter pub get

# Run the app in debug mode (hot reload enabled)
flutter run

# Run on specific platform
flutter run -d chrome          # Web
flutter run -d android         # Android
flutter run -d ios             # iOS (macOS only)

# Build for release
flutter build apk              # Android APK
flutter build appbundle        # Android App Bundle
flutter build ios              # iOS (macOS only)
flutter build web              # Web

# Run tests
flutter test                   # Run all widget and unit tests
flutter test test/widget_test.dart  # Run specific test file

# Code analysis and linting
flutter analyze                # Static analysis
flutter format .               # Format code
```

### Development Workflow
```bash
# Clean build artifacts and reinstall dependencies
flutter clean && flutter pub get

# Check for outdated dependencies
flutter pub outdated

# Upgrade dependencies
flutter pub upgrade
```

## Project Structure

### Core Application Structure
- **`lib/main.dart`** - Application entry point with Riverpod ProviderScope and MaterialApp
- **`lib/providers/`** - Riverpod state management providers
  - `webview_provider.dart` - WebView state and controller management
  - `app_provider.dart` - App-level settings and configuration
- **`lib/screens/`** - UI screens
  - `webview_screen.dart` - Main WebView interface
- **`lib/widgets/`** - Reusable UI components
  - `navigation_controls.dart` - WebView navigation buttons
  - `loading_widget.dart` - Loading state indicators
  - `error_widget.dart` - Error display components
- **`test/`** - Widget and unit tests with Riverpod testing
- **`pubspec.yaml`** - Project configuration and dependencies

### Platform-Specific Code
- **`android/`** - Android-specific configuration and native code
  - `android/app/build.gradle.kts` - Android build configuration (Kotlin DSL)
  - `android/app/src/main/AndroidManifest.xml` - Android app manifest
- **`ios/`** - iOS-specific configuration and native code
  - `ios/Runner/Info.plist` - iOS app configuration
- **`web/`** - Web-specific assets and configuration
- **`windows/`, `linux/`, `macos/`** - Desktop platform configurations

### Key Configuration Files
- **`analysis_options.yaml`** - Dart/Flutter linting and analysis rules
- **`pubspec.yaml`** - Project metadata, dependencies, and assets

## Application Architecture

### Current Implementation
The app follows a Riverpod-based architecture for WebView management:

1. **Main App Class (`MyApp`)** - ConsumerWidget that configures MaterialApp with:
   - Riverpod ProviderScope wrapper
   - Dynamic theme switching (light/dark mode)
   - Blue color scheme with Material 3
   - WebViewScreen as home page

2. **WebView Screen (`WebViewScreen`)** - ConsumerStatefulWidget implementing WebView functionality with:
   - URL restriction to www.itsnotabug.store domain only
   - Navigation controls (back, forward, refresh, home)
   - Loading and error state management
   - Bottom status bar showing current URL and security status

3. **State Management Architecture:**
   - **WebViewProvider** - Manages WebView state (URL, title, loading, navigation, errors)
   - **AppProvider** - Manages app-level settings (theme, navigation controls visibility)
   - **URL Validation** - Restricts navigation to allowed domain only

4. **Key Components:**
   - **NavigationControls** - WebView navigation buttons
   - **LoadingWidget** - Loading state indicators
   - **CustomErrorWidget** - Error display and retry functionality

### Testing Strategy
- Widget tests using Flutter's testing framework
- Test coverage includes user interaction testing (tap gestures)
- Uses `WidgetTester` for UI component testing

## Development Notes

### Platform Configuration
- **Android**: 
  - Uses Kotlin, Java 11 compatibility
  - Namespace: `com.example.introduceme`
  - Internet permission enabled for WebView
  - Cleartext traffic allowed for HTTP sites
- **iOS**: 
  - Supports portrait and landscape orientations
  - App Transport Security (ATS) configured to allow arbitrary loads
  - Embedded views enabled for WebView support
- **Package Name**: `com.example.introduceme` (should be changed for production)

### WebView Configuration
- **Target Website**: www.itsnotabug.store (hardcoded, changeable in providers)
- **URL Restriction**: Navigation blocked to external domains
- **JavaScript**: Enabled for full website functionality
- **Navigation**: Back/forward buttons, refresh, and home functionality

### State Management
- **Riverpod Architecture**: All state managed through providers
- **WebView State**: URL, title, loading status, navigation capabilities, errors
- **App State**: Theme mode, navigation controls visibility, target URL
- **URL Validation**: Family provider for checking allowed domains

### Linting and Code Quality
- Uses `flutter_lints` package for code quality enforcement
- Analysis options configured to use Flutter recommended lints
- Dart code formatting follows standard Flutter conventions

### Dependencies
- **Production**: 
  - `webview_flutter` ^4.13.0 for WebView functionality
  - `flutter_riverpod` ^2.6.1 for state management
  - `cupertino_icons` for iOS-style icons
- **Development**: 
  - `flutter_lints` for code quality
  - `flutter_test` for testing
  - `flutter_launcher_icons` ^0.14.4 for app icon generation

## Common Tasks

### Modifying WebView Configuration
- **Change Target URL**: Edit `targetUrl` in `lib/providers/app_provider.dart`
- **Update URL Validation**: Modify `urlValidationProvider` in `lib/providers/webview_provider.dart`
- **Add New Allowed Domains**: Update validation logic to include additional domains

### Adding New Providers
1. Create new provider file in `lib/providers/`
2. Import `flutter_riverpod` package
3. Create StateNotifierProvider or other provider types as needed
4. Export and use in relevant widgets

### Customizing UI Components
- **Navigation Controls**: Edit `lib/widgets/navigation_controls.dart`
- **Loading States**: Modify `lib/widgets/loading_widget.dart`
- **Error Handling**: Update `lib/widgets/error_widget.dart`
- **App Theme**: Change theme configuration in `lib/main.dart`

### Adding Dependencies
1. Add dependency to `pubspec.yaml` under `dependencies:` or `dev_dependencies:`
2. Run `flutter pub get`
3. Import the package in your Dart files

### Testing WebView Functionality
- Use widget tests for UI components and state management
- WebView requires device testing for full functionality
- Test URL restriction logic with unit tests
- Validate provider state changes

### Platform-Specific Modifications
- **Android**: Modify permissions in `android/app/src/main/AndroidManifest.xml`
- **iOS**: Update settings in `ios/Runner/Info.plist`
- **Domain Security**: Adjust ATS settings for additional domains

### Debugging WebView Issues
- Enable WebView debugging in Chrome DevTools (Android)
- Use `debugPrint()` for WebView navigation events
- Check console logs for JavaScript errors
- Validate network connectivity and URL accessibility

### App Icon Management
- **Icon Location**: Place 1024x1024px icon as `assets/icon/icon.png`
- **Generate Icons**: Run `dart run flutter_launcher_icons`
- **Batch Script**: Use `generate_icons.bat` for automated generation
- **Requirements**: PNG format, square design, solid background for iOS
- **Platforms**: Automatically generates for Android, iOS, Web, Windows, macOS

### Running on Different Platforms
Ensure you have the appropriate development environment set up:
- **Android**: Android Studio/SDK, device with WebView support
- **iOS**: Xcode (macOS only), iOS 12.0+ device/simulator
- **Web**: Limited WebView functionality, use for UI testing only
- **Desktop**: Platform-specific build tools, limited WebView support