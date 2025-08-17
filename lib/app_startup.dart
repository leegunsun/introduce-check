import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:ui';
import 'fcm/NotificationUtility.dart';

/// 앱 시작 시 필요한 초기화를 처리하는 위젯
class AppStartup extends ConsumerStatefulWidget {
  final Widget child;

  const AppStartup({
    super.key,
    required this.child,
  });

  @override
  ConsumerState<AppStartup> createState() => _AppStartupState();
}

class _AppStartupState extends ConsumerState<AppStartup> {
  bool _isInitialized = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  /// 앱 초기화 로직
  Future<void> _initializeApp() async {
    try {
      // FCM 알림 초기화
      final notificationUtility = NotificationUtility();
      await notificationUtility.initMessaging();
      
      // 기타 필요한 초기화 작업
      // 예: SharedPreferences 초기화, 네트워크 연결 확인 등
      
      // 시뮬레이션된 초기화 지연
      await Future.delayed(const Duration(milliseconds: 500));
      
      setState(() {
        _isInitialized = true;
      });
    } catch (e) {
      setState(() {
        _errorMessage = '앱 초기화 중 오류가 발생했습니다: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // 웹 디자인 시스템 색상 정의
    const primaryColor = Color(0xFF5AA9FF); // rgb(90, 169, 255)
    const accentBlend = Color(0xFF58C3A9); // rgb(88, 195, 169)
    const accentError = Color(0xFFEF4444); // rgb(239, 68, 68)
    const foregroundColor = Color(0xFF111827); // rgb(17, 24, 39)
    const foregroundSecondary = Color(0xFF6B7280); // rgb(107, 114, 128)
    const backgroundColor = Color(0xFFFFFFFF); // rgb(255, 255, 255)
    const backgroundSecondary = Color(0xFFF9FAFB); // rgb(249, 250, 251)

    if (_errorMessage != null) {
      return MaterialApp(
        home: Scaffold(
          backgroundColor: backgroundSecondary,
          body: Stack(
            children: [
              // 배경 그라디언트 효과 (웹 디자인 시스템과 동일)
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      primaryColor.withOpacity(0.1),
                      accentBlend.withOpacity(0.05),
                      backgroundColor,
                    ],
                  ),
                ),
              ),
              // 메인 에러 컨텐츠
              Center(
                child: TweenAnimationBuilder<double>(
                  duration: const Duration(milliseconds: 600),
                  tween: Tween(begin: 0.0, end: 1.0),
                  builder: (context, value, child) {
                    return Transform.translate(
                      offset: Offset(0, 20 * (1 - value)),
                      child: Opacity(
                        opacity: value,
                        child: Container(
                          margin: const EdgeInsets.all(32),
                          constraints: const BoxConstraints(maxWidth: 400),
                          decoration: BoxDecoration(
                            // Glass effect
                            color: backgroundColor.withOpacity(0.95),
                            borderRadius: BorderRadius.circular(24), // 1.5rem
                            border: Border.all(
                              color: const Color(0xFFE5E7EB).withOpacity(0.3),
                              width: 1,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 15,
                                offset: const Offset(0, 10),
                                spreadRadius: -3,
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(24),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                              child: SingleChildScrollView(
                                child: Padding(
                                  padding: const EdgeInsets.all(32), // 2rem (reduced)
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                    // 에러 아이콘 (웹 디자인 시스템 스타일)
                                    Container(
                                      padding: const EdgeInsets.all(20),
                                      decoration: BoxDecoration(
                                        color: accentError.withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      child: Icon(
                                        Icons.error_outline,
                                        size: 64,
                                        color: accentError,
                                      ),
                                    ),
                                    const SizedBox(height: 32),
                                    
                                    // 제목 (admin-title 스타일)
                                    Text(
                                      '초기화 실패',
                                      style: TextStyle(
                                        fontSize: 30, // 1.875rem on desktop
                                        fontWeight: FontWeight.w600, // semibold
                                        color: foregroundColor,
                                        height: 1.2,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(height: 16),
                                    
                                    // 에러 메시지 (description-text 스타일)
                                    Text(
                                      _errorMessage!,
                                      style: TextStyle(
                                        fontSize: 16, // 1rem
                                        color: foregroundSecondary,
                                        height: 1.5,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(height: 40),
                                    
                                    // 다시 시도 버튼 (웹 스타일)
                                    TweenAnimationBuilder<double>(
                                      duration: const Duration(milliseconds: 200),
                                      tween: Tween(begin: 1.0, end: 1.0),
                                      builder: (context, scale, child) {
                                        return Transform.scale(
                                          scale: scale,
                                          child: Material(
                                            color: Colors.transparent,
                                            borderRadius: BorderRadius.circular(16),
                                            child: InkWell(
                                              borderRadius: BorderRadius.circular(16),
                                              onTap: () {
                                                setState(() {
                                                  _errorMessage = null;
                                                  _isInitialized = false;
                                                });
                                                _initializeApp();
                                              },
                                              child: Container(
                                                padding: const EdgeInsets.symmetric(
                                                  horizontal: 32,
                                                  vertical: 16,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: accentBlend,
                                                  borderRadius: BorderRadius.circular(16),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.black.withOpacity(0.1),
                                                      blurRadius: 8,
                                                      offset: const Offset(0, 2),
                                                    ),
                                                  ],
                                                ),
                                                child: Row(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    const Icon(
                                                      Icons.refresh,
                                                      size: 20,
                                                      color: Colors.white,
                                                    ),
                                                    const SizedBox(width: 12),
                                                    Text(
                                                      '다시 시도',
                                                      style: const TextStyle(
                                                        fontSize: 18,
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
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      );
    }

    if (!_isInitialized) {
      return MaterialApp(
        home: Scaffold(
          backgroundColor: backgroundSecondary,
          body: Stack(
            children: [
              // 배경 그라디언트 효과
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      primaryColor.withOpacity(0.1),
                      accentBlend.withOpacity(0.05),
                      backgroundColor,
                    ],
                  ),
                ),
              ),
              // 로딩 컨텐츠
              Center(
                child: TweenAnimationBuilder<double>(
                  duration: const Duration(milliseconds: 600),
                  tween: Tween(begin: 0.0, end: 1.0),
                  builder: (context, value, child) {
                    return Transform.translate(
                      offset: Offset(0, 20 * (1 - value)),
                      child: Opacity(
                        opacity: value,
                        child: Container(
                          margin: const EdgeInsets.all(32),
                          constraints: const BoxConstraints(maxWidth: 400),
                          decoration: BoxDecoration(
                            // Glass effect
                            color: backgroundColor.withOpacity(0.95),
                            borderRadius: BorderRadius.circular(24),
                            border: Border.all(
                              color: const Color(0xFFE5E7EB).withOpacity(0.3),
                              width: 1,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 15,
                                offset: const Offset(0, 10),
                                spreadRadius: -3,
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(24),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                              child: SingleChildScrollView(
                                child: Padding(
                                  padding: const EdgeInsets.all(32), // 2rem (reduced)
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                    // 로딩 인디케이터 (웹 스타일)
                                    Container(
                                      padding: const EdgeInsets.all(20),
                                      decoration: BoxDecoration(
                                        color: primaryColor.withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      child: TweenAnimationBuilder<double>(
                                        duration: const Duration(seconds: 2),
                                        tween: Tween(begin: 0.0, end: 1.0),
                                        builder: (context, rotationValue, child) {
                                          return Transform.rotate(
                                            angle: rotationValue * 6.28318, // 2π
                                            child: Container(
                                              width: 64,
                                              height: 64,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(50),
                                                border: Border.all(
                                                  color: primaryColor.withOpacity(0.3),
                                                  width: 4,
                                                ),
                                              ),
                                              child: CircularProgressIndicator(
                                                valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                                                strokeWidth: 4,
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    const SizedBox(height: 32),
                                    
                                    // 제목
                                    Text(
                                      '앱 초기화 중',
                                      style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.w600,
                                        color: foregroundColor,
                                        height: 1.2,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(height: 16),
                                    
                                    // 설명 텍스트
                                    Text(
                                      '잠시만 기다려주세요...',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: foregroundSecondary,
                                        height: 1.5,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      );
    }

    return widget.child;
  }
}