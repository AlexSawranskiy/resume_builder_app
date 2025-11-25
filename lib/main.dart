import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './viewmodels/person_list_viewmodel.dart';
import './repository/person_repository.dart';
import './viewmodels/github_viewmodel.dart';
import 'services/theme/theme_service.dart';
import 'views/home_view.dart';
import 'views/add_person_view.dart';
import 'views/github_stats_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize SharedPreferences
  final prefs = await SharedPreferences.getInstance();
  
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => PersonListViewModel(PersonRepository())),
        ChangeNotifierProvider(create: (_) => GitHubViewModel()),
        ChangeNotifierProvider(create: (_) => ThemeService()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeService = Provider.of<ThemeService>(context);
    
    return MaterialApp(
      title: 'Резюме Білдер',
      debugShowCheckedModeBanner: false,
      theme: themeService.getTheme(),
      darkTheme: themeService.darkTheme,
      themeMode: themeService.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeView(),
        '/add': (context) => const AddPersonView(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/github') {
          final args = settings.arguments as Map<String, dynamic>;
          return MaterialPageRoute(
            builder: (_) => GitHubStatsView(username: args['username']),
          );
        }
        return null;
      },
    );
  }
}

