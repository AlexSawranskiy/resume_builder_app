import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:resume_builder_app_github/services/theme/theme_service.dart';

// Mock classes for testing
class MockSharedPreferences extends Mock implements SharedPreferences {}

class MockThemeService extends Mock implements ThemeService {
  bool _isDarkMode = false;

  @override
  bool get isDarkMode => _isDarkMode;

  @override
  Future<void> toggleTheme() async {
    _isDarkMode = !_isDarkMode;
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  
  late ThemeService themeService;
  late SharedPreferences prefs;
  
  // Set up the test environment before each test
  setUp(() async {
    // Set up mock SharedPreferences
    SharedPreferences.setMockInitialValues({});
    prefs = await SharedPreferences.getInstance();
    themeService = ThemeService();
    
    // Wait for the initial theme to load
    await Future.delayed(const Duration(milliseconds: 100));
  });
  
  // Clean up after each test
  tearDown(() {
    prefs.clear();
  });

  test('Initial theme is light', () {
    expect(themeService.isDarkMode, isFalse);
  });

  test('Toggle theme changes theme mode', () async {
    // Initial state
    expect(themeService.isDarkMode, isFalse);
    
    // First toggle - should switch to dark
    await themeService.toggleTheme();
    expect(themeService.isDarkMode, isTrue);
    
    // Second toggle - should switch back to light
    await themeService.toggleTheme();
    expect(themeService.isDarkMode, isFalse);
  });

  test('Theme preference is saved to SharedPreferences', () async {
    // Initial state - no preference saved
    expect(prefs.getBool('isDarkMode'), isNull);
    
    // Toggle to dark theme
    await themeService.toggleTheme();
    expect(prefs.getBool('isDarkMode'), isTrue);
    
    // Toggle back to light theme
    await themeService.toggleTheme();
    expect(prefs.getBool('isDarkMode'), isFalse);
  });

  test('Theme loads from SharedPreferences', () async {
    // Set initial dark theme preference
    await prefs.setBool('isDarkMode', true);
    
    // Create a new instance to test loading from prefs
    final newThemeService = ThemeService();
    await Future.delayed(const Duration(milliseconds: 100));
    
    // Should load dark theme from prefs
    expect(newThemeService.isDarkMode, isTrue);
  });

  test('getTheme() returns correct theme based on mode', () async {
    // Initial light theme
    var theme = themeService.getTheme();
    expect(theme.brightness, Brightness.light);
    
    // Toggle to dark theme
    await themeService.toggleTheme();
    await Future.delayed(const Duration(milliseconds: 100));
    theme = themeService.getTheme();
    expect(theme.brightness, Brightness.dark);
  });

  test('Dark theme has correct colors', () async {
    // Force dark theme
    await themeService.toggleTheme();
    await Future.delayed(const Duration(milliseconds: 100));
    final theme = themeService.getTheme();
    
    // Check some key colors in dark theme
    expect(theme.brightness, Brightness.dark);
    expect(theme.scaffoldBackgroundColor, Colors.grey[900]);
    expect(theme.cardColor, Colors.grey[800]);
    expect(theme.dialogBackgroundColor, Colors.grey[850]);
  });

  test('Light theme has correct colors', () async {
    // Ensure light theme
    if (themeService.isDarkMode) {
      await themeService.toggleTheme();
      await Future.delayed(const Duration(milliseconds: 100));
    }
    final theme = themeService.getTheme();
    
    // Check some key colors in light theme
    expect(theme.brightness, Brightness.light);
    expect(theme.scaffoldBackgroundColor, Colors.white);
    expect(theme.appBarTheme.backgroundColor, Colors.blue);
    expect(theme.appBarTheme.foregroundColor, Colors.white);
  });
}
