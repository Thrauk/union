class UserGithubData {
  const UserGithubData({
    required this.uid,
    required this.githubUsername,
    required this.oAuthToken,
  });

  final String uid;
  final String githubUsername;
  final String oAuthToken;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'uid': uid,
      'github_username': githubUsername,
      'oauth_token': oAuthToken,
    };
  }

  static UserGithubData fromJson(Map<String, dynamic> json) {
    return UserGithubData(
      uid: json['uid'] as String,
      githubUsername: json['github_username'] as String,
      oAuthToken: json['oauth_token'] as String,
    );
  }
}
