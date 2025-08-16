@echo off
echo ===============================================
echo    Flutter App Icon Generator
echo ===============================================
echo.

echo [1/4] Installing dependencies...
call flutter pub get
if errorlevel 1 (
    echo ERROR: Failed to install dependencies
    pause
    exit /b 1
)

echo.
echo [2/4] Checking for icon file...
if not exist "assets\icon\icon.png" (
    echo WARNING: Icon file not found!
    echo Please save your icon as "assets\icon\icon.png"
    echo Requirements:
    echo - Size: 1024x1024 pixels
    echo - Format: PNG
    echo - Square design with solid background
    echo.
    pause
    exit /b 1
)

echo Icon file found: assets\icon\icon.png
echo.

echo [3/4] Generating app icons for all platforms...
call dart run flutter_launcher_icons
if errorlevel 1 (
    echo ERROR: Failed to generate icons
    pause
    exit /b 1
)

echo.
echo [4/4] Cleaning project...
call flutter clean
if errorlevel 1 (
    echo WARNING: Flutter clean failed, but icons are generated
)

echo.
echo ===============================================
echo    Icon Generation Complete! 
echo ===============================================
echo.
echo Generated icons for:
echo - Android (all sizes)
echo - iOS (all sizes)
echo - Web (192px, 512px)
echo - Windows (48px)
echo - macOS (all sizes)
echo.
echo Next steps:
echo 1. Run: flutter build apk --debug
echo 2. Test your app on device/emulator
echo 3. Check that icons appear correctly
echo.
pause