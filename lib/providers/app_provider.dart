import 'package:flutter_riverpod/flutter_riverpod.dart';

/// 앱의 전체 설정과 상태를 관리하는 데이터 클래스
class AppState {
  final String appTitle;
  final String targetUrl;
  final bool isDarkMode;
  final bool showNavigationControls;

  const AppState({
    required this.appTitle,
    required this.targetUrl,
    required this.isDarkMode,
    required this.showNavigationControls,
  });

  AppState copyWith({
    String? appTitle,
    String? targetUrl,
    bool? isDarkMode,
    bool? showNavigationControls,
  }) {
    return AppState(
      appTitle: appTitle ?? this.appTitle,
      targetUrl: targetUrl ?? this.targetUrl,
      isDarkMode: isDarkMode ?? this.isDarkMode,
      showNavigationControls: showNavigationControls ?? this.showNavigationControls,
    );
  }
}

/// 앱 설정을 관리하는 Notifier
class AppNotifier extends StateNotifier<AppState> {
  AppNotifier() : super(const AppState(
    appTitle: 'ItsNotABug Store',
    targetUrl: 'https://www.itsnotabug.store',
    isDarkMode: false,
    showNavigationControls: true,
  ));

  /// 앱 제목 변경
  void updateAppTitle(String title) {
    state = state.copyWith(appTitle: title);
  }

  /// 대상 URL 변경
  void updateTargetUrl(String url) {
    state = state.copyWith(targetUrl: url);
  }

  /// 다크 모드 토글
  void toggleDarkMode() {
    state = state.copyWith(isDarkMode: !state.isDarkMode);
  }

  /// 네비게이션 컨트롤 표시/숨김 토글
  void toggleNavigationControls() {
    state = state.copyWith(showNavigationControls: !state.showNavigationControls);
  }
}

/// 앱 설정 Provider
final appProvider = StateNotifierProvider<AppNotifier, AppState>(
  (ref) => AppNotifier(),
);

/// 앱 제목 Provider (읽기 전용)
final appTitleProvider = Provider<String>((ref) {
  return ref.watch(appProvider).appTitle;
});

/// 대상 URL Provider (읽기 전용)
final targetUrlProvider = Provider<String>((ref) {
  return ref.watch(appProvider).targetUrl;
});

/// 다크 모드 상태 Provider (읽기 전용)
final isDarkModeProvider = Provider<bool>((ref) {
  return ref.watch(appProvider).isDarkMode;
});

/// 네비게이션 컨트롤 표시 상태 Provider (읽기 전용)
final showNavigationControlsProvider = Provider<bool>((ref) {
  return ref.watch(appProvider).showNavigationControls;
});