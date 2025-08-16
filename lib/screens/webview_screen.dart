import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../fcm/FcmTokenManager.dart';
import '../providers/webview_provider.dart';
import '../providers/app_provider.dart';
import '../widgets/navigation_controls.dart';
import '../widgets/loading_widget.dart';
import '../widgets/error_widget.dart';

/// 메인 WebView 화면
class WebViewScreen extends ConsumerStatefulWidget {
  const WebViewScreen({super.key});

  @override
  ConsumerState<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends ConsumerState<WebViewScreen> {
  late WebViewController _controller;
  bool _isControllerInitialized = false;

  @override
  void initState() {
    super.initState();
    FcmTokenManager.init();
    _initializeController();
  }

  /// WebView 컨트롤러 초기화
  void _initializeController() async {
    _controller = ref.read(webViewControllerProvider);
    
    // 네비게이션 델리게이트 설정
    _controller.setNavigationDelegate(createNavigationDelegate(ref));
    
    final targetUrl = ref.read(targetUrlProvider);
    
    try {
      await _controller.loadRequest(Uri.parse(targetUrl));
      setState(() {
        _isControllerInitialized = true;
      });
    } catch (e) {
      debugPrint('WebView 초기화 실패: $e');
      ref.read(webViewProvider.notifier).setError('웹페이지를 로드할 수 없습니다.');
    }
  }

  /// 페이지 새로고침
  Future<void> _refresh() async {
    try {
      await _controller.reload();
    } catch (e) {
      debugPrint('새로고침 실패: $e');
      ref.read(webViewProvider.notifier).setError('새로고침에 실패했습니다.');
    }
  }

  @override
  Widget build(BuildContext context) {
    final webViewState = ref.watch(webViewProvider);
    final appState = ref.watch(appProvider);
    final showNavigationControls = ref.watch(showNavigationControlsProvider);

    return SafeArea(
      child: PopScope(
        canPop: false,
        child: Scaffold(
          // appBar: AppBar(
          //   title: Text(
          //     webViewState.title.isNotEmpty ? webViewState.title : appState.appTitle,
          //     overflow: TextOverflow.ellipsis,
          //   ),
          //   backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          //   actions: [
          //     // 새로고침 버튼
          //     IconButton(
          //       onPressed: _refresh,
          //       icon: const Icon(Icons.refresh),
          //       tooltip: '새로고침',
          //     ),
          //     // 설정 메뉴
          //     PopupMenuButton<String>(
          //       onSelected: (value) {
          //         switch (value) {
          //           case 'toggle_controls':
          //             ref.read(appProvider.notifier).toggleNavigationControls();
          //             break;
          //           case 'toggle_theme':
          //             ref.read(appProvider.notifier).toggleDarkMode();
          //             break;
          //           case 'test_error':
          //             // 테스트용 에러 표시
          //             ref.read(webViewProvider.notifier).setError('테스트 에러 메시지입니다. 닫기 버튼이나 배경을 터치해서 닫을 수 있습니다.');
          //             break;
          //         }
          //       },
          //       itemBuilder: (context) => [
          //         PopupMenuItem(
          //           value: 'toggle_controls',
          //           child: Text(showNavigationControls ? '네비게이션 숨기기' : '네비게이션 보이기'),
          //         ),
          //         PopupMenuItem(
          //           value: 'toggle_theme',
          //           child: Text(appState.isDarkMode ? '라이트 모드' : '다크 모드'),
          //         ),
          //         const PopupMenuItem(
          //           value: 'test_error',
          //           child: Text('에러 테스트'),
          //         ),
          //       ],
          //     ),
          //   ],
          // ),
          body: Column(
            children: [
              // 네비게이션 컨트롤 (선택적 표시)
              // if (showNavigationControls && _isControllerInitialized)
              //   NavigationControls(controller: _controller),
              
              // 메인 WebView 영역
              Expanded(
                child: Stack(
                  children: [
                    // WebView 또는 초기화 대기
                    if (_isControllerInitialized)
                      WebViewWidget(controller: _controller)
                    else
                      const Center(
                        child: CircularProgressIndicator(),
                      ),
                    
                    // 로딩 오버레이
                    if (webViewState.isLoading)
                      const LoadingWidget(),
                    
                    // 에러 오버레이
                    if (webViewState.errorMessage != null)
                      CustomErrorWidget(
                        errorMessage: webViewState.errorMessage!,
                        onRetry: () async {
                          // 에러 클리어 후 새로고침
                          ref.read(webViewProvider.notifier).clearError();
                          await Future.delayed(const Duration(milliseconds: 100)); // UI 갱신 대기
                          _refresh();
                        },
                        onDismiss: () {
                          // 즉시 에러 클리어
                          ref.read(webViewProvider.notifier).clearError();
                        },
                      ),
                  ],
                ),
              ),
            ],
          ),
          // 하단 상태 표시
          bottomNavigationBar: _buildBottomStatusBar(webViewState),
        ),
      ),
    );
  }

  /// 하단 상태 표시 바 생성
  Widget? _buildBottomStatusBar(WebViewState webViewState) {
    if (webViewState.currentUrl.isEmpty) return null;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: Theme.of(context).colorScheme.surfaceVariant,
      child: Row(
        children: [
          Icon(
            Icons.security,
            size: 16,
            color: webViewState.currentUrl.startsWith('https://') 
                ? Colors.green 
                : Colors.orange,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              webViewState.currentUrl,
              style: Theme.of(context).textTheme.bodySmall,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}