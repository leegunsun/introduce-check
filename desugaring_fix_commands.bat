@echo off
echo ===============================================
echo    Core Library Desugaring 설정 완료 후 빌드 테스트
echo ===============================================
echo.

echo [1/5] Flutter 프로젝트 완전 정리...
flutter clean
if errorlevel 1 (
    echo ERROR: Flutter clean 실패
    pause
    exit /b 1
)

echo.
echo [2/5] Android 프로젝트 정리...
cd android
gradlew clean
cd ..
if errorlevel 1 (
    echo WARNING: Android clean 실패 (계속 진행)
)

echo.
echo [3/5] 의존성 다시 설치...
flutter pub get
if errorlevel 1 (
    echo ERROR: Flutter pub get 실패
    pause
    exit /b 1
)

echo.
echo [4/5] Android 디버그 빌드 시작 (Desugaring 포함)...
flutter build apk --debug
if errorlevel 1 (
    echo ERROR: Android 빌드 실패
    echo 에러 메시지를 확인하고 추가 설정이 필요한지 확인하세요.
    pause
    exit /b 1
)

echo.
echo [5/5] 앱 실행 테스트...
flutter run --debug
if errorlevel 1 (
    echo WARNING: 앱 실행에 문제가 있을 수 있습니다
    echo 에뮬레이터나 디바이스 연결 상태를 확인하세요.
)

echo.
echo ===============================================
echo    Core Library Desugaring 설정 완료!
echo ===============================================
echo.
echo 적용된 설정:
echo - Core Library Desugaring 활성화
echo - MultiDex 활성화
echo - Desugar JDK Libs 2.1.4 추가
echo - Java 8+ API 후진 호환성 지원
echo.
echo 해결된 문제:
echo - flutter_local_notifications AAR 메타데이터 에러
echo - Java 8+ time API 호환성 문제
echo - NDK 27.0.12077973 호환성
echo.
pause