import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WhiteTheme {
  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.light,
        statusBarColor: Colors.white,
      ),
    ),
    shadowColor: Colors.black,
    cardColor: const Color(0xFFFFFFFF),
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontSize: 57,
        color: Colors.black,
        fontFamily: "Inter",
        fontWeight: FontWeight.w400,
      ),
      displayMedium: TextStyle(
        fontSize: 45,
        color: Colors.black,
        fontFamily: "Inter",
        fontWeight: FontWeight.w400,
      ),
      displaySmall: TextStyle(
        fontSize: 36,
        color: Colors.black,
        fontFamily: "Inter",
        fontWeight: FontWeight.w400,
      ),
      headlineLarge: TextStyle(
        fontSize: 32,
        color: Colors.black,
        fontFamily: "Inter",
        fontWeight: FontWeight.w400,
      ),
      headlineMedium: TextStyle(
        fontSize: 28,
        color: Colors.black,
        fontFamily: "Inter",
        fontWeight: FontWeight.w400,
      ),
      headlineSmall: TextStyle(
        fontSize: 24,
        color: Colors.black,
        fontFamily: "Inter",
        fontWeight: FontWeight.w400,
      ),
      titleLarge: TextStyle(
        fontSize: 22,
        color: Colors.black,
        fontFamily: "Inter",
        fontWeight: FontWeight.w400,
      ),
      titleMedium: TextStyle(
        fontSize: 16,
        color: Colors.black,
        fontFamily: "Inter",
        fontWeight: FontWeight.w400,
      ),
      titleSmall: TextStyle(
        fontSize: 14,
        color: Colors.black,
        fontFamily: "Inter",
        fontWeight: FontWeight.w400,
      ),
      labelLarge: TextStyle(
        fontSize: 14,
        color: Colors.black,
        fontFamily: "Inter",
        fontWeight: FontWeight.w500,
      ),
      labelMedium: TextStyle(
        fontSize: 12,
        color: Colors.black,
        fontFamily: "Inter",
        fontWeight: FontWeight.w500,
      ),
      labelSmall: TextStyle(
        fontSize: 11,
        color: Colors.black,
        fontFamily: "Inter",
        fontWeight: FontWeight.w500,
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        color: Colors.black,
        fontFamily: "Inter",
        fontWeight: FontWeight.w500,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        color: Colors.black,
        fontFamily: "Inter",
        fontWeight: FontWeight.w500,
      ),
      bodySmall: TextStyle(
        fontSize: 12,
        color: Colors.black,
        fontFamily: "Inter",
        fontWeight: FontWeight.w500,
      ),
    ),
    iconButtonTheme: IconButtonThemeData(
      style: IconButton.styleFrom(backgroundColor: Colors.transparent),
    ),
    iconTheme:  IconThemeData(
      color: Colors.black,
      size: 24.sp
    ),
    switchTheme: SwitchThemeData(
      thumbColor: MaterialStateProperty.all((Colors.black)),
      trackOutlineColor: MaterialStateProperty.all((Colors.red)),
    ),
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xFF0056D2),
      onPrimary: Color(0xFFFFFFFF),
      primaryContainer: Color(0xFFDAE2FF),
      onPrimaryContainer: Color(0xFF001848),
      secondary: Color(0xFF7C5800),
      onSecondary: Color(0xFFFFFFFF),
      secondaryContainer: Color(0xFFFFDEA8),
      onSecondaryContainer: Color(0xFF271900),
      tertiary: Color(0xFF5342E2),
      onTertiary: Color(0xFFFFFFFF),
      tertiaryContainer: Color(0xFFE3DFFF),
      onTertiaryContainer: Color(0xFF130067),
      error: Color(0xFFBA1A1A),
      errorContainer: Color(0xFFFFDAD6),
      onError: Color(0xFFFFFFFF),
      onErrorContainer: Color(0xFF410002),
      background: Color(0xFFFDFBFF),
      onBackground: Color(0xFF001B3D),
      surface: Color(0xFFFDFBFF),
      onSurface: Color(0xFF001B3D),
      surfaceVariant: Color(0xFFE1E2EC),
      onSurfaceVariant: Color(0xFF45464F),
      outline: Color(0xFF757780),
      onInverseSurface: Color(0xFFECF0FF),
      inverseSurface: Color(0xFF003062),
      inversePrimary: Color(0xFFB2C5FF),
      shadow: Color(0xFF000000),
      surfaceTint: Color(0xFF0056D2),
      outlineVariant: Color(0xFFC5C6D0),
      scrim: Color(0xFF000000),
    ),
    useMaterial3: true,
  );
}