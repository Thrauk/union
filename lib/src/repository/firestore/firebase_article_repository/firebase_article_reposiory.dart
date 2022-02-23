import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:union_app/src/models/article/article.dart';

class FirebaseArticleRepository {
  final DocumentReference<Map<String, dynamic>> firestoreArticleDocument =
      FirebaseFirestore.instance.collection('articles').doc();

  final CollectionReference<Map<String, dynamic>> firestoreArticleCollection =
      FirebaseFirestore.instance.collection('articles');

  final CollectionReference<Map<String, dynamic>> firestoreUserInstance = FirebaseFirestore.instance.collection('users');

  void createArticle(Article article) {
    final Article articleToSave = article.copyWith(id: firestoreArticleDocument.id);
    firestoreUserInstance.doc(article.ownerId).update({
      'articles_ids': FieldValue.arrayUnion([articleToSave.id])
    });
    firestoreArticleDocument.set(articleToSave.toJson());
  }

  Future<Map<String, String>?> getArticleUserDetails(String ownerId) async {
    try {
      final Map<String, dynamic>? data = (await firestoreUserInstance.doc(ownerId).get()).data();

      final String ownerName = data!['displayName'] != null ? data['displayName'] as String : '';
      final String ownerPhoto = data['photo'] != null ? data['photo'] as String : '';
      print('Ownername $ownerName');
      return <String, String>{'owner_name': ownerName, 'owner_photo': ownerPhoto};
    } catch (e) {
      print('getArticleUserDetails $e');
    }
    return null;
  }

  Future<Article?> getArticleById(String id) async {
    try {
      final DocumentSnapshot<Map<String, dynamic>> json = await firestoreArticleCollection.doc(id).get();
      print(json.data());
      final Article article = Article.fromJson(json.data()!);
      return article;
    } catch (e) {
      print('getArticleById: ${e.toString()}');
    }
    return null;
  }

  Future<List<Article>> getArticlesByUid(String uid) async {
    final List<Article> articles = List<Article>.empty(growable: true);
    final Map<String, dynamic>? articlesData;
    final List<String> articlesIds;
    try {
      articlesData = (await firestoreUserInstance.doc(uid).get()).data();

      articlesIds = (articlesData!['articles_ids'] as List<dynamic>).map((el) => el as String).toList();
      print(articlesIds);
      for (final String id in articlesIds) {
        final Article? article = await getArticleById(id);
        if (article != null) {
          articles.add(article);
        }
      }
    } catch (e) {
      print('getArticlesByUid $e');
    }
    return articles;
  }

  Future<List<Article>> getQueryArticlesByUid(String uid) async {
    final QuerySnapshot<Map<String, dynamic>> query = await firestoreArticleCollection.where('owner_id', isEqualTo: uid).get();
    return _userArticlesFromQuery(query);
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

  void deleteArticle(Article article) {
    try {
      firestoreArticleCollection.doc(article.id).delete();
      firestoreUserInstance.doc(article.ownerId).update({
        'articles_ids': FieldValue.arrayRemove([article.id])
      });
    } catch (e) {
      print('deleteArticle $e');
    }
  }

  void updateArticle(Article article) {
    firestoreArticleCollection.doc(article.id).update(article.toJson());
  }

  Future<List<Article>> getArticles(int limit) async {
    final List<Article> articles = (await firestoreArticleCollection.orderBy('date', descending: true).limit(limit).get())
        .docs
        .map((QueryDocumentSnapshot<Map<String, dynamic>> e) => Article.fromJson(e.data()))
        .toList();
    return articles;
  }

  // DEMO FUNCTION, SHOULD NOT BE USED OTHERWISE
  Future<List<Article>> getAllArticles() async {
    final List<Article> articles = (await firestoreArticleCollection.get())
        .docs
        .map((QueryDocumentSnapshot<Map<String, dynamic>> articleJson) => Article.fromJson(articleJson.data()))
        .toList();
    return articles;
  }
}
