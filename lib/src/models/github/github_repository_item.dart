class GithubRepositoryItem {
  const GithubRepositoryItem(
      {required this.name,
      required this.url,
      required this.createdAt,
      required this.fullName,
      required this.watchersCount,
      required this.language,
      required this.forksCount});

  final String name;
  final String url;
  final String createdAt;
  final int watchersCount;
  final String? language;
  final int forksCount;
  final String fullName;

  static const GithubRepositoryItem empty = GithubRepositoryItem(
    url: '',
    name: '',
    createdAt: '',
    fullName: '',
    watchersCount: 0,
    language: '',
    forksCount: 0,
  );

  static GithubRepositoryItem fromJson(Map<String, dynamic> json) {
    return GithubRepositoryItem(
      name: json['name'] as String,
      url: json['html_url'] as String,
      createdAt: json['created_at'] as String,
      watchersCount: json['watchers_count'] as int,
      language: json['language'] as String?,
      forksCount: json['forks_count'] as int,
      fullName: json['full_name'] as String,
    );
  }
}
