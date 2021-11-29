import 'package:union_app/src/repository/storage/firebase_project_repository/firebase_project_repository.dart';
import 'package:union_app/src/repository/storage/storage.dart';

class FirebaseStorageRepository {
  final FirebaseUserServiceRepository userService = FirebaseUserServiceRepository();
  final FirebaseProjectRepository projectRepository = FirebaseProjectRepository();
}
