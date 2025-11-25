import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/person_list_viewmodel.dart';
import '../models/person.dart';

class PersonListWidget extends StatelessWidget {
  final List<Person> people;
  final bool isLoading;
  final String? error;
  final Function(Person) onDuplicate;
  final Function(int) onDelete;
  final Function(Person) onTap;

  const PersonListWidget({
    Key? key,
    required this.people,
    required this.isLoading,
    this.error,
    required this.onDuplicate,
    required this.onDelete,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, color: Colors.red, size: 60),
            const SizedBox(height: 16),
            Text(
              'Error: $error',
              style: const TextStyle(color: Colors.red),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    if (people.isEmpty) {
      return const Center(
        child: Text('No resumes found. Add your first resume!'),
      );
    }

    return ListView.builder(
      itemCount: people.length,
      itemBuilder: (context, index) {
        final person = people[index];
        return Dismissible(
          key: Key('person_${person.name}_$index'),
          background: Container(
            color: Colors.red,
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 20),
            child: const Icon(Icons.delete, color: Colors.white),
          ),
          direction: DismissDirection.endToStart,
          confirmDismiss: (direction) async {
            return await showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Confirm Delete'),
                  content: Text('Are you sure you want to delete ${person.name}\'s resume?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: const Text('CANCEL'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(true),
                      child: const Text('DELETE', style: TextStyle(color: Colors.red)),
                    ),
                  ],
                );
              },
            );
          },
          onDismissed: (direction) {
            onDelete(index);
          },
          child: Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              title: Text(
                person.name,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              subtitle: Text(person.description),
              trailing: IconButton(
                icon: const Icon(Icons.copy),
                onPressed: () => onDuplicate(person),
                tooltip: 'Duplicate',
              ),
              onTap: () => onTap(person),
            ),
          ),
        );
      },
    );
  }
}
