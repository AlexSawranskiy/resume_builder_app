import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/person_list_viewmodel.dart';
import '../repository/person_repository.dart';
import '../widgets/person_list_widget.dart';
import 'add_person_view.dart';
import 'github_stats_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize repository
  final repository = PersonRepository();
  
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => PersonListViewModel(repository),
        ),
      ],
      child: const ResumeBuilderApp(),
    ),
  );
}

class ResumeBuilderApp extends StatelessWidget {
  const ResumeBuilderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Резюме Білдер',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
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

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Резюме Білдер'),
        centerTitle: true,
      ),
      body: Consumer<PersonListViewModel>(
        builder: (context, viewModel, _) {
          return Column(
            children: [
              if (viewModel.error != null)
                Container(
                  padding: const EdgeInsets.all(8),
                  color: Colors.red[100],
                  child: Row(
                    children: [
                      const Icon(Icons.error_outline, color: Colors.red),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          viewModel.error!,
                          style: const TextStyle(color: Colors.red),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close, color: Colors.red),
                        onPressed: () {
                          // Clear the error
                          viewModel.notifyListeners();
                        },
                      ),
                    ],
                  ),
                ),
              Expanded(
                child: PersonListWidget(
                  people: viewModel.people,
                  isLoading: viewModel.isLoading,
                  error: viewModel.error,
                  onDuplicate: (person) => viewModel.duplicatePerson(person),
                  onDelete: (index) => viewModel.deletePerson(index),
                  onTap: (person) {
                    Navigator.pushNamed(
                      context,
                      '/github',
                      arguments: {'username': person.githubUsername},
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/add');
        },
        tooltip: 'Додати резюме',
        child: const Icon(Icons.add),
      ),
    );
  }
}
