class Person {
  final String name;
  final String description;
  final String hobby;
  final String contacts;
  final String githubUsername; // 👈 Додали це поле

  Person({
    required this.name,
    required this.description,
    required this.hobby,
    required this.contacts,
    required this.githubUsername,
  });

  Person copyWith({
    String? name,
    String? description,
    String? hobby,
    String? contacts,
    String? githubUsername,
  }) {
    return Person(
      name: name ?? this.name,
      description: description ?? this.description,
      hobby: hobby ?? this.hobby,
      contacts: contacts ?? this.contacts,
      githubUsername: githubUsername ?? this.githubUsername,
    );
  }
}
