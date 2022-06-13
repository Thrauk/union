class GithubProfile {
  const GithubProfile({
    required this.name,
    required this.username,
    this.photoUrl,
  });

  final String name;
  final String username;
  final String? photoUrl;

  static GithubProfile fromJson(Map<String, dynamic> json) {
    return GithubProfile(
      name: json['name'] as String,
      username: json['login'] as String,
      photoUrl : json['avatar_url'] as String,
    );
  }
}
