import 'package:flutter/material.dart';

/// 에러 상태를 표시하는 커스텀 위젯
class CustomErrorWidget extends StatelessWidget {
  final String errorMessage;
  final VoidCallback? onRetry;
  final VoidCallback? onDismiss;
  final IconData? icon;
  final bool showBackground;
  final bool dismissible;

  const CustomErrorWidget({
    super.key,
    required this.errorMessage,
    this.onRetry,
    this.onDismiss,
    this.icon,
    this.showBackground = true,
    this.dismissible = true,
  });

  @override
  Widget build(BuildContext context) {
    Widget errorWidget = Container(
      color: showBackground 
          ? Colors.black.withOpacity(0.5)
          : Colors.transparent,
      child: Center(
        child: GestureDetector(
          onTap: () {}, // 내부 터치는 이벤트 전파 방지
          child: Card(
            margin: const EdgeInsets.all(16),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // 닫기 버튼 (우상단)
                  if (dismissible && onDismiss != null)
                    Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        onPressed: onDismiss,
                        icon: const Icon(Icons.close),
                        tooltip: '닫기',
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(
                          minWidth: 32,
                          minHeight: 32,
                        ),
                      ),
                    ),
                // 에러 아이콘
                Icon(
                  icon ?? Icons.error_outline,
                  size: 48,
                  color: Theme.of(context).colorScheme.error,
                ),
                const SizedBox(height: 16),
                
                // 에러 제목
                Text(
                  '오류가 발생했습니다',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Theme.of(context).colorScheme.error,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                
                // 에러 메시지
                Text(
                  errorMessage,
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                
                // 버튼들
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (onDismiss != null) ...[
                      TextButton(
                        onPressed: onDismiss,
                        child: const Text('닫기'),
                      ),
                      const SizedBox(width: 8),
                    ],
                    if (onRetry != null)
                      ElevatedButton(
                        onPressed: onRetry,
                        child: const Text('다시 시도'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );

    // 배경 터치로 닫기 기능 추가
    if (dismissible && onDismiss != null) {
      errorWidget = GestureDetector(
        onTap: onDismiss,
        child: errorWidget,
      );
    }

    return errorWidget;
  }
}

/// 네트워크 에러를 위한 특화된 에러 위젯
class NetworkErrorWidget extends StatelessWidget {
  final String? message;
  final VoidCallback? onRetry;

  const NetworkErrorWidget({
    super.key,
    this.message,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return CustomErrorWidget(
      errorMessage: message ?? '인터넷 연결을 확인해주세요.',
      icon: Icons.wifi_off,
      onRetry: onRetry,
      onDismiss: () => Navigator.of(context).pop(),
    );
  }
}

/// 페이지 로드 에러를 위한 특화된 에러 위젯
class PageLoadErrorWidget extends StatelessWidget {
  final String? message;
  final VoidCallback? onRetry;
  final VoidCallback? onGoHome;

  const PageLoadErrorWidget({
    super.key,
    this.message,
    this.onRetry,
    this.onGoHome,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(0.5),
      child: Center(
        child: Card(
          margin: const EdgeInsets.all(16),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.web_asset_off,
                  size: 48,
                  color: Theme.of(context).colorScheme.error,
                ),
                const SizedBox(height: 16),
                
                Text(
                  '페이지를 로드할 수 없습니다',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Theme.of(context).colorScheme.error,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                
                Text(
                  message ?? '페이지에 접근할 수 없습니다.',
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                
                Wrap(
                  spacing: 8,
                  children: [
                    if (onGoHome != null)
                      TextButton.icon(
                        onPressed: onGoHome,
                        icon: const Icon(Icons.home),
                        label: const Text('홈으로'),
                      ),
                    if (onRetry != null)
                      ElevatedButton.icon(
                        onPressed: onRetry,
                        icon: const Icon(Icons.refresh),
                        label: const Text('다시 시도'),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// 간단한 인라인 에러 위젯
class InlineErrorWidget extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;

  const InlineErrorWidget({
    super.key,
    required this.message,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.errorContainer,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Theme.of(context).colorScheme.error,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.error_outline,
            color: Theme.of(context).colorScheme.error,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onErrorContainer,
              ),
            ),
          ),
          if (onRetry != null) ...[
            const SizedBox(width: 8),
            IconButton(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              color: Theme.of(context).colorScheme.error,
            ),
          ],
        ],
      ),
    );
  }
}