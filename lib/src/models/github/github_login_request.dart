class GithubLoginRequest {
  GithubLoginRequest({
    required this.clientId,
    required this.clientSecret,
    required this.code,
  });

  final String clientId;
  final String clientSecret;
  final String code;

  Map<String,dynamic> toJson() => <String,dynamic>{
    'client_id' : clientId,
    'client_secret' : clientSecret,
    'code' : code,
  };
}
