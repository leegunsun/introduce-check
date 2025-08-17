import 'package:flutter/material.dart';

/// Design tokens class based on the Flutter Design System
/// Converts web design system colors and values to Flutter equivalents
class DesignTokens {
  // === COLORS ===
  
  // Primary Colors (Main brand colors)
  static const Color primaryColor = Color(0xFF5AA9FF);        // rgb(90, 169, 255)
  static const Color primaryForeground = Color(0xFFFFFFFF);   // rgb(255, 255, 255)
  static const Color accentBlend = Color(0xFF58C3A9);         // rgb(88, 195, 169)

  // Background Colors
  static const Color backgroundColor = Color(0xFFFFFFFF);          // rgb(255, 255, 255)
  static const Color backgroundSecondary = Color(0xFFF9FAFB);      // rgb(249, 250, 251)
  static const Color backgroundTertiary = Color(0xFFF3F4F6);       // rgb(243, 244, 246)
  static const Color backgroundCard = Color(0xFFFFFFFF);           // rgb(255, 255, 255)

  // Text Colors
  static const Color foregroundColor = Color(0xFF111827);          // rgb(17, 24, 39)
  static const Color foregroundSecondary = Color(0xFF6B7280);      // rgb(107, 114, 128)
  static const Color foregroundMuted = Color(0xFF9CA3AF);          // rgb(156, 163, 175)

  // Status Colors
  static const Color accentSuccess = Color(0xFF6CD28F);       // rgb(108, 210, 143)
  static const Color accentWarning = Color(0xFFF59E0B);       // rgb(245, 158, 11)
  static const Color accentError = Color(0xFFEF4444);         // rgb(239, 68, 68)
  static const Color accentInfo = Color(0xFF7AB4F5);          // rgb(122, 180, 245)
  static const Color accentPurple = Color(0xFFC4A7F5);        // rgb(196, 167, 245)

  // Border Colors
  static const Color borderColor = Color(0xFFE5E7EB);              // rgb(229, 231, 235)
  static const Color borderSecondary = Color(0xFFF3F4F6);          // rgb(243, 244, 246)
  static const Color borderTertiary = Color(0xFFD1D5DB);           // rgb(209, 213, 219)

  // === DARK MODE COLORS (for future implementation) ===
  
  // Dark Background Colors
  static const Color darkBackgroundColor = Color(0xFF0F172A);          // Dark slate
  static const Color darkBackgroundSecondary = Color(0xFF1E293B);      // Dark slate lighter
  static const Color darkBackgroundTertiary = Color(0xFF334155);       // Dark slate even lighter
  static const Color darkBackgroundCard = Color(0xFF1E293B);           // Dark card background

  // Dark Text Colors
  static const Color darkForegroundColor = Color(0xFFF8FAFC);          // Light text
  static const Color darkForegroundSecondary = Color(0xFFCBD5E1);      // Muted light text
  static const Color darkForegroundMuted = Color(0xFF94A3B8);          // More muted text

  // Dark Border Colors
  static const Color darkBorderColor = Color(0xFF475569);              // Dark border
  static const Color darkBorderSecondary = Color(0xFF334155);          // Darker border
  static const Color darkBorderTertiary = Color(0xFF64748B);           // Lighter dark border

  // === TYPOGRAPHY ===
  
  // Heading Styles
  static const TextStyle adminTitle = TextStyle(
    fontSize: 24,                     // 1.5rem (mobile)
    fontWeight: FontWeight.w600,      // semibold
    color: foregroundColor,
    height: 1.2,
  );

  static const TextStyle adminTitleLarge = TextStyle(
    fontSize: 30,                     // 1.875rem (desktop)
    fontWeight: FontWeight.w600,
    color: foregroundColor,
    height: 1.2,
  );

  static const TextStyle sectionTitle = TextStyle(
    fontSize: 18,                     // 1.125rem
    fontWeight: FontWeight.w500,      // medium
    color: foregroundColor,
  );

  static const TextStyle cardTitle = TextStyle(
    fontSize: 16,                     // 1rem
    fontWeight: FontWeight.w500,
    color: foregroundColor,
  );

  // Body Text
  static const TextStyle descriptionText = TextStyle(
    fontSize: 14,                     // 0.875rem (mobile)
    color: foregroundSecondary,
    height: 1.5,
  );

  static const TextStyle descriptionTextLarge = TextStyle(
    fontSize: 16,                     // 1rem (desktop)
    color: foregroundSecondary,
    height: 1.5,
  );

  static const TextStyle metaText = TextStyle(
    fontSize: 12,                     // 0.75rem
    color: foregroundSecondary,
    height: 1.4,
  );

  // Dark Mode Typography (for future use)
  static const TextStyle darkAdminTitle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: darkForegroundColor,
    height: 1.2,
  );

  static const TextStyle darkAdminTitleLarge = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.w600,
    color: darkForegroundColor,
    height: 1.2,
  );

  static const TextStyle darkSectionTitle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: darkForegroundColor,
  );

  static const TextStyle darkCardTitle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: darkForegroundColor,
  );

  static const TextStyle darkDescriptionText = TextStyle(
    fontSize: 14,
    color: darkForegroundSecondary,
    height: 1.5,
  );

  static const TextStyle darkDescriptionTextLarge = TextStyle(
    fontSize: 16,
    color: darkForegroundSecondary,
    height: 1.5,
  );

  static const TextStyle darkMetaText = TextStyle(
    fontSize: 12,
    color: darkForegroundSecondary,
    height: 1.4,
  );

  // === SPACING ===
  
  // Base Spacing (1rem = 16dp)
  static const double spacing1 = 4;      // 0.25rem
  static const double spacing2 = 8;      // 0.5rem
  static const double spacing3 = 12;     // 0.75rem
  static const double spacing4 = 16;     // 1rem
  static const double spacing5 = 20;     // 1.25rem
  static const double spacing6 = 24;     // 1.5rem
  static const double spacing8 = 32;     // 2rem
  static const double spacing10 = 40;    // 2.5rem
  static const double spacing12 = 48;    // 3rem

  // Container Padding
  static const EdgeInsets adminContainerPadding = EdgeInsets.all(24);  // 1.5rem
  static const EdgeInsets adminContainerPaddingLarge = EdgeInsets.symmetric(
    horizontal: 32,                   // 2rem (desktop)
    vertical: 24,
  );

  // Maximum Width
  static const double adminMaxWidth = 1152;  // 72rem

  // Component Spacing
  static const double sectionSpacing = 32;     // 2rem
  static const double cardSpacing = 16;        // 1rem
  static const double elementSpacing = 16;     // 1rem
  static const double tightSpacing = 12;       // 0.75rem

  // === SHADOWS ===
  
  // Basic Card Shadow
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

  // Hover Shadow
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

  // Elevated Shadow (Modals, Dialogs)
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

  // === BORDER RADIUS ===
  
  // Basic Border Radius
  static const double radiusSmall = 8;      // 0.5rem
  static const double radiusMedium = 12;    // 0.75rem
  static const double radiusLarge = 16;     // 1rem
  static const double radiusXLarge = 24;    // 1.5rem (cards, dialogs)
  static const double radiusFull = 50;      // Fully rounded

  // Frequently Used BorderRadius Objects
  static final BorderRadius borderRadiusSmall = BorderRadius.circular(radiusSmall);
  static final BorderRadius borderRadiusMedium = BorderRadius.circular(radiusMedium);
  static final BorderRadius borderRadiusLarge = BorderRadius.circular(radiusLarge);
  static final BorderRadius borderRadiusXLarge = BorderRadius.circular(radiusXLarge);

  // === HELPER METHODS ===
  
  /// Get text style based on theme mode
  static TextStyle getAdminTitle(bool isDark) {
    return isDark ? darkAdminTitle : adminTitle;
  }

  static TextStyle getAdminTitleLarge(bool isDark) {
    return isDark ? darkAdminTitleLarge : adminTitleLarge;
  }

  static TextStyle getSectionTitle(bool isDark) {
    return isDark ? darkSectionTitle : sectionTitle;
  }

  static TextStyle getCardTitle(bool isDark) {
    return isDark ? darkCardTitle : cardTitle;
  }

  static TextStyle getDescriptionText(bool isDark) {
    return isDark ? darkDescriptionText : descriptionText;
  }

  static TextStyle getDescriptionTextLarge(bool isDark) {
    return isDark ? darkDescriptionTextLarge : descriptionTextLarge;
  }

  static TextStyle getMetaText(bool isDark) {
    return isDark ? darkMetaText : metaText;
  }

  /// Get colors based on theme mode
  static Color getBackgroundColor(bool isDark) {
    return isDark ? darkBackgroundColor : backgroundColor;
  }

  static Color getBackgroundSecondary(bool isDark) {
    return isDark ? darkBackgroundSecondary : backgroundSecondary;
  }

  static Color getBackgroundTertiary(bool isDark) {
    return isDark ? darkBackgroundTertiary : backgroundTertiary;
  }

  static Color getBackgroundCard(bool isDark) {
    return isDark ? darkBackgroundCard : backgroundCard;
  }

  static Color getForegroundColor(bool isDark) {
    return isDark ? darkForegroundColor : foregroundColor;
  }

  static Color getForegroundSecondary(bool isDark) {
    return isDark ? darkForegroundSecondary : foregroundSecondary;
  }

  static Color getForegroundMuted(bool isDark) {
    return isDark ? darkForegroundMuted : foregroundMuted;
  }

  static Color getBorderColor(bool isDark) {
    return isDark ? darkBorderColor : borderColor;
  }

  static Color getBorderSecondary(bool isDark) {
    return isDark ? darkBorderSecondary : borderSecondary;
  }

  static Color getBorderTertiary(bool isDark) {
    return isDark ? darkBorderTertiary : borderTertiary;
  }
}