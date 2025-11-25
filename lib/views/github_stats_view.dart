import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/github_viewmodel.dart';

class GitHubStatsView extends StatefulWidget {
  final String username;

  const GitHubStatsView({super.key, required this.username});

  @override
  State<GitHubStatsView> createState() => _GitHubStatsViewState();
}

class _GitHubStatsViewState extends State<GitHubStatsView> {
  @override
  void initState() {
    super.initState();
    // Defer the fetch to after the first frame to avoid notifyListeners during build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<GitHubViewModel>().fetchUserStats(widget.username);
      }
    });
  }

  @override
  void didUpdateWidget(covariant GitHubStatsView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.username != widget.username) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          context.read<GitHubViewModel>().fetchUserStats(widget.username);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GitHubViewModel>(
      builder: (context, viewModel, _) {
        return Center(
          child: viewModel.isLoading
              ? const CircularProgressIndicator()
              : viewModel.error != null
                  ? Text('Error: ${viewModel.error}')
                  : viewModel.userStats != null
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Username: ${viewModel.userStats!['login']}'),
                            Text('Repos: ${viewModel.userStats!['public_repos']}'),
                            Text('Followers: ${viewModel.userStats!['followers']}'),
                            Text('Following: ${viewModel.userStats!['following']}'),
                          ],
                        )
                      : const Text('No data'),
        );
      },
    );
  }
}
