import 'package:http/http.dart' as http;
import 'package:uni_links/uni_links.dart';
import 'package:union_app/src/app_data/app_data.dart';
import 'package:url_launcher/url_launcher.dart';

class GithubRepository {
  factory GithubRepository() {
    return _singleton;
  }

  GithubRepository._internal();

  static final GithubRepository _singleton = GithubRepository._internal();

  Future<void> queryOauthAuthorize() async {
    const String baseUrl = 'www.github.com';
    const String path = '/login/oauth/authorize';
    final List<String> scopeParams = <String>[
      'public_repo',
      'read:user',
      'user:email'
    ];
    final Map<String, dynamic> queryParams = <String, dynamic> {
      'client_id' : AppData.GithubClientId,
      'scope' : scopeParams,
    };
    final Uri uri = Uri.https(baseUrl, path, queryParams);
    try{
      await launchUrl(uri, mode:LaunchMode.externalApplication,); }
        catch(e){print(e);};

    // linkStream.listen((String? link) async {
    //   final String code = link!.substring(link.indexOf(RegExp('code=')) + 5);
    //   final dynamic response = await http.post(
    //     Uri.parse('https://github.com/login/oauth/access_token'),
    //     headers: {
    //       "Content-Type": "application/json",
    //       "Accept": "application/json"
    //     },
    //     body: jsonEncode(GitHubLoginRequest(
    //       clientId: "${yourCredentialId},
    //       clientSecret: ${yourClientSecret},
    //       code: code,
    //     )),
    //   );
    // }, cancelOnError: true,
    //   );
    // });

  }
}

// https://medium.com/flutter-community/implementing-firebase-github-authentication-in-flutter-1c49a172c648

// read about deep links