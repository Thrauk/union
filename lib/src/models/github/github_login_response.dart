class GithubLoginResponse {
  GithubLoginResponse({
    required this.accessToken,
    required this.tokenType,
    required this.scope,
  });

  final String accessToken;
  final String tokenType;
  final String scope;

  static GithubLoginResponse fromJson(Map<String, dynamic> jsonBody) {
    return GithubLoginResponse(
      accessToken: jsonBody['access_token'] as String,
      tokenType: jsonBody['token_type'] as String,
      scope: jsonBody['scope'] as String,
    );
  }
}
