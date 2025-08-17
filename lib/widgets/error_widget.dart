import 'package:flutter/material.dart';
import 'dart:ui';
import '../design_system/tokens.dart';

/// 웹 디자인 시스템을 따르는 에러 다이얼로그 위젯
class CustomErrorWidget extends StatelessWidget {
  final String errorMessage;
  final VoidCallback? onRetry;
  final VoidCallback? onDismiss;
  final IconData? icon;
  final bool showBackground;
  final bool dismissible;
  final String? title;

  const CustomErrorWidget({
    super.key,
    required this.errorMessage,
    this.onRetry,
    this.onDismiss,
    this.icon,
    this.showBackground = true,
    this.dismissible = true,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    // Using design tokens with theme awareness
    final backgroundColor = DesignTokens.getBackgroundCard(isDark);
    final foregroundColor = DesignTokens.getForegroundColor(isDark);
    final foregroundSecondary = DesignTokens.getForegroundSecondary(isDark);
    final borderColor = DesignTokens.getBorderColor(isDark);
    final backgroundSecondary = DesignTokens.getBackgroundSecondary(isDark);
    
    Widget errorDialog = TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 300),
      tween: Tween(begin: 0.0, end: 1.0),
      builder: (context, value, child) {
        return Transform.scale(
          scale: 0.8 + (0.2 * value),
          child: Opacity(
            opacity: value,
            child: Container(
              margin: DesignTokens.adminContainerPadding,
              decoration: BoxDecoration(
                // Glass effect background using design tokens
                color: backgroundColor.withOpacity(0.95),
                borderRadius: DesignTokens.borderRadiusXLarge,
                border: Border.all(
                  color: borderColor.withOpacity(0.3),
                  width: 1,
                ),
                boxShadow: DesignTokens.shadowElevated,
              ),
              child: ClipRRect(
                borderRadius: DesignTokens.borderRadiusXLarge,
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4), // backdrop-blur-sm
                  child: Container(
                    padding: DesignTokens.adminContainerPaddingLarge,
                    constraints: const BoxConstraints(
                      maxWidth: 400,
                      minWidth: 300,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // 닫기 버튼 (우상단)
                        if (dismissible && onDismiss != null)
                          Align(
                            alignment: Alignment.topRight,
                            child: TweenAnimationBuilder<double>(
                              duration: const Duration(milliseconds: 200),
                              tween: Tween(begin: 1.0, end: 1.0),
                              builder: (context, scale, child) {
                                return Transform.scale(
                                  scale: scale,
                                  child: Material(
                                    color: Colors.transparent,
                                    borderRadius: DesignTokens.borderRadiusMedium,
                                    child: InkWell(
                                      borderRadius: DesignTokens.borderRadiusMedium,
                                      onTap: onDismiss,
                                      onTapDown: (_) {},
                                      child: Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: foregroundSecondary.withOpacity(0.1),
                                          borderRadius: DesignTokens.borderRadiusMedium,
                                        ),
                                        child: Icon(
                                          Icons.close,
                                          size: 20,
                                          color: foregroundSecondary,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        
                        const SizedBox(height: DesignTokens.spacing2),
                        
                        // 에러 아이콘 (웹 디자인 시스템 스타일)
                        Container(
                          padding: const EdgeInsets.all(DesignTokens.spacing4),
                          decoration: BoxDecoration(
                            color: DesignTokens.accentError.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(DesignTokens.radiusFull),
                          ),
                          child: Icon(
                            icon ?? Icons.error_outline,
                            size: 48,
                            color: DesignTokens.accentError,
                          ),
                        ),
                        const SizedBox(height: DesignTokens.spacing6),
                        
                        // 에러 제목 (admin-title 스타일)
                        Text(
                          title ?? '오류가 발생했습니다',
                          style: DesignTokens.getAdminTitle(isDark),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: DesignTokens.spacing3),
                        
                        // 에러 메시지 (description-text 스타일)
                        Text(
                          errorMessage,
                          style: DesignTokens.getDescriptionTextLarge(isDark),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: DesignTokens.spacing8),
                        
                        // 버튼들 (웹 디자인 시스템 스타일)
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (onDismiss != null && !dismissible) ...[
                              // 보조 버튼 (취소/닫기)
                              TweenAnimationBuilder<double>(
                                duration: const Duration(milliseconds: 200),
                                tween: Tween(begin: 1.0, end: 1.0),
                                builder: (context, scale, child) {
                                  return Transform.scale(
                                    scale: scale,
                                    child: Material(
                                      color: Colors.transparent,
                                      borderRadius: DesignTokens.borderRadiusLarge,
                                      child: InkWell(
                                        borderRadius: DesignTokens.borderRadiusLarge,
                                        onTap: onDismiss,
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: DesignTokens.spacing6,
                                            vertical: DesignTokens.spacing3,
                                          ),
                                          decoration: BoxDecoration(
                                            color: backgroundSecondary,
                                            borderRadius: DesignTokens.borderRadiusLarge,
                                            border: Border.all(
                                              color: borderColor,
                                              width: 1,
                                            ),
                                          ),
                                          child: Text(
                                            '닫기',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              color: foregroundColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                              const SizedBox(width: DesignTokens.spacing3),
                            ],
                            if (onRetry != null)
                              // 주요 액션 버튼
                              TweenAnimationBuilder<double>(
                                duration: const Duration(milliseconds: 200),
                                tween: Tween(begin: 1.0, end: 1.0),
                                builder: (context, scale, child) {
                                  return Transform.scale(
                                    scale: scale,
                                    child: Material(
                                      color: Colors.transparent,
                                      borderRadius: DesignTokens.borderRadiusLarge,
                                      child: InkWell(
                                        borderRadius: DesignTokens.borderRadiusLarge,
                                        onTap: onRetry,
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: DesignTokens.spacing8,
                                            vertical: DesignTokens.spacing4,
                                          ),
                                          decoration: BoxDecoration(
                                            color: DesignTokens.accentBlend,
                                            borderRadius: DesignTokens.borderRadiusLarge,
                                            boxShadow: DesignTokens.shadowCard,
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              const Icon(
                                                Icons.refresh,
                                                size: 20,
                                                color: Colors.white,
                                              ),
                                              const SizedBox(width: DesignTokens.spacing2),
                                              Text(
                                                '다시 시도',
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );

    Widget backgroundOverlay = Container(
      color: showBackground 
          ? Colors.black.withOpacity(0.5)
          : Colors.transparent,
      child: Center(
        child: GestureDetector(
          onTap: () {}, // 내부 터치는 이벤트 전파 방지
          child: errorDialog,
        ),
      ),
    );

    // 배경 터치로 닫기 기능 추가
    if (dismissible && onDismiss != null) {
      backgroundOverlay = GestureDetector(
        onTap: onDismiss,
        child: backgroundOverlay,
      );
    }

    return backgroundOverlay;
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
      title: '네트워크 연결 오류',
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
    return CustomErrorWidget(
      title: '페이지 로드 실패',
      errorMessage: message ?? '페이지에 접근할 수 없습니다.',
      icon: Icons.web_asset_off,
      onRetry: onRetry,
      onDismiss: onGoHome,
    );
  }
}

/// 간단한 인라인 에러 위젯 (웹 디자인 시스템 스타일)
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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    // Using design tokens with theme awareness
    final backgroundColor = DesignTokens.getBackgroundCard(isDark);
    final foregroundColor = DesignTokens.getForegroundColor(isDark);
    
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 300),
      tween: Tween(begin: 0.0, end: 1.0),
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, 8 * (1 - value)),
          child: Opacity(
            opacity: value,
            child: Container(
              padding: const EdgeInsets.all(DesignTokens.spacing4),
              margin: const EdgeInsets.all(DesignTokens.spacing2),
              decoration: BoxDecoration(
                // Glass effect background using design tokens
                color: backgroundColor.withOpacity(0.95),
                borderRadius: DesignTokens.borderRadiusLarge,
                border: Border.all(
                  color: DesignTokens.accentError.withOpacity(0.3),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: DesignTokens.accentError.withOpacity(0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(DesignTokens.spacing2),
                    decoration: BoxDecoration(
                      color: DesignTokens.accentError.withOpacity(0.2),
                      borderRadius: DesignTokens.borderRadiusSmall,
                    ),
                    child: Icon(
                      Icons.error_outline,
                      color: DesignTokens.accentError,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: DesignTokens.spacing3),
                  Expanded(
                    child: Text(
                      message,
                      style: TextStyle(
                        fontSize: 14,
                        color: foregroundColor,
                        height: 1.5,
                      ),
                    ),
                  ),
                  if (onRetry != null) ...[
                    const SizedBox(width: DesignTokens.spacing2),
                    Material(
                      color: Colors.transparent,
                      borderRadius: DesignTokens.borderRadiusSmall,
                      child: InkWell(
                        borderRadius: DesignTokens.borderRadiusSmall,
                        onTap: onRetry,
                        child: Container(
                          padding: const EdgeInsets.all(DesignTokens.spacing2),
                          decoration: BoxDecoration(
                            color: DesignTokens.accentError.withOpacity(0.1),
                            borderRadius: DesignTokens.borderRadiusSmall,
                          ),
                          child: Icon(
                            Icons.refresh,
                            color: DesignTokens.accentError,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}