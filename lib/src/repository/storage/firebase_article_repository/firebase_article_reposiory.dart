import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:union_app/src/models/article.dart';

class FirebaseArticleRepository {
  final DocumentReference<Map<String, dynamic>> firestoreArticleDocument =
      FirebaseFirestore.instance.collection('articles').doc();

  final CollectionReference<Map<String, dynamic>> firestoreArticleCollection =
      FirebaseFirestore.instance.collection('articles');

  final CollectionReference<Map<String, dynamic>> firestoreUserInstance =
      FirebaseFirestore.instance.collection('users');

  void createArticle(Article article) {
    final Article articleToSave =
        article.copyWith(id: firestoreArticleDocument.id);
    firestoreUserInstance.doc(article.ownerId).update({
      'articles_ids': FieldValue.arrayUnion([articleToSave.id])
    });
    firestoreArticleDocument.set(articleToSave.toJson());
  }
}
