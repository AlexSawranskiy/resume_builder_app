import 'dart:convert';
import 'package:http/http.dart' as http;

class GitHubService {
  static const String _envToken = String.fromEnvironment('GITHUB_TOKEN');

  Future<Map<String, dynamic>> fetchUserStats(String username) async {
    final url = Uri.parse('https://api.github.com/users/$username');
    try {
      final headers = <String, String>{
        'Accept': 'application/vnd.github+json',
        'X-GitHub-Api-Version': '2022-11-28',
        'User-Agent': 'resume-builder-app',
        if (_envToken.isNotEmpty) 'Authorization': 'Bearer $_envToken',
      };
      final response = await http
          .get(
            url,
            headers: headers,
          )
          .timeout(const Duration(seconds: 15));

      if (response.statusCode == 200) {
        return json.decode(response.body) as Map<String, dynamic>;
      } else {
        if (response.statusCode == 403) {
          throw Exception(
              'GitHub API rate limit or access denied (status 403). Set GITHUB_TOKEN to authenticate. Response: ${response.body}');
        }
        throw Exception(
            'Failed to load GitHub user stats (status ${response.statusCode}): ${response.body}');
      }
    } catch (e) {
      throw Exception('Failed to load GitHub user stats: $e');
    }
  }
}
