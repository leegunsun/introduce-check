# Flutter Design System Documentation

> **기준**: 웹 Admin Posts Design System (`my-next-app/ADMIN_DESIGN_SYSTEM.md`)을 Flutter로 구현한 디자인 시스템입니다. 모든 Flutter 위젯과 컴포넌트는 이 가이드라인을 따라야 합니다.

## 📋 목차

1. [디자인 토큰](#디자인-토큰)
2. [컴포넌트 아키텍처](#컴포넌트-아키텍처)
3. [레이아웃 시스템](#레이아웃-시스템)
4. [애니메이션 패턴](#애니메이션-패턴)
5. [위젯 규격](#위젯-규격)
6. [사용 예시](#사용-예시)

---

## 🎨 디자인 토큰

### 색상 시스템 (Color Tokens)

웹 디자인 시스템의 색상을 Flutter Color 객체로 변환한 표준 색상 팔레트입니다.

#### 기본 색상 (Primary Colors)
```dart
class DesignTokens {
  // 메인 브랜드 색상
  static const Color primaryColor = Color(0xFF5AA9FF);        // rgb(90, 169, 255)
  static const Color primaryForeground = Color(0xFFFFFFFF);   // rgb(255, 255, 255)
  static const Color accentBlend = Color(0xFF58C3A9);         // rgb(88, 195, 169)
}
```

#### 배경 색상 (Background Colors)
```dart
class DesignTokens {
  static const Color backgroundColor = Color(0xFFFFFFFF);          // rgb(255, 255, 255)
  static const Color backgroundSecondary = Color(0xFFF9FAFB);      // rgb(249, 250, 251)
  static const Color backgroundTertiary = Color(0xFFF3F4F6);       // rgb(243, 244, 246)
  static const Color backgroundCard = Color(0xFFFFFFFF);           // rgb(255, 255, 255)
}
```

#### 텍스트 색상 (Text Colors)
```dart
class DesignTokens {
  static const Color foregroundColor = Color(0xFF111827);          // rgb(17, 24, 39)
  static const Color foregroundSecondary = Color(0xFF6B7280);      // rgb(107, 114, 128)
  static const Color foregroundMuted = Color(0xFF9CA3AF);          // rgb(156, 163, 175)
}
```

#### 상태 색상 (Status Colors)
```dart
class DesignTokens {
  static const Color accentSuccess = Color(0xFF6CD28F);       // rgb(108, 210, 143)
  static const Color accentWarning = Color(0xFFF59E0B);       // rgb(245, 158, 11)
  static const Color accentError = Color(0xFFEF4444);         // rgb(239, 68, 68)
  static const Color accentInfo = Color(0xFF7AB4F5);          // rgb(122, 180, 245)
  static const Color accentPurple = Color(0xFFC4A7F5);        // rgb(196, 167, 245)
}
```

#### 경계선 색상 (Border Colors)
```dart
class DesignTokens {
  static const Color borderColor = Color(0xFFE5E7EB);              // rgb(229, 231, 235)
  static const Color borderSecondary = Color(0xFFF3F4F6);          // rgb(243, 244, 246)
  static const Color borderTertiary = Color(0xFFD1D5DB);           // rgb(209, 213, 219)
}
```

### 타이포그래피 (Typography)

웹 디자인 시스템의 폰트 시스템을 Flutter TextStyle로 구현합니다.

#### 제목 스타일 (Heading Styles)
```dart
class DesignTokens {
  // 페이지 제목 (AdminHeader equivalent)
  static const TextStyle adminTitle = TextStyle(
    fontSize: 24,                     // 1.5rem (mobile)
    fontWeight: FontWeight.w600,      // semibold
    color: foregroundColor,
    height: 1.2,
  );

  // 데스크톱용 큰 제목
  static const TextStyle adminTitleLarge = TextStyle(
    fontSize: 30,                     // 1.875rem (desktop)
    fontWeight: FontWeight.w600,
    color: foregroundColor,
    height: 1.2,
  );

  // 섹션 제목
  static const TextStyle sectionTitle = TextStyle(
    fontSize: 18,                     // 1.125rem
    fontWeight: FontWeight.w500,      // medium
    color: foregroundColor,
  );

  // 카드 제목
  static const TextStyle cardTitle = TextStyle(
    fontSize: 16,                     // 1rem
    fontWeight: FontWeight.w500,
    color: foregroundColor,
  );
}
```

#### 본문 텍스트 (Body Text)
```dart
class DesignTokens {
  // 기본 설명 텍스트
  static const TextStyle descriptionText = TextStyle(
    fontSize: 14,                     // 0.875rem (mobile)
    color: foregroundSecondary,
    height: 1.5,
  );

  // 데스크톱용 설명 텍스트
  static const TextStyle descriptionTextLarge = TextStyle(
    fontSize: 16,                     // 1rem (desktop)
    color: foregroundSecondary,
    height: 1.5,
  );

  // 메타 정보 텍스트
  static const TextStyle metaText = TextStyle(
    fontSize: 12,                     // 0.75rem
    color: foregroundSecondary,
    height: 1.4,
  );
}
```

### 간격 시스템 (Spacing Tokens)

웹의 rem 단위를 Flutter dp로 변환한 간격 시스템입니다.

#### 기본 간격 (Base Spacing)
```dart
class DesignTokens {
  // 기본 간격 단위 (1rem = 16dp)
  static const double spacing1 = 4;      // 0.25rem
  static const double spacing2 = 8;      // 0.5rem
  static const double spacing3 = 12;     // 0.75rem
  static const double spacing4 = 16;     // 1rem
  static const double spacing5 = 20;     // 1.25rem
  static const double spacing6 = 24;     // 1.5rem
  static const double spacing8 = 32;     // 2rem
  static const double spacing10 = 40;    // 2.5rem
  static const double spacing12 = 48;    // 3rem
}
```

#### 컨테이너 패딩 (Container Padding)
```dart
class DesignTokens {
  // 관리자 컨테이너 패딩
  static const EdgeInsets adminContainerPadding = EdgeInsets.all(24);  // 1.5rem
  static const EdgeInsets adminContainerPaddingLarge = EdgeInsets.symmetric(
    horizontal: 32,                   // 2rem (desktop)
    vertical: 24,
  );

  // 최대 너비
  static const double adminMaxWidth = 1152;  // 72rem
}
```

#### 컴포넌트 간격 (Component Spacing)
```dart
class DesignTokens {
  static const double sectionSpacing = 32;     // 2rem
  static const double cardSpacing = 16;        // 1rem
  static const double elementSpacing = 16;     // 1rem
  static const double tightSpacing = 12;       // 0.75rem
}
```

### 그림자 시스템 (Shadow Tokens)

웹 box-shadow를 Flutter BoxShadow로 구현합니다.

```dart
class DesignTokens {
  // 기본 카드 그림자
  static final List<BoxShadow> shadowCard = [
    BoxShadow(
      color: Colors.black.withOpacity(0.1),
      blurRadius: 3,
      offset: const Offset(0, 1),
      spreadRadius: 0,
    ),
    BoxShadow(
      color: Colors.black.withOpacity(0.1),
      blurRadius: 2,
      offset: const Offset(0, 1),
      spreadRadius: -1,
    ),
  ];

  // 호버 그림자
  static final List<BoxShadow> shadowHover = [
    BoxShadow(
      color: Colors.black.withOpacity(0.1),
      blurRadius: 6,
      offset: const Offset(0, 4),
      spreadRadius: -1,
    ),
    BoxShadow(
      color: Colors.black.withOpacity(0.1),
      blurRadius: 4,
      offset: const Offset(0, 2),
      spreadRadius: -2,
    ),
  ];

  // 강한 그림자 (모달, 다이얼로그)
  static final List<BoxShadow> shadowElevated = [
    BoxShadow(
      color: Colors.black.withOpacity(0.1),
      blurRadius: 15,
      offset: const Offset(0, 10),
      spreadRadius: -3,
    ),
    BoxShadow(
      color: Colors.black.withOpacity(0.1),
      blurRadius: 6,
      offset: const Offset(0, 4),
      spreadRadius: -4,
    ),
  ];
}
```

### Border Radius 시스템

웹의 border-radius를 Flutter로 구현합니다.

```dart
class DesignTokens {
  // 기본 Border Radius
  static const double radiusSmall = 8;      // 0.5rem
  static const double radiusMedium = 12;    // 0.75rem
  static const double radiusLarge = 16;     // 1rem
  static const double radiusXLarge = 24;    // 1.5rem (카드, 다이얼로그)
  static const double radiusFull = 50;      // 완전 원형

  // 자주 사용되는 BorderRadius 객체
  static final BorderRadius borderRadiusSmall = BorderRadius.circular(radiusSmall);
  static final BorderRadius borderRadiusMedium = BorderRadius.circular(radiusMedium);
  static final BorderRadius borderRadiusLarge = BorderRadius.circular(radiusLarge);
  static final BorderRadius borderRadiusXLarge = BorderRadius.circular(radiusXLarge);
}
```

---

## 🏗️ 컴포넌트 아키텍처

### Glass Effect 구현

웹의 `backdrop-filter: blur()` 효과를 Flutter로 구현하는 표준 패턴입니다.

```dart
Widget buildGlassEffect({
  required Widget child,
  double borderRadius = 24,
  double opacity = 0.95,
  double blurSigma = 10,
}) {
  return Container(
    decoration: BoxDecoration(
      color: DesignTokens.backgroundColor.withOpacity(opacity),
      borderRadius: BorderRadius.circular(borderRadius),
      border: Border.all(
        color: DesignTokens.borderColor.withOpacity(0.3),
        width: 1,
      ),
      boxShadow: DesignTokens.shadowElevated,
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
        child: child,
      ),
    ),
  );
}
```

### 배경 그라디언트 구현

웹의 `hero-gradient-bg` 효과를 Flutter로 구현합니다.

```dart
Widget buildHeroGradientBackground() {
  return Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          DesignTokens.primaryColor.withOpacity(0.1),
          DesignTokens.accentBlend.withOpacity(0.05),
          DesignTokens.backgroundColor,
        ],
      ),
    ),
  );
}
```

---

## 📐 레이아웃 시스템

### 페이지 구조 (Page Structure)

Flutter에서 웹 디자인 시스템의 페이지 레이아웃을 구현하는 표준 패턴입니다.

```dart
class AdminPageLayout extends StatelessWidget {
  final String title;
  final String? description;
  final Widget child;

  const AdminPageLayout({
    super.key,
    required this.title,
    this.description,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DesignTokens.backgroundSecondary,
      body: Stack(
        children: [
          // 배경 그라디언트 효과
          buildHeroGradientBackground(),
          
          // 메인 콘텐츠
          SafeArea(
            child: SingleChildScrollView(
              padding: DesignTokens.adminContainerPadding,
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: DesignTokens.adminMaxWidth,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 헤더 영역
                    _buildHeader(),
                    const SizedBox(height: DesignTokens.sectionSpacing),
                    
                    // 콘텐츠 영역
                    child,
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: DesignTokens.adminTitleLarge,
        ),
        if (description != null) ...[
          const SizedBox(height: 8),
          Text(
            description!,
            style: DesignTokens.descriptionTextLarge,
          ),
        ],
      ],
    );
  }
}
```

### 반응형 그리드 시스템

```dart
class ResponsiveGrid extends StatelessWidget {
  final List<Widget> children;
  final double crossAxisSpacing;
  final double mainAxisSpacing;

  const ResponsiveGrid({
    super.key,
    required this.children,
    this.crossAxisSpacing = 16,
    this.mainAxisSpacing = 16,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        int crossAxisCount = 1;
        
        if (constraints.maxWidth >= 1024) {
          crossAxisCount = 3;  // Desktop
        } else if (constraints.maxWidth >= 768) {
          crossAxisCount = 2;  // Tablet
        }
        
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: crossAxisSpacing,
            mainAxisSpacing: mainAxisSpacing,
            childAspectRatio: 1.2,
          ),
          itemCount: children.length,
          itemBuilder: (context, index) => children[index],
        );
      },
    );
  }
}
```

---

## 🎬 애니메이션 패턴

### 진입 애니메이션 (Page Entry Animation)

웹의 Framer Motion을 Flutter TweenAnimationBuilder로 구현합니다.

```dart
class FadeInUpAnimation extends StatelessWidget {
  final Widget child;
  final Duration duration;
  final double offset;
  final Duration delay;

  const FadeInUpAnimation({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 600),
    this.offset = 20,
    this.delay = Duration.zero,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      duration: duration,
      tween: Tween(begin: 0.0, end: 1.0),
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, offset * (1 - value)),
          child: Opacity(
            opacity: value,
            child: this.child,
          ),
        );
      },
    );
  }
}
```

### 스케일 호버 애니메이션

```dart
class ScaleAnimation extends StatefulWidget {
  final Widget child;
  final double scale;
  final Duration duration;

  const ScaleAnimation({
    super.key,
    required this.child,
    this.scale = 1.05,
    this.duration = const Duration(milliseconds: 200),
  });

  @override
  State<ScaleAnimation> createState() => _ScaleAnimationState();
}

class _ScaleAnimationState extends State<ScaleAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: widget.duration, vsync: this);
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: widget.scale,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _controller.forward(),
      onExit: (_) => _controller.reverse(),
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: widget.child,
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
```

### 리스트 아이템 스태거 애니메이션

```dart
class StaggeredListAnimation extends StatelessWidget {
  final List<Widget> children;
  final Duration delay;
  final Duration duration;

  const StaggeredListAnimation({
    super.key,
    required this.children,
    this.delay = const Duration(milliseconds: 50),
    this.duration = const Duration(milliseconds: 300),
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: children.asMap().entries.map((entry) {
        final index = entry.key;
        final child = entry.value;
        
        return FadeInUpAnimation(
          duration: duration,
          delay: delay * index,
          child: child,
        );
      }).toList(),
    );
  }
}
```

---

## 🧩 위젯 규격

### 1. 버튼 (Buttons)

#### 주요 액션 버튼
```dart
class PrimaryActionButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool isLoading;

  const PrimaryActionButton({
    super.key,
    required this.text,
    this.onPressed,
    this.icon,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: DesignTokens.borderRadiusLarge,
      child: InkWell(
        borderRadius: DesignTokens.borderRadiusLarge,
        onTap: isLoading ? null : onPressed,
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 32,
            vertical: 16,
          ),
          decoration: BoxDecoration(
            color: DesignTokens.accentBlend,
            borderRadius: DesignTokens.borderRadiusLarge,
            boxShadow: DesignTokens.shadowCard,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (isLoading)
                const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
              else if (icon != null)
                Icon(icon, size: 20, color: Colors.white),
              if (icon != null || isLoading) const SizedBox(width: 12),
              Text(
                text,
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
    );
  }
}
```

#### 보조 액션 버튼
```dart
class SecondaryActionButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final IconData? icon;

  const SecondaryActionButton({
    super.key,
    required this.text,
    this.onPressed,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: DesignTokens.borderRadiusLarge,
      child: InkWell(
        borderRadius: DesignTokens.borderRadiusLarge,
        onTap: onPressed,
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 12,
          ),
          decoration: BoxDecoration(
            color: DesignTokens.backgroundSecondary,
            borderRadius: DesignTokens.borderRadiusLarge,
            border: Border.all(
              color: DesignTokens.borderColor,
              width: 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[
                Icon(icon, size: 16, color: DesignTokens.foregroundColor),
                const SizedBox(width: 8),
              ],
              Text(
                text,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: DesignTokens.foregroundColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

### 2. 카드 (Cards)

#### 기본 카드 구조
```dart
class AdminCard extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;
  final bool interactive;

  const AdminCard({
    super.key,
    required this.child,
    this.onTap,
    this.interactive = true,
  });

  @override
  Widget build(BuildContext context) {
    Widget card = buildGlassEffect(
      borderRadius: DesignTokens.radiusXLarge,
      child: Padding(
        padding: DesignTokens.adminContainerPadding,
        child: child,
      ),
    );

    if (interactive && onTap != null) {
      card = ScaleAnimation(
        child: Material(
          color: Colors.transparent,
          borderRadius: DesignTokens.borderRadiusXLarge,
          child: InkWell(
            borderRadius: DesignTokens.borderRadiusXLarge,
            onTap: onTap,
            child: card,
          ),
        ),
      );
    }

    return card;
  }
}
```

### 3. 다이얼로그 (Dialogs)

#### 에러 다이얼로그 (구현됨)
```dart
// lib/widgets/error_widget.dart 참조
// 이미 웹 디자인 시스템에 맞춰 구현되어 있음
```

### 4. 로딩 상태 (Loading States)

#### 스켈레톤 로더
```dart
class SkeletonLoader extends StatefulWidget {
  final double height;
  final double? width;
  final BorderRadius? borderRadius;

  const SkeletonLoader({
    super.key,
    required this.height,
    this.width,
    this.borderRadius,
  });

  @override
  State<SkeletonLoader> createState() => _SkeletonLoaderState();
}

class _SkeletonLoaderState extends State<SkeletonLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          height: widget.height,
          width: widget.width,
          decoration: BoxDecoration(
            borderRadius: widget.borderRadius ?? DesignTokens.borderRadiusXLarge,
            gradient: LinearGradient(
              colors: [
                DesignTokens.backgroundTertiary,
                DesignTokens.backgroundSecondary,
                DesignTokens.backgroundTertiary,
              ],
              stops: [
                0.0,
                _animation.value,
                1.0,
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
```

### 5. 상태 배지 (Status Badges)

```dart
class StatusBadge extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final Color textColor;
  final IconData? icon;

  const StatusBadge({
    super.key,
    required this.text,
    required this.backgroundColor,
    required this.textColor,
    this.icon,
  });

  // 미리 정의된 상태 배지들
  factory StatusBadge.success(String text) {
    return StatusBadge(
      text: text,
      backgroundColor: DesignTokens.accentSuccess.withOpacity(0.2),
      textColor: DesignTokens.accentSuccess,
      icon: Icons.check_circle,
    );
  }

  factory StatusBadge.warning(String text) {
    return StatusBadge(
      text: text,
      backgroundColor: DesignTokens.accentWarning.withOpacity(0.2),
      textColor: DesignTokens.accentWarning,
      icon: Icons.warning,
    );
  }

  factory StatusBadge.error(String text) {
    return StatusBadge(
      text: text,
      backgroundColor: DesignTokens.accentError.withOpacity(0.2),
      textColor: DesignTokens.accentError,
      icon: Icons.error,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(50), // full rounded
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 12, color: textColor),
            const SizedBox(width: 4),
          ],
          Text(
            text,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}
```

---

## 💻 사용 예시

### 1. 기본 페이지 구성

```dart
class ExampleAdminPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AdminPageLayout(
      title: "관리자 페이지",
      description: "웹 디자인 시스템을 따르는 Flutter 페이지입니다",
      child: Column(
        children: [
          // 액션 바
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SecondaryActionButton(
                text: "필터",
                icon: Icons.filter_list,
                onPressed: () {},
              ),
              PrimaryActionButton(
                text: "새로 만들기",
                icon: Icons.add,
                onPressed: () {},
              ),
            ],
          ),
          
          const SizedBox(height: DesignTokens.sectionSpacing),
          
          // 카드 리스트
          StaggeredListAnimation(
            children: [
              AdminCard(
                onTap: () {},
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("카드 제목", style: DesignTokens.cardTitle),
                        StatusBadge.success("완료"),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "카드 설명 텍스트입니다.",
                      style: DesignTokens.descriptionText,
                    ),
                  ],
                ),
              ),
              // 더 많은 카드들...
            ],
          ),
        ],
      ),
    );
  }
}
```

### 2. 에러 처리

```dart
// CustomErrorWidget 사용 (이미 구현됨)
CustomErrorWidget(
  title: "오류 발생",
  errorMessage: "네트워크 연결을 확인해주세요.",
  onRetry: () => _retry(),
  onDismiss: () => _dismiss(),
)
```

### 3. 로딩 상태

```dart
// 스켈레톤 로더 사용
if (isLoading)
  Column(
    children: List.generate(5, (index) => 
      Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: SkeletonLoader(height: 100),
      ),
    ),
  )
else
  // 실제 콘텐츠
  _buildContent(),
```

---

## 📝 체크리스트

새로운 Flutter 위젯을 만들 때 다음 항목들을 확인하세요:

### ✅ 디자인 일관성
- [ ] `DesignTokens` 색상 사용
- [ ] 표준 타이포그래피 적용 (`DesignTokens.adminTitle` 등)
- [ ] 표준 간격 시스템 사용 (`DesignTokens.spacing*`)
- [ ] 그림자 시스템 준수 (`DesignTokens.shadow*`)

### ✅ 애니메이션
- [ ] `FadeInUpAnimation` 또는 `TweenAnimationBuilder` 사용
- [ ] 600ms 진입 애니메이션 적용
- [ ] 호버/터치 상태 정의 (`ScaleAnimation`)
- [ ] 적절한 전환 지속시간 설정

### ✅ 인터랙션
- [ ] Material InkWell 사용
- [ ] 접근성 고려 (Semantics)
- [ ] 터치 영역 최소 44x44dp
- [ ] 로딩 상태 처리

### ✅ 반응형 디자인
- [ ] LayoutBuilder 또는 MediaQuery 사용
- [ ] 모바일/태블릿/데스크톱 대응
- [ ] 터치 친화적 크기
- [ ] 적절한 여백 조정

### ✅ 성능
- [ ] 불필요한 rebuild 방지 (const 생성자)
- [ ] 애니메이션 dispose 처리
- [ ] 이미지 최적화
- [ ] 메모리 누수 방지

---

## 🔄 업데이트 이력

- **v1.0.0** (2024-12-17): 초기 Flutter 디자인 시스템 문서 작성
- **적용된 컴포넌트**: CustomErrorWidget, AppStartup, InlineErrorWidget
- 향후 변경사항은 이 섹션에 기록됩니다.

---

## 📁 파일 구조

```
lib/
├── design_system/
│   ├── tokens.dart              # DesignTokens 클래스
│   ├── components/
│   │   ├── buttons.dart         # 버튼 컴포넌트들
│   │   ├── cards.dart           # 카드 컴포넌트들
│   │   ├── dialogs.dart         # 다이얼로그 컴포넌트들
│   │   └── animations.dart      # 애니메이션 컴포넌트들
│   └── layouts/
│       └── admin_layout.dart    # AdminPageLayout
└── widgets/
    ├── error_widget.dart        # 에러 위젯들 (구현됨)
    └── ...
```

---

> **참고**: 이 문서는 웹 Admin Posts Design System을 기반으로 작성되었으며, 모든 Flutter 위젯은 이 가이드라인을 따라야 합니다. 새로운 패턴이나 컴포넌트를 추가할 때는 이 문서를 업데이트해 주세요.