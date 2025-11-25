import 'package:flutter/material.dart';
import '../models/person.dart';
import 'github_stats_view.dart';

class DetailView extends StatelessWidget {
  final Person person;

  const DetailView({super.key, required this.person});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(person.name)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Description: ${person.description}'),
            Text('Hobby: ${person.hobby}'),
            Text('Contacts: ${person.contacts}'),
            const SizedBox(height: 20),
            Text(
              'GitHub Statistics:',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Expanded(
              child: GitHubStatsView(username: person.githubUsername),
            ),
          ],
        ),
      ),
    );
  }
}
