class GithubMail {
  const GithubMail({
    required this.email,
    required this.primary,
  });

  final String email;
  final bool primary;

  static GithubMail fromJson(Map<String, dynamic> json) {
    return GithubMail(
      email: json['email'] as String,
      primary: json['primary'] as bool,
    );
  }
}
