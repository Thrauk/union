import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:union_app/src/models/article/article.dart';

class FirebaseArticleRepository {
  final DocumentReference<Map<String, dynamic>> _firestoreArticleDocument =
      FirebaseFirestore.instance.collection('articles').doc();

  final CollectionReference<Map<String, dynamic>> _firestoreArticleCollection =
      FirebaseFirestore.instance.collection('articles');

  final CollectionReference<Map<String, dynamic>> _firestoreUserInstance = FirebaseFirestore.instance.collection('users');

  final CollectionReference<Map<String, dynamic>> _firestoreProjectInstance = FirebaseFirestore.instance.collection('projects');

  void createArticle(Article article, {String projectId = ''}) {
    try {
      final Article articleToSave = article.copyWith(id: _firestoreArticleDocument.id);
      if (!article.isPublic)
        _addArticleToProject(_firestoreArticleDocument.id, projectId);

      _firestoreArticleDocument.set(articleToSave.toJson());
    } catch (e) {
      print('createArticle $e');
    }
  }

  void _addArticleToProject(String articleId, String projectId) {
    _firestoreProjectInstance.doc(projectId).update({
      'articles_id': FieldValue.arrayUnion(<String>[articleId])
    });
  }

  Future<Map<String, String>?> getArticleUserDetails(String ownerId) async {
    try {
      final Map<String, dynamic>? data = (await _firestoreUserInstance.doc(ownerId).get()).data();

      final String ownerName = data!['displayName'] != null ? data['displayName'] as String : '';
      final String ownerPhoto = data['photo'] != null ? data['photo'] as String : '';
      return <String, String>{'owner_name': ownerName, 'owner_photo': ownerPhoto};
    } catch (e) {
      print('getArticleUserDetails $e');
    }
    return null;
  }

  Future<Article?> getArticleById(String id) async {
    try {
      final DocumentSnapshot<Map<String, dynamic>> json = await _firestoreArticleCollection.doc(id).get();
      final Article article = Article.fromJson(json.data()!);
      return article;
    } catch (e) {
      print('getArticleById: ${e.toString()}');
    }
    return null;
  }

  Future<List<Article>> getQueryArticlesByUid(String uid, bool isPublic) async {
    final Query<Map<String, dynamic>> query = _firestoreArticleCollection.where('owner_id', isEqualTo: uid);
    final QuerySnapshot<Map<String, dynamic>> finalQuery =
        isPublic == true ? await query.where('is_public', isEqualTo: true).get() : await query.get();
    return _userArticlesFromQuery(finalQuery);
  }

  List<Article> _userArticlesFromQuery(QuerySnapshot<Map<String, dynamic>> query) {
    return query.docs.toList().map((QueryDocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
      final Map<String, dynamic> json = documentSnapshot.data();
      if (json != null) {
        return Article.fromJson(json);
      } else {
        return Article.empty;
      }
    }).toList()
      ..sort((Article a, Article b) => b.date.compareTo(a.date));
  }

  void deleteArticle(String articleId) {
    try {
      _firestoreArticleCollection.doc(articleId).delete();
    } catch (e) {
      print('deleteArticle $e');
    }
  }

  void updateArticle(Article article) {
    _firestoreArticleCollection.doc(article.id).update(article.toJson());
  }

  Future<List<Article>> getPublicArticles(int limit) async {
    final List<Article> articles = (await _firestoreArticleCollection
            .where('is_public', isEqualTo: true)
            .orderBy('date', descending: true)
            .limit(limit)
            .get())
        .docs
        .map((QueryDocumentSnapshot<Map<String, dynamic>> e) => Article.fromJson(e.data()))
        .toList();
    return articles;
  }

  // DEMO FUNCTION, SHOULD NOT BE USED OTHERWISE
  Future<List<Article>> getAllArticles() async {
    final List<Article> articles = (await _firestoreArticleCollection.get())
        .docs
        .map((QueryDocumentSnapshot<Map<String, dynamic>> articleJson) => Article.fromJson(articleJson.data()))
        .toList();
    return articles;
  }
}
