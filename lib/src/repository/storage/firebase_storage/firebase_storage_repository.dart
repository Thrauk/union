import 'package:union_app/src/repository/storage/firebase_project_repository/firebase_project_repository.dart';
import 'package:union_app/src/repository/storage/storage.dart';

class FirebaseStorageRepository {
  final FirebaseUserRepository userService = FirebaseUserRepository();
  final FirebaseProjectRepository projectRepository = FirebaseProjectRepository();
}
