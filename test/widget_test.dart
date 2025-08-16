// WebView 앱을 위한 위젯 테스트
//
// WebView는 플랫폼 채널을 사용하므로 실제 테스트 환경에서는 제한적입니다.
// 여기서는 앱의 기본 구조와 상태 관리가 올바르게 작동하는지 테스트합니다.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:introduceme/main.dart';
import 'package:introduceme/providers/app_provider.dart';
import 'package:introduceme/providers/webview_provider.dart';

void main() {
  group('WebView App Tests', () {
    testWidgets('앱이 정상적으로 빌드되는지 테스트', (WidgetTester tester) async {
      // 앱을 빌드하고 첫 프레임을 렌더링
      await tester.pumpWidget(const MyApp());

      // 앱이 정상적으로 로드되는지 확인
      expect(find.byType(MaterialApp), findsOneWidget);
    });

    testWidgets('앱 제목이 올바르게 표시되는지 테스트', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());

      // 앱 제목 확인 (AppBar 또는 기본 제목)
      expect(find.text('ItsNotABug Store'), findsAtLeastOneWidget);
    });

    testWidgets('Provider 상태가 올바르게 초기화되는지 테스트', (WidgetTester tester) async {
      late WidgetRef ref;
      
      await tester.pumpWidget(
        ProviderScope(
          child: Consumer(
            builder: (context, widgetRef, child) {
              ref = widgetRef;
              return MaterialApp(
                home: Scaffold(
                  body: Container(), // 간단한 테스트용 위젯
                ),
              );
            },
          ),
        ),
      );

      // 앱 상태 확인
      final appState = ref.read(appProvider);
      expect(appState.appTitle, 'ItsNotABug Store');
      expect(appState.targetUrl, 'https://www.itsnotabug.store');
      expect(appState.isDarkMode, false);
      expect(appState.showNavigationControls, true);

      // WebView 상태 확인
      final webViewState = ref.read(webViewProvider);
      expect(webViewState.title, 'ItsNotABug Store');
      expect(webViewState.isLoading, false);
      expect(webViewState.canGoBack, false);
      expect(webViewState.canGoForward, false);
    });

    testWidgets('다크 모드 토글이 작동하는지 테스트', (WidgetTester tester) async {
      late WidgetRef ref;
      
      await tester.pumpWidget(
        ProviderScope(
          child: Consumer(
            builder: (context, widgetRef, child) {
              ref = widgetRef;
              return const MyApp();
            },
          ),
        ),
      );

      // 초기 상태 확인
      expect(ref.read(appProvider).isDarkMode, false);

      // 다크 모드 토글
      ref.read(appProvider.notifier).toggleDarkMode();
      await tester.pump();

      // 변경된 상태 확인
      expect(ref.read(appProvider).isDarkMode, true);
    });

    testWidgets('URL 검증 로직이 올바르게 작동하는지 테스트', (WidgetTester tester) async {
      late WidgetRef ref;
      
      await tester.pumpWidget(
        ProviderScope(
          child: Consumer(
            builder: (context, widgetRef, child) {
              ref = widgetRef;
              return const MyApp();
            },
          ),
        ),
      );

      // 허용된 URL 테스트
      final allowedUrl = 'https://www.itsnotabug.store';
      final allowedSubPath = 'https://www.itsnotabug.store/products';
      final blockedUrl = 'https://www.google.com';

      expect(ref.read(urlValidationProvider(allowedUrl)), true);
      expect(ref.read(urlValidationProvider(allowedSubPath)), true);
      expect(ref.read(urlValidationProvider(blockedUrl)), false);
    });

    testWidgets('네비게이션 컨트롤 토글이 작동하는지 테스트', (WidgetTester tester) async {
      late WidgetRef ref;
      
      await tester.pumpWidget(
        ProviderScope(
          child: Consumer(
            builder: (context, widgetRef, child) {
              ref = widgetRef;
              return const MyApp();
            },
          ),
        ),
      );

      // 초기 상태 확인
      expect(ref.read(appProvider).showNavigationControls, true);

      // 네비게이션 컨트롤 토글
      ref.read(appProvider.notifier).toggleNavigationControls();
      await tester.pump();

      // 변경된 상태 확인
      expect(ref.read(appProvider).showNavigationControls, false);
    });

    testWidgets('WebView 에러 상태 관리가 올바르게 작동하는지 테스트', (WidgetTester tester) async {
      late WidgetRef ref;
      
      await tester.pumpWidget(
        ProviderScope(
          child: Consumer(
            builder: (context, widgetRef, child) {
              ref = widgetRef;
              return const MyApp();
            },
          ),
        ),
      );

      // 초기 상태 확인 (에러 없음)
      expect(ref.read(webViewProvider).errorMessage, null);

      // 에러 설정
      const testError = '테스트 에러 메시지';
      ref.read(webViewProvider.notifier).setError(testError);
      await tester.pump();

      // 에러 상태 확인
      expect(ref.read(webViewProvider).errorMessage, testError);

      // 에러 클리어
      ref.read(webViewProvider.notifier).clearError();
      await tester.pump();

      // 에러가 클리어되었는지 확인
      expect(ref.read(webViewProvider).errorMessage, null);
    });
  });
}
