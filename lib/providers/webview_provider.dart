import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'auth_provider.dart';

/// WebView 상태를 관리하는 데이터 클래스
class WebViewState {
  final String currentUrl;
  final String title;
  final bool isLoading;
  final bool canGoBack;
  final bool canGoForward;
  final String? errorMessage;

  final String FORCENULL = "__FORCE_NULL__";
  final int? errorCount;

  const WebViewState({
    required this.currentUrl,
    required this.title,
    required this.isLoading,
    required this.canGoBack,
    required this.canGoForward,
    this.errorMessage,
    this.errorCount
  });

  WebViewState copyWith({
    String? currentUrl,
    String? title,
    bool? isLoading,
    bool? canGoBack,
    bool? canGoForward,
    String? errorMessage,
    int? errorCount
  }) {
    return WebViewState(
      currentUrl: currentUrl ?? this.currentUrl,
      title: title ?? this.title,
      isLoading: isLoading ?? this.isLoading,
      canGoBack: canGoBack ?? this.canGoBack,
      canGoForward: canGoForward ?? this.canGoForward,
      errorMessage: errorMessage == FORCENULL ? null : errorMessage ?? this.errorMessage,
    );
  }

  WebViewState clearError() {
    return copyWith(errorMessage: FORCENULL);
  }
}

/// WebView 상태를 관리하는 Notifier
class WebViewNotifier extends StateNotifier<WebViewState> {
  WebViewNotifier() : super(const WebViewState(
    currentUrl: '',
    title: 'ItsNotABug Store',
    isLoading: false,
    canGoBack: false,
    canGoForward: false,
  ));

  /// URL이 변경되었을 때 호출
  void updateUrl(String url) {
    state = state.copyWith(currentUrl: url);
  }

  /// 페이지 제목이 변경되었을 때 호출
  void updateTitle(String title) {
    state = state.copyWith(title: title);
  }

  /// 로딩 상태를 변경
  void setLoading(bool isLoading) {
    state = state.copyWith(isLoading: isLoading);
  }

  /// 에러 카운트
  int setErrorCounter([int? setCount]) {
    int currentCount = state.errorCount ?? setCount ?? 0;
    currentCount += 1;
    state = state.copyWith(errorCount: currentCount);

    return state.errorCount ?? 0;
  }

  /// 네비게이션 상태를 업데이트
  void updateNavigationState(bool canGoBack, bool canGoForward) {
    state = state.copyWith(
      canGoBack: canGoBack,
      canGoForward: canGoForward,
    );
  }

  /// 에러 메시지를 설정
  void setError(String errorMessage) {
    state = state.copyWith(errorMessage: errorMessage);
  }

  /// 에러를 클리어
  void clearError() {
    state = state.clearError();
  }
}

/// WebView 상태 관리 Provider
final webViewProvider = StateNotifierProvider<WebViewNotifier, WebViewState>(
  (ref) => WebViewNotifier(),
);

/// WebViewController를 생성하는 Provider (기본 설정만)
final webViewControllerProvider = Provider<WebViewController>((ref) {
  final controller = WebViewController();
  
  // 기본 설정
  controller.setJavaScriptMode(JavaScriptMode.unrestricted);
  
  // Authentication bridge 초기화 (비동기)
  Future.microtask(() async {
    try {
      debugPrint('🌉 Initializing authentication bridge with WebView controller...');
      final authNotifier = ref.read(authProvider.notifier);
      await authNotifier.initializeBridge(controller);
      debugPrint('🌉 ✅ Authentication bridge initialized successfully');
    } catch (e) {
      debugPrint('🌉 ❌ Failed to initialize authentication bridge: $e');
    }
  });
  
  return controller;
});

/// WebView 네비게이션 델리게이트를 설정하는 함수
NavigationDelegate createNavigationDelegate(WidgetRef ref) {
  return NavigationDelegate(
    onPageStarted: (String url) {
      debugPrint('페이지 로딩 시작: $url');
      ref.read(webViewProvider.notifier).updateUrl(url);
      ref.read(webViewProvider.notifier).setLoading(true);
      ref.read(webViewProvider.notifier).clearError();
    },
    onPageFinished: (String url) async {
      debugPrint('페이지 로딩 완료: $url');
      ref.read(webViewProvider.notifier).setLoading(false);
      
      // 페이지 제목 가져오기
      try {
        final controller = ref.read(webViewControllerProvider);
        final title = await controller.getTitle();
        if (title != null && title.isNotEmpty) {
          ref.read(webViewProvider.notifier).updateTitle(title);
        }
      } catch (e) {
        debugPrint('제목 가져오기 실패: $e');
      }
      
      // 네비게이션 상태 업데이트
      try {
        final controller = ref.read(webViewControllerProvider);
        final canGoBack = await controller.canGoBack();
        final canGoForward = await controller.canGoForward();
        ref.read(webViewProvider.notifier).updateNavigationState(canGoBack, canGoForward);
      } catch (e) {
        debugPrint('네비게이션 상태 업데이트 실패: $e');
      }
      
      // Authentication bridge JavaScript injection
      try {
        final authNotifier = ref.read(authProvider.notifier);
        await authNotifier.bridgeService.injectJavaScriptFunctions();
        debugPrint('🌉 ✅ Authentication bridge functions injected after page load');
      } catch (e) {
        debugPrint('🌉 ❌ Failed to inject authentication bridge functions: $e');
      }
    },
    onWebResourceError: (WebResourceError error) {
      debugPrint('웹 리소스 에러: ${error.description}');

      int updateCount = ref.read(webViewProvider.notifier).setErrorCounter();

      if(updateCount > 5) {
        ref.read(webViewProvider.notifier).setError(error.description);
        ref.read(webViewProvider.notifier).setLoading(false);
      } else {
        ref.read(webViewProvider.notifier).setErrorCounter(0);
      }


    },
    onNavigationRequest: (NavigationRequest request) {
      // URL 제한 로직
      if (ref.read(urlValidationProvider(request.url))) {
        debugPrint('허용된 URL로 네비게이션: ${request.url}');
        return NavigationDecision.navigate;
      } else {
        debugPrint('차단된 URL: ${request.url}');
        ref.read(webViewProvider.notifier).setError('허용되지 않은 페이지입니다.');
        return NavigationDecision.prevent;
      }
    },
  );
}

/// 허용된 기본 URL Provider
final allowedUrlProvider = Provider<String>((ref) => 'https://www.itsnotabug.store');

/// URL 유효성 검사 Provider
final urlValidationProvider = Provider.family<bool, String>((ref, url) {
  final allowedUrl = ref.watch(allowedUrlProvider);
  
  // 기본 URL과 그 하위 경로만 허용
  return url.startsWith(allowedUrl) || url.startsWith(allowedUrl.replaceFirst('https://', 'http://'));
});