import 'package:flutter/material.dart';

ThemeData buildCalmmindTheme() {
  const lightBlue = Color(0xFFBBD0DC); // Azul claro sugerido
  const softBlue = Color(0xFFAFC0D4);
  const cream = Color(0xFFFFFDF5); // Fondo sección central

  final base = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: softBlue,
      brightness: Brightness.light,
    ),
    // Fondo general blanco en todas las pantallas
    scaffoldBackgroundColor: Colors.white,
  );

  return base.copyWith(
    appBarTheme: const AppBarTheme(
      backgroundColor: lightBlue,
      foregroundColor: Colors.black87,
      elevation: 0,
    ),
    textTheme: base.textTheme.apply(
      bodyColor: Colors.black87,
      displayColor: Colors.black87,
    ),
    cardTheme: CardTheme(
      color: cream,
      elevation: 2,
      margin: const EdgeInsets.all(12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: softBlue,
        foregroundColor: Colors.black87,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    ),
  );
}