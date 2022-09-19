import 'package:flutter/material.dart';
import 'storageman.dart';
import 'globals.dart' as gl;

class ThemeNotifier with ChangeNotifier {
  final darkTheme = ThemeData(
    primaryColor: Color.fromARGB(255, 228, 228, 228),
    backgroundColor: const Color(0xFF212121),
    dividerColor: Color.fromARGB(137, 79, 137, 246),
    colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue)
        .copyWith(secondary: Colors.white, brightness: Brightness.dark),
  );

  final lightTheme = ThemeData(
    primaryColor: Color.fromARGB(255, 59, 59, 59),
    backgroundColor: const Color(0xFFE5E5E5),
    dividerColor: Color.fromARGB(137, 79, 137, 246),
    colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue).copyWith(
        secondary: Color.fromARGB(255, 105, 105, 105),
        brightness: Brightness.light),
  );

  ThemeData _themeData = ThemeData(
    primaryColor: Color.fromARGB(255, 59, 59, 59),
    backgroundColor: const Color(0xFFE5E5E5),
    dividerColor: Color.fromARGB(137, 79, 137, 246),
    colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue).copyWith(
        secondary: Color.fromARGB(255, 105, 105, 105),
        brightness: Brightness.light),
  );
  ThemeData getTheme() => _themeData;

  ThemeNotifier() {
    StorageManager.readData('themeMode').then((value) {
      var themeMode = value ?? 'light';
      if (themeMode == 'light') {
        _themeData = lightTheme;
      } else {
        _themeData = darkTheme;
      }
      notifyListeners();
    });
  }

  void setDarkMode() async {
    _themeData = darkTheme;
    StorageManager.saveData('themeMode', 'dark');
    notifyListeners();
  }

  void setLightMode() async {
    _themeData = lightTheme;
    StorageManager.saveData('themeMode', 'light');
    notifyListeners();
  }
}
