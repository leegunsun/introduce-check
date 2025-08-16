@echo off
echo ===============================================
echo    NDK 버전 업데이트 후 빌드 테스트
echo ===============================================
echo.

echo [1/4] Flutter 프로젝트 정리...
flutter clean
if errorlevel 1 (
    echo ERROR: Flutter clean 실패
    pause
    exit /b 1
)

echo.
echo [2/4] 의존성 다시 설치...
flutter pub get
if errorlevel 1 (
    echo ERROR: Flutter pub get 실패
    pause
    exit /b 1
)

echo.
echo [3/4] Android 디버그 빌드 시작...
flutter build apk --debug
if errorlevel 1 (
    echo ERROR: Android 빌드 실패
    echo 구체적인 에러 메시지를 확인하세요.
    pause
    exit /b 1
)

echo.
echo [4/4] 빌드 성공! 앱 실행 테스트...
flutter run --debug
if errorlevel 1 (
    echo WARNING: 앱 실행에 문제가 있을 수 있습니다
    echo 디바이스 연결 상태를 확인하세요.
)

echo.
echo ===============================================
echo    NDK 버전 업데이트 완료!
echo ===============================================
echo.
echo 변경사항:
echo - NDK 버전: 26.3.11579264 → 27.0.12077973
echo - Firebase 플러그인 호환성 해결
echo - 빌드 에러 수정 완료
echo.
pause