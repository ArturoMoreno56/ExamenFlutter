import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const int _primaryValue = 0xFF1E90FF;

  static const MaterialColor blueSwatch = MaterialColor(
    _primaryValue,
    <int, Color>{
      50: Color(0xFFF2FBFF),
      100: Color(0xFFE6F7FF),
      200: Color(0xFFCCEFFF),
      300: Color(0xFF99E0FF),
      400: Color(0xFF66D1FF),
      500: Color(_primaryValue),
      600: Color(0xFF1A84E6),
      700: Color(0xFF166FCC),
      800: Color(0xFF1259B3),
      900: Color(0xFF0D3F80),
    },
  );

  static final Color scaffoldBg = const Color(0xFFEAF9FF); 
  static final Color cardBg = const Color(0xFFF5FDFF); 

  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    primarySwatch: blueSwatch,
    primaryColor: const Color(_primaryValue),
    scaffoldBackgroundColor: scaffoldBg,
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(_primaryValue),
      brightness: Brightness.light,
      primary: const Color(_primaryValue),
      secondary: blueSwatch.shade200,
    ),

    textTheme: GoogleFonts.poppinsTextTheme().apply(
      bodyColor: Colors.black87,
      displayColor: Colors.black87,
    ).copyWith(
      titleLarge: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600),
      titleMedium: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500),
      bodyLarge: GoogleFonts.poppins(fontSize: 15),
      bodyMedium: GoogleFonts.poppins(fontSize: 14),
    ),

    appBarTheme: const AppBarTheme(
      backgroundColor: Color(_primaryValue),
      foregroundColor: Colors.white,
      elevation: 2,
      centerTitle: true,
    ),

    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Color(_primaryValue),
      foregroundColor: Colors.white,
      elevation: 4,
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(_primaryValue),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        textStyle: GoogleFonts.poppins(fontWeight: FontWeight.w600),
      ),
    ),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: blueSwatch.shade700,
        textStyle: GoogleFonts.poppins(fontWeight: FontWeight.w600),
      ),
    ),

    cardTheme: CardThemeData(
      color: cardBg,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 0),
    ),

    listTileTheme: ListTileThemeData(
      iconColor: blueSwatch.shade700,
      textColor: Colors.black87,
      tileColor: cardBg,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: blueSwatch.shade50,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
      hintStyle: TextStyle(color: blueSwatch.shade400),
    ),

    chipTheme: ChipThemeData.fromDefaults(
      secondaryColor: blueSwatch.shade300,
      labelStyle: GoogleFonts.poppins(textStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
      brightness: Brightness.light,
    ),

    dividerColor: blueSwatch.shade100,
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}