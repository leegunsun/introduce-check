import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../providers/webview_provider.dart';

/// WebView 네비게이션 컨트롤 위젯
class NavigationControls extends ConsumerWidget {
  final WebViewController controller;

  const NavigationControls({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final webViewState = ref.watch(webViewProvider);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).dividerColor,
            width: 0.5,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // 뒤로 가기 버튼
          IconButton(
            onPressed: webViewState.canGoBack ? _goBack : null,
            icon: const Icon(Icons.arrow_back_ios),
            tooltip: '뒤로 가기',
            style: IconButton.styleFrom(
              foregroundColor: webViewState.canGoBack 
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).disabledColor,
            ),
          ),
          
          // 앞으로 가기 버튼
          IconButton(
            onPressed: webViewState.canGoForward ? _goForward : null,
            icon: const Icon(Icons.arrow_forward_ios),
            tooltip: '앞으로 가기',
            style: IconButton.styleFrom(
              foregroundColor: webViewState.canGoForward 
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).disabledColor,
            ),
          ),
          
          // 새로고침 버튼
          IconButton(
            onPressed: _reload,
            icon: webViewState.isLoading 
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.refresh),
            tooltip: '새로고침',
            style: IconButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.primary,
            ),
          ),
          
          // 홈으로 가기 버튼
          IconButton(
            onPressed: _goHome,
            icon: const Icon(Icons.home),
            tooltip: '홈으로 가기',
            style: IconButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }

  /// 뒤로 가기
  Future<void> _goBack() async {
    try {
      if (await controller.canGoBack()) {
        await controller.goBack();
      }
    } catch (e) {
      debugPrint('뒤로 가기 실패: $e');
    }
  }

  /// 앞으로 가기
  Future<void> _goForward() async {
    try {
      if (await controller.canGoForward()) {
        await controller.goForward();
      }
    } catch (e) {
      debugPrint('앞으로 가기 실패: $e');
    }
  }

  /// 새로고침
  Future<void> _reload() async {
    try {
      await controller.reload();
    } catch (e) {
      debugPrint('새로고침 실패: $e');
    }
  }

  /// 홈으로 가기
  Future<void> _goHome() async {
    try {
      await controller.loadRequest(Uri.parse('https://www.itsnotabug.store'));
    } catch (e) {
      debugPrint('홈으로 가기 실패: $e');
    }
  }
}