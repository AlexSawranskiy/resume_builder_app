import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/person_list_viewmodel.dart';
import '../models/person.dart';
import '../widgets/theme_switch.dart';
import 'add_person_view.dart';
import 'detail_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<PersonListViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Resume Builder'),
        actions: [
          const ThemeSwitch(),
          const SizedBox(width: 8), // Add some spacing between buttons
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AddPersonView()),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: viewModel.people.length,
        itemBuilder: (context, index) {
          final person = viewModel.people[index];
          return ListTile(
            title: Text(person.name),
            subtitle: Text(person.description),
            trailing: IconButton(
              icon: const Icon(Icons.copy),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => AddPersonView(initial: person),
                  ),
                );
              },
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => DetailView(person: person),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

