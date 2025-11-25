import 'package:flutter/foundation.dart';
import '../repository/github_repository.dart';

class GitHubViewModel extends ChangeNotifier {
  final GitHubRepository _repository = GitHubRepository();

  Map<String, dynamic>? userStats;
  bool isLoading = false;
  String? error;

  Future<void> fetchUserStats(String username) async {
    isLoading = true;
    notifyListeners();

    try {
      userStats = await _repository.getUserStats(username);
      error = null;
    } catch (e) {
      error = e.toString();
    }

    isLoading = false;
    notifyListeners();
  }
}
