class GithubProfile {
  const GithubProfile({
    required this.name,
    required this.username,
  });

  final String name;
  final String username;

  static GithubProfile fromJson(Map<String, dynamic> json) {
    return GithubProfile(
      name: json['name'] as String,
      username: json['login'] as String,
    );
  }
}
