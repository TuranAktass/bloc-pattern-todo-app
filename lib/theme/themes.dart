import 'package:flutter/material.dart';

final primaryColor = Color(0xFF13B9FF);
final errorRed = Color(0xFFC5032B);

final _border = OutlineInputBorder(
    borderSide: BorderSide(color: primaryColor),
    borderRadius: BorderRadius.circular(14));

final _errorBorder = OutlineInputBorder(
    borderSide: BorderSide(color: errorRed),
    borderRadius: BorderRadius.circular(14));

class TodosTheme {
  static ThemeData get light {
    return ThemeData(
      appBarTheme: const AppBarTheme(
        color: Color(0xFF13B9FF),
      ),
      colorScheme: ColorScheme.fromSwatch(
        accentColor: const Color(0xFF13B9FF),
      ),
      snackBarTheme: const SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
      ),
      toggleableActiveColor: const Color(0xFF13B9FF),
      inputDecorationTheme: InputDecorationTheme(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
        border: _border,
        enabledBorder: _border,
        focusedBorder: _border,
        disabledBorder: _border,
        errorBorder: _errorBorder,
      ),
    );
  }

  static ThemeData get dark {
    return ThemeData(
      appBarTheme: const AppBarTheme(
        color: Color(0xFF13B9FF),
      ),
      colorScheme: ColorScheme.fromSwatch(
        brightness: Brightness.dark,
        accentColor: const Color(0xFF13B9FF),
      ),
      snackBarTheme: const SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
      ),
      toggleableActiveColor: const Color(0xFF13B9FF),
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: const EdgeInsets.all(4.0),
        border: _border,
        enabledBorder: _border,
        focusedBorder: _border,
        disabledBorder: _border,
        errorBorder: _errorBorder,
      ),
    );
  }
}
