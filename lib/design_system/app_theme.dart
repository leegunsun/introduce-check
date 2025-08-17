import 'package:flutter/material.dart';
import 'tokens.dart';

/// App theme configuration based on the Flutter Design System
/// Provides both light and dark theme configurations
class AppTheme {
  
  /// Light theme configuration using design tokens
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      
      // === COLOR SCHEME ===
      colorScheme: const ColorScheme.light(
        // Primary colors
        primary: DesignTokens.primaryColor,
        onPrimary: DesignTokens.primaryForeground,
        primaryContainer: DesignTokens.accentBlend,
        onPrimaryContainer: DesignTokens.primaryForeground,
        
        // Secondary colors (using accent blend)
        secondary: DesignTokens.accentBlend,
        onSecondary: DesignTokens.primaryForeground,
        secondaryContainer: DesignTokens.backgroundSecondary,
        onSecondaryContainer: DesignTokens.foregroundColor,
        
        // Tertiary colors (using accent info)
        tertiary: DesignTokens.accentInfo,
        onTertiary: DesignTokens.primaryForeground,
        tertiaryContainer: DesignTokens.backgroundTertiary,
        onTertiaryContainer: DesignTokens.foregroundColor,
        
        // Error colors
        error: DesignTokens.accentError,
        onError: DesignTokens.primaryForeground,
        errorContainer: DesignTokens.accentError,
        onErrorContainer: DesignTokens.primaryForeground,
        
        // Background colors
        surface: DesignTokens.backgroundColor,
        onSurface: DesignTokens.foregroundColor,
        surfaceContainerHighest: DesignTokens.backgroundSecondary,
        surfaceContainerHigh: DesignTokens.backgroundTertiary,
        surfaceContainer: DesignTokens.backgroundCard,
        
        // Outline colors
        outline: DesignTokens.borderColor,
        outlineVariant: DesignTokens.borderSecondary,
        
        // Inverse colors
        inverseSurface: DesignTokens.foregroundColor,
        onInverseSurface: DesignTokens.backgroundColor,
        inversePrimary: DesignTokens.primaryColor,
        
        // Surface tint
        surfaceTint: DesignTokens.primaryColor,
        
        // Shadow
        shadow: Colors.black,
        scrim: Colors.black,
      ),

      // === SCAFFOLD THEME ===
      scaffoldBackgroundColor: DesignTokens.backgroundSecondary,

      // === APP BAR THEME ===
      appBarTheme: const AppBarTheme(
        backgroundColor: DesignTokens.backgroundColor,
        foregroundColor: DesignTokens.foregroundColor,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: DesignTokens.adminTitleLarge,
        iconTheme: IconThemeData(
          color: DesignTokens.foregroundColor,
          size: 24,
        ),
      ),

      // === CARD THEME ===
      cardTheme: CardTheme(
        color: DesignTokens.backgroundCard,
        shadowColor: Colors.black,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: DesignTokens.borderRadiusXLarge,
          side: const BorderSide(
            color: DesignTokens.borderColor,
            width: 1,
          ),
        ),
        margin: const EdgeInsets.all(0),
      ),

      // === ELEVATED BUTTON THEME ===
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: DesignTokens.accentBlend,
          foregroundColor: DesignTokens.primaryForeground,
          elevation: 0,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: DesignTokens.borderRadiusLarge,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: DesignTokens.spacing8,
            vertical: DesignTokens.spacing4,
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),

      // === OUTLINED BUTTON THEME ===
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          backgroundColor: DesignTokens.backgroundSecondary,
          foregroundColor: DesignTokens.foregroundColor,
          side: const BorderSide(
            color: DesignTokens.borderColor,
            width: 1,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: DesignTokens.borderRadiusLarge,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: DesignTokens.spacing6,
            vertical: DesignTokens.spacing3,
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),

      // === TEXT BUTTON THEME ===
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: DesignTokens.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: DesignTokens.borderRadiusMedium,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: DesignTokens.spacing4,
            vertical: DesignTokens.spacing2,
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),

      // === INPUT DECORATION THEME ===
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: DesignTokens.backgroundColor,
        border: OutlineInputBorder(
          borderRadius: DesignTokens.borderRadiusMedium,
          borderSide: const BorderSide(
            color: DesignTokens.borderColor,
            width: 1,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: DesignTokens.borderRadiusMedium,
          borderSide: const BorderSide(
            color: DesignTokens.borderColor,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: DesignTokens.borderRadiusMedium,
          borderSide: const BorderSide(
            color: DesignTokens.primaryColor,
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: DesignTokens.borderRadiusMedium,
          borderSide: const BorderSide(
            color: DesignTokens.accentError,
            width: 1,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: DesignTokens.borderRadiusMedium,
          borderSide: const BorderSide(
            color: DesignTokens.accentError,
            width: 2,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: DesignTokens.spacing4,
          vertical: DesignTokens.spacing3,
        ),
        labelStyle: DesignTokens.descriptionText,
        hintStyle: const TextStyle(
          color: DesignTokens.foregroundMuted,
          fontSize: 16,
        ),
        errorStyle: const TextStyle(
          color: DesignTokens.accentError,
          fontSize: 12,
        ),
      ),

      // === ICON THEME ===
      iconTheme: const IconThemeData(
        color: DesignTokens.foregroundColor,
        size: 24,
      ),

      // === TEXT THEME ===
      textTheme: const TextTheme(
        // Display styles (largest text)
        displayLarge: DesignTokens.adminTitleLarge,
        displayMedium: DesignTokens.adminTitle,
        displaySmall: DesignTokens.sectionTitle,
        
        // Headline styles
        headlineLarge: DesignTokens.adminTitleLarge,
        headlineMedium: DesignTokens.adminTitle,
        headlineSmall: DesignTokens.sectionTitle,
        
        // Title styles
        titleLarge: DesignTokens.cardTitle,
        titleMedium: DesignTokens.cardTitle,
        titleSmall: DesignTokens.cardTitle,
        
        // Body styles
        bodyLarge: DesignTokens.descriptionTextLarge,
        bodyMedium: DesignTokens.descriptionText,
        bodySmall: DesignTokens.metaText,
        
        // Label styles (buttons, chips, etc.)
        labelLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: DesignTokens.foregroundColor,
        ),
        labelMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: DesignTokens.foregroundColor,
        ),
        labelSmall: DesignTokens.metaText,
      ),

      // === DIVIDER THEME ===
      dividerTheme: const DividerThemeData(
        color: DesignTokens.borderColor,
        thickness: 1,
        space: 1,
      ),

      // === DIALOG THEME ===
      dialogTheme: DialogTheme(
        backgroundColor: DesignTokens.backgroundColor,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: DesignTokens.borderRadiusXLarge,
        ),
        elevation: 0,
        titleTextStyle: DesignTokens.adminTitle,
        contentTextStyle: DesignTokens.descriptionTextLarge,
      ),

      // === BOTTOM SHEET THEME ===
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: DesignTokens.backgroundColor,
        surfaceTintColor: Colors.transparent,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(DesignTokens.radiusXLarge),
          ),
        ),
        elevation: 0,
      ),

      // === SWITCH THEME ===
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return DesignTokens.primaryForeground;
          }
          return DesignTokens.foregroundMuted;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return DesignTokens.primaryColor;
          }
          return DesignTokens.borderColor;
        }),
      ),

      // === CHECKBOX THEME ===
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return DesignTokens.primaryColor;
          }
          return Colors.transparent;
        }),
        checkColor: WidgetStateProperty.all(DesignTokens.primaryForeground),
        side: const BorderSide(
          color: DesignTokens.borderColor,
          width: 2,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(DesignTokens.radiusSmall / 2),
        ),
      ),

      // === RADIO THEME ===
      radioTheme: RadioThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return DesignTokens.primaryColor;
          }
          return DesignTokens.borderColor;
        }),
      ),
    );
  }

  /// Dark theme configuration using design tokens (ready for future implementation)
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      
      // === COLOR SCHEME ===
      colorScheme: const ColorScheme.dark(
        // Primary colors (keep the same accent colors)
        primary: DesignTokens.primaryColor,
        onPrimary: DesignTokens.primaryForeground,
        primaryContainer: DesignTokens.accentBlend,
        onPrimaryContainer: DesignTokens.primaryForeground,
        
        // Secondary colors
        secondary: DesignTokens.accentBlend,
        onSecondary: DesignTokens.primaryForeground,
        secondaryContainer: DesignTokens.darkBackgroundSecondary,
        onSecondaryContainer: DesignTokens.darkForegroundColor,
        
        // Tertiary colors
        tertiary: DesignTokens.accentInfo,
        onTertiary: DesignTokens.primaryForeground,
        tertiaryContainer: DesignTokens.darkBackgroundTertiary,
        onTertiaryContainer: DesignTokens.darkForegroundColor,
        
        // Error colors (keep the same)
        error: DesignTokens.accentError,
        onError: DesignTokens.primaryForeground,
        errorContainer: DesignTokens.accentError,
        onErrorContainer: DesignTokens.primaryForeground,
        
        // Background colors (dark variants)
        surface: DesignTokens.darkBackgroundColor,
        onSurface: DesignTokens.darkForegroundColor,
        surfaceContainerHighest: DesignTokens.darkBackgroundSecondary,
        surfaceContainerHigh: DesignTokens.darkBackgroundTertiary,
        surfaceContainer: DesignTokens.darkBackgroundCard,
        
        // Outline colors (dark variants)
        outline: DesignTokens.darkBorderColor,
        outlineVariant: DesignTokens.darkBorderSecondary,
        
        // Inverse colors
        inverseSurface: DesignTokens.darkForegroundColor,
        onInverseSurface: DesignTokens.darkBackgroundColor,
        inversePrimary: DesignTokens.primaryColor,
        
        // Surface tint
        surfaceTint: DesignTokens.primaryColor,
        
        // Shadow
        shadow: Colors.black,
        scrim: Colors.black,
      ),

      // === SCAFFOLD THEME ===
      scaffoldBackgroundColor: DesignTokens.darkBackgroundSecondary,

      // === APP BAR THEME ===
      appBarTheme: const AppBarTheme(
        backgroundColor: DesignTokens.darkBackgroundColor,
        foregroundColor: DesignTokens.darkForegroundColor,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: DesignTokens.darkAdminTitleLarge,
        iconTheme: IconThemeData(
          color: DesignTokens.darkForegroundColor,
          size: 24,
        ),
      ),

      // === CARD THEME ===
      cardTheme: CardTheme(
        color: DesignTokens.darkBackgroundCard,
        shadowColor: Colors.black,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: DesignTokens.borderRadiusXLarge,
          side: const BorderSide(
            color: DesignTokens.darkBorderColor,
            width: 1,
          ),
        ),
        margin: const EdgeInsets.all(0),
      ),

      // === ELEVATED BUTTON THEME ===
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: DesignTokens.accentBlend,
          foregroundColor: DesignTokens.primaryForeground,
          elevation: 0,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: DesignTokens.borderRadiusLarge,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: DesignTokens.spacing8,
            vertical: DesignTokens.spacing4,
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),

      // === OUTLINED BUTTON THEME ===
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          backgroundColor: DesignTokens.darkBackgroundSecondary,
          foregroundColor: DesignTokens.darkForegroundColor,
          side: const BorderSide(
            color: DesignTokens.darkBorderColor,
            width: 1,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: DesignTokens.borderRadiusLarge,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: DesignTokens.spacing6,
            vertical: DesignTokens.spacing3,
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),

      // === TEXT BUTTON THEME ===
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: DesignTokens.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: DesignTokens.borderRadiusMedium,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: DesignTokens.spacing4,
            vertical: DesignTokens.spacing2,
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),

      // === INPUT DECORATION THEME ===
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: DesignTokens.darkBackgroundColor,
        border: OutlineInputBorder(
          borderRadius: DesignTokens.borderRadiusMedium,
          borderSide: const BorderSide(
            color: DesignTokens.darkBorderColor,
            width: 1,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: DesignTokens.borderRadiusMedium,
          borderSide: const BorderSide(
            color: DesignTokens.darkBorderColor,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: DesignTokens.borderRadiusMedium,
          borderSide: const BorderSide(
            color: DesignTokens.primaryColor,
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: DesignTokens.borderRadiusMedium,
          borderSide: const BorderSide(
            color: DesignTokens.accentError,
            width: 1,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: DesignTokens.borderRadiusMedium,
          borderSide: const BorderSide(
            color: DesignTokens.accentError,
            width: 2,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: DesignTokens.spacing4,
          vertical: DesignTokens.spacing3,
        ),
        labelStyle: DesignTokens.darkDescriptionText,
        hintStyle: const TextStyle(
          color: DesignTokens.darkForegroundMuted,
          fontSize: 16,
        ),
        errorStyle: const TextStyle(
          color: DesignTokens.accentError,
          fontSize: 12,
        ),
      ),

      // === ICON THEME ===
      iconTheme: const IconThemeData(
        color: DesignTokens.darkForegroundColor,
        size: 24,
      ),

      // === TEXT THEME ===
      textTheme: const TextTheme(
        // Display styles (largest text)
        displayLarge: DesignTokens.darkAdminTitleLarge,
        displayMedium: DesignTokens.darkAdminTitle,
        displaySmall: DesignTokens.darkSectionTitle,
        
        // Headline styles
        headlineLarge: DesignTokens.darkAdminTitleLarge,
        headlineMedium: DesignTokens.darkAdminTitle,
        headlineSmall: DesignTokens.darkSectionTitle,
        
        // Title styles
        titleLarge: DesignTokens.darkCardTitle,
        titleMedium: DesignTokens.darkCardTitle,
        titleSmall: DesignTokens.darkCardTitle,
        
        // Body styles
        bodyLarge: DesignTokens.darkDescriptionTextLarge,
        bodyMedium: DesignTokens.darkDescriptionText,
        bodySmall: DesignTokens.darkMetaText,
        
        // Label styles (buttons, chips, etc.)
        labelLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: DesignTokens.darkForegroundColor,
        ),
        labelMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: DesignTokens.darkForegroundColor,
        ),
        labelSmall: DesignTokens.darkMetaText,
      ),

      // === DIVIDER THEME ===
      dividerTheme: const DividerThemeData(
        color: DesignTokens.darkBorderColor,
        thickness: 1,
        space: 1,
      ),

      // === DIALOG THEME ===
      dialogTheme: DialogTheme(
        backgroundColor: DesignTokens.darkBackgroundColor,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: DesignTokens.borderRadiusXLarge,
        ),
        elevation: 0,
        titleTextStyle: DesignTokens.darkAdminTitle,
        contentTextStyle: DesignTokens.darkDescriptionTextLarge,
      ),

      // === BOTTOM SHEET THEME ===
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: DesignTokens.darkBackgroundColor,
        surfaceTintColor: Colors.transparent,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(DesignTokens.radiusXLarge),
          ),
        ),
        elevation: 0,
      ),

      // === SWITCH THEME ===
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return DesignTokens.primaryForeground;
          }
          return DesignTokens.darkForegroundMuted;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return DesignTokens.primaryColor;
          }
          return DesignTokens.darkBorderColor;
        }),
      ),

      // === CHECKBOX THEME ===
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return DesignTokens.primaryColor;
          }
          return Colors.transparent;
        }),
        checkColor: WidgetStateProperty.all(DesignTokens.primaryForeground),
        side: const BorderSide(
          color: DesignTokens.darkBorderColor,
          width: 2,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(DesignTokens.radiusSmall / 2),
        ),
      ),

      // === RADIO THEME ===
      radioTheme: RadioThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return DesignTokens.primaryColor;
          }
          return DesignTokens.darkBorderColor;
        }),
      ),
    );
  }

  /// Helper method to get the appropriate theme based on dark mode setting
  static ThemeData getTheme(bool isDarkMode) {
    return isDarkMode ? darkTheme : lightTheme;
  }
}