import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:union_app/src/app_data/app_data.dart';
import 'package:union_app/src/models/github/github_repository_item.dart';
import 'package:url_launcher/url_launcher.dart';

class GithubRepository {
  factory GithubRepository() {
    return _singleton;
  }

  GithubRepository._internal();

  static final GithubRepository _singleton = GithubRepository._internal();

  final CollectionReference<Map<String, dynamic>> _firestoreGithubCollection =
  FirebaseFirestore.instance.collection('github_user_data');

  Future<void> queryOauthAuthorize() async {
    const String baseUrl = 'www.github.com';
    const String path = '/login/oauth/authorize';
    final List<String> scopeParams = <String>['public_repo', 'read:user', 'user:email'];
    final Map<String, dynamic> queryParams = <String, dynamic>{
      'client_id': AppData.GithubClientId,
      'scope': scopeParams,
    };
    final Uri uri = Uri.https(baseUrl, path, queryParams);
    try {
      await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
    } catch (e) {
      print(e);
    }
  }

  Future<List<GithubRepositoryItem>> getAllUsersRepositories(String uid) async {
    List<GithubRepositoryItem> repositories = <GithubRepositoryItem>[];
    final String token = await getUserGithubToken(uid);
    final Uri baseUrl = Uri.parse('https://api.github.com/user/repos');

    final http.Response response =
        await http.get(baseUrl, headers: {'Authorization': ' Bearer $token'});

    if (response.body != null) {
      final List jsonList = jsonDecode(response.body) as List;
      repositories = jsonList.map((el) => GithubRepositoryItem.fromJson(el as Map<String, dynamic>)).toList();
    }
    return repositories;
  }

  Future<String> getUserGithubToken(String uid) async{
    final DocumentSnapshot<Map<String, dynamic>> json = await _firestoreGithubCollection.doc(uid).get();
    return json['oauth_token'] as String;
  }

// Future<GithubRepositoryItem> getGithubRepository(String name) {
//     String baseUrl = 'https://api.github.com/repos/';
// }
}

// https://medium.com/flutter-community/implementing-firebase-github-authentication-in-flutter-1c49a172c648

// read about deep links
