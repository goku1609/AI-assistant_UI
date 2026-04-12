// // // /// lib/config/theme/app_theme.dart
// // // ///
// // // /// Complete theme configuration for the Authenticator app.
// // // /// Provides light and dark themes with yellow primary color.
// // // ///
// // //
// // //
// // // import 'app_colors.dart';
// // // import 'app_text_styles.dart';
// // //import 'package:flutter/material.dart';
// // // class AppTheme {
// // //   // Private constructor to prevent instantiation
// // //   AppTheme._();
// // //
// // //   // ============================================================================
// // //   // LIGHT THEME
// // //   // ============================================================================
// // //
// // //   /// Build light theme for the app
// // //   static ThemeData get lightTheme {
// // //     return ThemeData(
// // //       useMaterial3: true,
// // //       brightness: Brightness.light,
// // //
// // //       // Color scheme
// // //       colorScheme: AppColors.lightColorScheme,
// // //
// // //       // Primary colors
// // //       primaryColor: AppColors.primary,
// // //       primaryColorDark: AppColors.primaryDark,
// // //       primaryColorLight: AppColors.primaryLight,
// // //       scaffoldBackgroundColor: AppColors.background,
// // //
// // //       // ========================================================================
// // //       // APP BAR THEME
// // //       // ========================================================================
// // //       appBarTheme: AppBarTheme(
// // //         elevation: 0,
// // //         backgroundColor: AppColors.white,
// // //         foregroundColor: AppColors.textPrimary,
// // //         surfaceTintColor: AppColors.white,
// // //         centerTitle: true,
// // //         titleTextStyle: AppTextStyles.headlineLarge.copyWith(
// // //           color: AppColors.textPrimary,
// // //         ),
// // //         iconTheme: const IconThemeData(
// // //           color: AppColors.textPrimary,
// // //           size: 24,
// // //         ),
// // //         toolbarHeight: 56,
// // //       ),
// // //
// // //       // ========================================================================
// // //       // TEXT FIELD (INPUT DECORATION) THEME
// // //       // ========================================================================
// // //       inputDecorationTheme: InputDecorationTheme(
// // //         filled: true,
// // //         fillColor: AppColors.lightGray,
// // //         contentPadding: const EdgeInsets.symmetric(
// // //           horizontal: 16,
// // //           vertical: 14,
// // //         ),
// // //         isDense: false,
// // //
// // //         // Border styles
// // //         border: OutlineInputBorder(
// // //           borderRadius: BorderRadius.circular(12),
// // //           borderSide: const BorderSide(
// // //             color: AppColors.textHint,
// // //             width: 1,
// // //           ),
// // //         ),
// // //         enabledBorder: OutlineInputBorder(
// // //           borderRadius: BorderRadius.circular(12),
// // //           borderSide: const BorderSide(
// // //             color: AppColors.textHint,
// // //             width: 1,
// // //           ),
// // //         ),
// // //         focusedBorder: OutlineInputBorder(
// // //           borderRadius: BorderRadius.circular(12),
// // //           borderSide: const BorderSide(
// // //             color: AppColors.primary,
// // //             width: 2,
// // //           ),
// // //         ),
// // //         errorBorder: OutlineInputBorder(
// // //           borderRadius: BorderRadius.circular(12),
// // //           borderSide: const BorderSide(
// // //             color: AppColors.error,
// // //             width: 1,
// // //           ),
// // //         ),
// // //         focusedErrorBorder: OutlineInputBorder(
// // //           borderRadius: BorderRadius.circular(12),
// // //           borderSide: const BorderSide(
// // //             color: AppColors.error,
// // //             width: 2,
// // //           ),
// // //         ),
// // //         disabledBorder: OutlineInputBorder(
// // //           borderRadius: BorderRadius.circular(12),
// // //           borderSide: const BorderSide(
// // //             color: AppColors.mediumGray,
// // //             width: 1,
// // //           ),
// // //         ),
// // //
// // //         // Text styles
// // //         hintStyle: AppTextStyles.inputHint,
// // //         labelStyle: AppTextStyles.inputLabel,
// // //         errorStyle: AppTextStyles.errorMessage.copyWith(height: 1.2),
// // //         helperStyle: AppTextStyles.bodySmall.copyWith(
// // //           color: AppColors.textSecondary,
// // //         ),
// // //
// // //         // Prefix/Suffix icon colors
// // //         prefixIconColor: AppColors.textSecondary,
// // //         suffixIconColor: AppColors.textSecondary,
// // //         prefixStyle: AppTextStyles.bodyMedium,
// // //         suffixStyle: AppTextStyles.bodyMedium,
// // //
// // //         // Counter style
// // //         counterStyle: AppTextStyles.bodySmall,
// // //
// // //         // Floated label behavior
// // //         floatingLabelBehavior: FloatingLabelBehavior.auto,
// // //       ),
// // //
// // //       // ========================================================================
// // //       // ELEVATED BUTTON THEME
// // //       // ========================================================================
// // //       elevatedButtonTheme: ElevatedButtonThemeData(
// // //         style: ElevatedButton.styleFrom(
// // //           backgroundColor: AppColors.primary,
// // //           foregroundColor: AppColors.white,
// // //           disabledBackgroundColor: AppColors.mediumGray,
// // //           disabledForegroundColor: AppColors.white.withOpacity(0.5),
// // //           elevation: 2,
// // //           shadowColor: AppColors.primary.withOpacity(0.3),
// // //           padding: const EdgeInsets.symmetric(
// // //             horizontal: 24,
// // //             vertical: 14,
// // //           ),
// // //           shape: RoundedRectangleBorder(
// // //             borderRadius: BorderRadius.circular(12),
// // //           ),
// // //           textStyle: AppTextStyles.primaryButton,
// // //           animationDuration: const Duration(milliseconds: 200),
// // //         ),
// // //       ),
// // //
// // //       // ========================================================================
// // //       // OUTLINED BUTTON THEME
// // //       // ========================================================================
// // //       outlinedButtonTheme: OutlinedButtonThemeData(
// // //         style: OutlinedButton.styleFrom(
// // //           foregroundColor: AppColors.primary,
// // //           side: const BorderSide(
// // //             color: AppColors.primary,
// // //             width: 2,
// // //           ),
// // //           disabledForegroundColor: AppColors.mediumGray,
// // //           padding: const EdgeInsets.symmetric(
// // //             horizontal: 24,
// // //             vertical: 14,
// // //           ),
// // //           shape: RoundedRectangleBorder(
// // //             borderRadius: BorderRadius.circular(12),
// // //           ),
// // //           textStyle: AppTextStyles.secondaryButton,
// // //           animationDuration: const Duration(milliseconds: 200),
// // //         ),
// // //       ),
// // //
// // //       // ========================================================================
// // //       // TEXT BUTTON THEME
// // //       // ========================================================================
// // //       textButtonTheme: TextButtonThemeData(
// // //         style: TextButton.styleFrom(
// // //           foregroundColor: AppColors.primary,
// // //           padding: const EdgeInsets.symmetric(
// // //             horizontal: 16,
// // //             vertical: 8,
// // //           ),
// // //           textStyle: AppTextStyles.labelLarge,
// // //           animationDuration: const Duration(milliseconds: 200),
// // //         ),
// // //       ),
// // //
// // //       // ========================================================================
// // //       // FLOATING ACTION BUTTON THEME
// // //       // ========================================================================
// // //       floatingActionButtonTheme: FloatingActionButtonThemeData(
// // //         backgroundColor: AppColors.primary,
// // //         foregroundColor: AppColors.white,
// // //         elevation: 4,
// // //         focusElevation: 8,
// // //         hoverElevation: 8,
// // //         splashColor: AppColors.white.withOpacity(0.5),
// // //         shape: const RoundedRectangleBorder(
// // //           borderRadius: BorderRadius.all(Radius.circular(16)),
// // //         ),
// // //       ),
// // //
// // //       // ========================================================================
// // //       // CHECKBOX THEME
// // //       // ========================================================================
// // //       checkboxTheme: CheckboxThemeData(
// // //         fillColor: MaterialStateProperty.resolveWith((states) {
// // //           if (states.contains(MaterialState.selected)) {
// // //             return AppColors.primary;
// // //           }
// // //           return AppColors.lightGray;
// // //         }),
// // //         checkColor: MaterialStateProperty.all(AppColors.white),
// // //         shape: RoundedRectangleBorder(
// // //           borderRadius: BorderRadius.circular(4),
// // //         ),
// // //       ),
// // //
// // //       // ========================================================================
// // //       // RADIO BUTTON THEME
// // //       // ========================================================================
// // //       radioTheme: RadioThemeData(
// // //         fillColor: MaterialStateProperty.resolveWith((states) {
// // //           if (states.contains(MaterialState.selected)) {
// // //             return AppColors.primary;
// // //           }
// // //           return AppColors.textHint;
// // //         }),
// // //       ),
// // //
// // //       // ========================================================================
// // //       // SWITCH THEME
// // //       // ========================================================================
// // //       switchTheme: SwitchThemeData(
// // //         thumbColor: MaterialStateProperty.resolveWith((states) {
// // //           if (states.contains(MaterialState.selected)) {
// // //             return AppColors.white;
// // //           }
// // //           return AppColors.mediumGray;
// // //         }),
// // //         trackColor: MaterialStateProperty.resolveWith((states) {
// // //           if (states.contains(MaterialState.selected)) {
// // //             return AppColors.primary;
// // //           }
// // //           return AppColors.lightGray;
// // //         }),
// // //       ),
// // //
// // //       // ========================================================================
// // //       // DIALOG THEME
// // //       // ========================================================================
// // //       dialogTheme: DialogThemeData(
// // //         backgroundColor: AppColors.surface,
// // //         elevation: 8,
// // //         shape: RoundedRectangleBorder(
// // //           borderRadius: BorderRadius.circular(16),
// // //         ),
// // //         titleTextStyle: AppTextStyles.headlineMedium,
// // //         contentTextStyle: AppTextStyles.bodyMedium,
// // //       ),
// // //
// // //       // ========================================================================
// // //       // SNACK BAR THEME
// // //       // ========================================================================
// // //       snackBarTheme: SnackBarThemeData(
// // //         backgroundColor: AppColors.darkGray,
// // //         contentTextStyle: AppTextStyles.bodyMedium.copyWith(
// // //           color: AppColors.white,
// // //         ),
// // //         actionTextColor: AppColors.primary,
// // //         elevation: 4,
// // //         insetPadding: const EdgeInsets.all(16),
// // //         shape: RoundedRectangleBorder(
// // //           borderRadius: BorderRadius.circular(8),
// // //         ),
// // //         behavior: SnackBarBehavior.floating,
// // //       ),
// // //
// // //       // ========================================================================
// // //       // CARD THEME
// // //       // ========================================================================
// // //       cardTheme: CardThemeData(
// // //         color: AppColors.surface,
// // //         elevation: 2,
// // //         shape: RoundedRectangleBorder(
// // //           borderRadius: BorderRadius.circular(12),
// // //         ),
// // //         margin: EdgeInsets.zero,
// // //         surfaceTintColor: AppColors.primary.withOpacity(0.05),
// // //       ),
// // //
// // //       // ========================================================================
// // //       // DIVIDER THEME
// // //       // ========================================================================
// // //       dividerTheme: const DividerThemeData(
// // //         color: AppColors.lightGray,
// // //         thickness: 1,
// // //         space: 16,
// // //       ),
// // //
// // //       // ========================================================================
// // //       // CHIP THEME
// // //       // ========================================================================
// // //       chipTheme: ChipThemeData(
// // //         backgroundColor: AppColors.primaryVeryLight,
// // //         selectedColor: AppColors.primary,
// // //         disabledColor: AppColors.lightGray,
// // //         labelPadding: const EdgeInsets.symmetric(horizontal: 12),
// // //         padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
// // //         shape: RoundedRectangleBorder(
// // //           borderRadius: BorderRadius.circular(20),
// // //         ),
// // //         labelStyle: AppTextStyles.labelMedium,
// // //         secondaryLabelStyle: AppTextStyles.labelMedium.copyWith(
// // //           color: AppColors.white,
// // //         ),
// // //         brightness: Brightness.light,
// // //         elevation: 2,
// // //       ),
// // //
// // //       // ========================================================================
// // //       // BOTTOM SHEET THEME
// // //       // ========================================================================
// // //       bottomSheetTheme: const BottomSheetThemeData(
// // //         backgroundColor: AppColors.surface,
// // //         elevation: 8,
// // //         shape: RoundedRectangleBorder(
// // //           borderRadius: BorderRadius.only(
// // //             topLeft: Radius.circular(20),
// // //             topRight: Radius.circular(20),
// // //           ),
// // //         ),
// // //         modalBackgroundColor: AppColors.surface,
// // //         modalElevation: 8,
// // //       ),
// // //
// // //       // ========================================================================
// // //       // NAVIGATION RAIL THEME
// // //       // ========================================================================
// // //       navigationRailTheme: NavigationRailThemeData(
// // //         backgroundColor: AppColors.white,
// // //         elevation: 2,
// // //         selectedIconTheme: const IconThemeData(
// // //           color: AppColors.primary,
// // //           size: 24,
// // //         ),
// // //         unselectedIconTheme: const IconThemeData(
// // //           color: AppColors.textSecondary,
// // //           size: 24,
// // //         ),
// // //         selectedLabelTextStyle: AppTextStyles.labelMedium.copyWith(
// // //           color: AppColors.primary,
// // //         ),
// // //         unselectedLabelTextStyle: AppTextStyles.labelMedium.copyWith(
// // //           color: AppColors.textSecondary,
// // //         ),
// // //       ),
// // //
// // //       // ========================================================================
// // //       // BOTTOM NAVIGATION BAR THEME
// // //       // ========================================================================
// // //       bottomNavigationBarTheme: BottomNavigationBarThemeData(
// // //         backgroundColor: AppColors.white,
// // //         elevation: 8,
// // //         selectedItemColor: AppColors.primary,
// // //         unselectedItemColor: AppColors.textSecondary,
// // //         selectedLabelStyle: AppTextStyles.labelSmall,
// // //         unselectedLabelStyle: AppTextStyles.labelSmall,
// // //       ),
// // //
// // //       // ========================================================================
// // //       // PROGRESS INDICATOR THEME
// // //       // ========================================================================
// // //       progressIndicatorTheme: const ProgressIndicatorThemeData(
// // //         color: AppColors.primary,
// // //         linearMinHeight: 4,
// // //         circularTrackColor: AppColors.lightGray,
// // //       ),
// // //
// // //       // ========================================================================
// // //       // TOOLTIP THEME
// // //       // ========================================================================
// // //       tooltipTheme: TooltipThemeData(
// // //         decoration: BoxDecoration(
// // //           color: AppColors.darkGray,
// // //           borderRadius: BorderRadius.circular(6),
// // //         ),
// // //         textStyle: AppTextStyles.bodySmall.copyWith(
// // //           color: AppColors.white,
// // //         ),
// // //         showDuration: const Duration(seconds: 3),
// // //       ),
// // //
// // //       // ========================================================================
// // //       // TEXT THEME
// // //       // ========================================================================
// // //       textTheme: TextTheme(
// // //         displayLarge: AppTextStyles.displayLarge,
// // //         displayMedium: AppTextStyles.displayMedium,
// // //         displaySmall: AppTextStyles.displaySmall,
// // //         headlineLarge: AppTextStyles.headlineLarge,
// // //         headlineMedium: AppTextStyles.headlineMedium,
// // //         headlineSmall: AppTextStyles.headlineSmall,
// // //         titleLarge: AppTextStyles.titleLarge,
// // //         titleMedium: AppTextStyles.titleMedium,
// // //         titleSmall: AppTextStyles.titleSmall,
// // //         bodyLarge: AppTextStyles.bodyLarge,
// // //         bodyMedium: AppTextStyles.bodyMedium,
// // //         bodySmall: AppTextStyles.bodySmall,
// // //         labelLarge: AppTextStyles.labelLarge,
// // //         labelMedium: AppTextStyles.labelMedium,
// // //         labelSmall: AppTextStyles.labelSmall,
// // //       ),
// // //
// // //       // ========================================================================
// // //       // EXTENSION COLORS
// // //       // ========================================================================
// // //       extensions: <ThemeExtension<dynamic>>[],
// // //
// // //       // Other properties
// // //       pageTransitionsTheme: const PageTransitionsTheme(
// // //         builders: <TargetPlatform, PageTransitionsBuilder>{
// // //           TargetPlatform.android: ZoomPageTransitionsBuilder(),
// // //           TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
// // //           TargetPlatform.linux: ZoomPageTransitionsBuilder(),
// // //           TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
// // //           TargetPlatform.windows: ZoomPageTransitionsBuilder(),
// // //         },
// // //       ),
// // //     );
// // //   }
// // //
// // //   // ============================================================================
// // //   // DARK THEME
// // //   // ============================================================================
// // //
// // //   /// Build dark theme for the app
// // //   static ThemeData get darkTheme {
// // //     return ThemeData(
// // //       useMaterial3: true,
// // //       brightness: Brightness.dark,
// // //       colorScheme: ColorScheme.dark(
// // //         primary: AppColors.primary,
// // //         onPrimary: AppColors.black,
// // //         primaryContainer: AppColors.primaryDark,
// // //         onPrimaryContainer: AppColors.primaryLight,
// // //         secondary: AppColors.secondary,
// // //         onSecondary: AppColors.black,
// // //         secondaryContainer: AppColors.secondaryDark,
// // //         onSecondaryContainer: AppColors.secondaryLight,
// // //         surface: const Color(0xFF1F1F1F),
// // //         onSurface: AppColors.white,
// // //         error: AppColors.error,
// // //         onError: AppColors.white,
// // //       ),
// // //       primaryColor: AppColors.primary,
// // //       scaffoldBackgroundColor: const Color(0xFF121212),
// // //       textTheme: TextTheme(
// // //         displayLarge: AppTextStyles.displayLarge.copyWith(
// // //           color: AppColors.white,
// // //         ),
// // //         displayMedium: AppTextStyles.displayMedium.copyWith(
// // //           color: AppColors.white,
// // //         ),
// // //         displaySmall: AppTextStyles.displaySmall.copyWith(
// // //           color: AppColors.white,
// // //         ),
// // //         headlineLarge: AppTextStyles.headlineLarge.copyWith(
// // //           color: AppColors.white,
// // //         ),
// // //         headlineMedium: AppTextStyles.headlineMedium.copyWith(
// // //           color: AppColors.white,
// // //         ),
// // //         headlineSmall: AppTextStyles.headlineSmall.copyWith(
// // //           color: AppColors.white,
// // //         ),
// // //         titleLarge: AppTextStyles.titleLarge.copyWith(
// // //           color: AppColors.white,
// // //         ),
// // //         titleMedium: AppTextStyles.titleMedium.copyWith(
// // //           color: AppColors.white,
// // //         ),
// // //         titleSmall: AppTextStyles.titleSmall.copyWith(
// // //           color: AppColors.white.withOpacity(0.7),
// // //         ),
// // //         bodyLarge: AppTextStyles.bodyLarge.copyWith(
// // //           color: AppColors.white,
// // //         ),
// // //         bodyMedium: AppTextStyles.bodyMedium.copyWith(
// // //           color: AppColors.white.withOpacity(0.7),
// // //         ),
// // //         bodySmall: AppTextStyles.bodySmall.copyWith(
// // //           color: AppColors.white.withOpacity(0.6),
// // //         ),
// // //       ),
// // //     );
// // //   }
// // // }
// // //
// // // // ============================================================================
// // // // EXTENSION: ThemeData Extensions
// // // // ============================================================================
// // //
// // // /// Extension methods for ThemeData
// // // extension ThemeDataExtensions on ThemeData {
// // //   /// Check if theme is dark
// // //   bool get isDark => brightness == Brightness.dark;
// // //
// // //   /// Check if theme is light
// // //   bool get isLight => brightness == Brightness.light;
// // // }
// //
// // import 'package:flutter/material.dart';
// // import '../theme/app_colors.dart';
// // import 'app_colors.dart';
// //
// // class AppTheme {
// //   AppTheme._();
// //
// //   static ThemeData get lightTheme {
// //     const textTheme = TextTheme(
// //       titleLarge: TextStyle(
// //         fontSize: 28,
// //         fontWeight: FontWeight.w600,
// //         color: AppColors.textPrimary,
// //         letterSpacing: -0.5,
// //       ),
// //       titleMedium: TextStyle(
// //         fontSize: 14,
// //         fontWeight: FontWeight.w500,
// //         color: AppColors.textPrimary,
// //       ),
// //       bodyMedium: TextStyle(
// //         fontSize: 13,
// //         fontWeight: FontWeight.w400,
// //         color: AppColors.textPrimary,
// //       ),
// //       bodySmall: TextStyle(
// //         fontSize: 11,
// //         fontWeight: FontWeight.w400,
// //         color: AppColors.textSecondary,
// //       ),
// //       labelSmall: TextStyle(
// //         fontSize: 9,
// //         fontWeight: FontWeight.w500,
// //         color: AppColors.authHeroAccent,
// //         letterSpacing: 1.2,
// //       ),
// //     );
// //     return ThemeData(
// //       useMaterial3: true,
// //       scaffoldBackgroundColor: AppColors.authHeroAccent,
// //       colorScheme: const ColorScheme.light(
// //         surface: AppColors.authHeroAccent,
// //         primary: AppColors.authHeroAccent,
// //         onSurface: AppColors.textPrimary,
// //       ),
// //       textTheme: textTheme,
// //       dividerColor: AppColors.backgroundColor,
// //       splashFactory: NoSplash.splashFactory,
// //       appBarTheme: const AppBarTheme(
// //         backgroundColor: Colors.transparent,
// //         elevation: 0,
// //         scrolledUnderElevation: 0,
// //       ),
// //       inputDecorationTheme: InputDecorationTheme(
// //         filled: true,
// //         fillColor: AppColors.authCardSurface,
// //         border: OutlineInputBorder(
// //           borderRadius: BorderRadius.circular(4),
// //           borderSide: BorderSide.none,
// //         ),
// //         enabledBorder: OutlineInputBorder(
// //           borderRadius: BorderRadius.circular(4),
// //           borderSide: BorderSide.none,
// //         ),
// //         focusedBorder: OutlineInputBorder(
// //           borderRadius: BorderRadius.circular(4),
// //           borderSide: const BorderSide(color: AppColors.inputBorderColor),
// //         ),
// //         hintStyle: const TextStyle(
// //           fontSize: 12,
// //           color: AppColors.authInputBorder,
// //         ),
// //         contentPadding:
// //             const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
// //       ),
// //     );
// //   }
// // }
//
// // lib/config/theme/custom_theme.dart
// import 'package:flutter/material.dart';
//
// import 'app_colors.dart';
// import 'app_dimensions.dart';
//
// // import 'app_colors.dart' as AppColors;
// // import 'app_dimensions.dart' as AppDimens;
//
// class AppTheme {
//   // Replace with your actual AppColors
//   static const Color background = Color(0xFFF8F9FA); // very light grey
//   static const Color surface = Colors.white;
//   static const Color textPrimary = Color(0xFF424242);
//   static const Color textSecondary = Color(0xFF757575);
//   static const Color textHint = Color(0xFFBDBDBD);
//   static const Color borderLight = Color(0xFFE0E0E0);
//   static const Color divider = Color(0xFFF0F0F0);
//   static const Color iconBg = Color(0xFFF5F5F5);
//   static const Color iconColor = Color(0xFF9E9E9E);
//
//   // Replace with your actual AppDimensions
//   static const double paddingXS = 4;
//   static const double paddingS = 8;
//   static const double paddingM = 12;
//   static const double paddingL = 16;
//   static const double paddingXL = 20;
//   static const double borderRadiusCard = 16;
//   static const double borderRadiusButton = 12;
//   static const double borderRadiusChip = 30;
// }
//
// class CustomTheme {
//   static ThemeData light() {
//     return ThemeData(
//       scaffoldBackgroundColor: AppColors.background,
//       primaryColor: AppColors.surface,
//       colorScheme: const ColorScheme.light(
//         primary: AppColors.surface,
//         secondary: AppColors.iconBg,
//         surface: AppColors.surface,
//       ),
//       appBarTheme: AppBarTheme(
//         backgroundColor: AppColors.surface,
//         elevation: 0,
//         titleTextStyle: TextStyle(
//           color: AppColors.textPrimary,
//           fontSize: AppDimensions.fontL,
//           fontWeight: FontWeight.w600,
//         ),
//         iconTheme: IconThemeData(color: AppColors.iconColor),
//       ),
//       textTheme: const TextTheme(
//         bodyLarge: TextStyle(color: AppColors.textPrimary),
//         bodyMedium: TextStyle(color: AppColors.textSecondary),
//       ),
//       inputDecorationTheme: InputDecorationTheme(
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(AppDimensions.borderRadiusButton),
//           borderSide: BorderSide(color: AppColors.borderLight),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(AppDimensions.borderRadiusButton),
//           borderSide: BorderSide(color: AppColors.borderLight, width: 1.5),
//         ),
//       ),
//     );
//   }
// }
//
// class MinimalCard extends StatelessWidget {
//   final Widget child;
//   final EdgeInsets? padding;
//   final EdgeInsets? margin;
//   final VoidCallback? onTap;
//
//   const MinimalCard({
//     super.key,
//     required this.child,
//     this.padding,
//     this.margin,
//     this.onTap,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: onTap,
//       borderRadius: BorderRadius.circular(AppDimensions.borderRadiusCard),
//       child: Container(
//         margin: margin ?? const EdgeInsets.all(0),
//         padding: padding ?? EdgeInsets.all(AppDimensions.paddingM),
//         decoration: BoxDecoration(
//           color: AppColors.surface,
//           borderRadius: BorderRadius.circular(AppDimensions.borderRadiusCard),
//           border: Border.all(color: AppColors.borderLight),
//           boxShadow: [
//             BoxShadow(
//               color: AppColors.shadowLight,
//               blurRadius: AppDimensions.blurRadiusSmall,
//               offset: const Offset(0, 2),
//             ),
//           ],
//         ),
//         child: child,
//       ),
//     );
//   }
// }
//
// class MinimalOutlineButton extends StatelessWidget {
//   final String label;
//   final IconData? icon;
//   final VoidCallback onPressed;
//   final bool isFilled;
//
//   const MinimalOutlineButton({
//     super.key,
//     required this.label,
//     this.icon,
//     required this.onPressed,
//     this.isFilled = false,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return OutlinedButton.icon(
//       onPressed: onPressed,
//       icon: icon != null ? Icon(icon, size: 16) : null,
//       label: Text(label),
//       style: OutlinedButton.styleFrom(
//         foregroundColor: AppColors.textSecondary,
//         side: BorderSide(color: AppColors.borderLight),
//         backgroundColor: isFilled ? AppColors.iconBg : AppColors.surface,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(AppDimensions.borderRadiusButton),
//         ),
//         padding: EdgeInsets.symmetric(
//           vertical: AppDimensions.paddingM,
//           horizontal: AppDimensions.paddingS,
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_dimensions.dart';

class AppTheme {
  static ThemeData light() {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.background,
      cardTheme: CardThemeData(
        elevation: 0,
        color: AppColors.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radius),
        ),
        shadowColor: AppColors.shadow,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      textTheme: const TextTheme(
        titleLarge: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w700,
          color: AppColors.textPrimary,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          color: AppColors.textSecondary,
        ),
      ),
    );
  }
}

// class MinimalCard extends StatelessWidget {
//   final Widget child;
//   final EdgeInsets? padding;
//
//   const MinimalCard({super.key, required this.child, this.padding});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: padding ?? const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: AppColors.surface,
//         borderRadius: BorderRadius.circular(AppDimensions.radius),
//         boxShadow: [
//           BoxShadow(
//             color: AppColors.shadow,
//             blurRadius: 12,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: child,
//     );
//   }
// }

class MinimalCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;

  const MinimalCard({
    super.key,
    required this.child,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? const EdgeInsets.all(AppDimensions.paddingM),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppDimensions.radiusCard),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }
}
