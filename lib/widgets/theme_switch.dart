import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/theme/theme_service.dart';

class ThemeSwitch extends StatelessWidget {
  const ThemeSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    final themeService = Provider.of<ThemeService>(context);
    
    return IconButton(
      icon: Icon(
        themeService.isDarkMode ? Icons.light_mode : Icons.dark_mode,
        color: Theme.of(context).iconTheme.color,
      ),
      onPressed: () => themeService.toggleTheme(),
      tooltip: themeService.isDarkMode ? 'Світла тема' : 'Темна тема',
    );
  }
}
