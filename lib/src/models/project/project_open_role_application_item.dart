import 'package:union_app/src/models/models.dart';

class ProjectOpenRoleApplicationItem {
  ProjectOpenRoleApplicationItem(this.notice, this.user, this.id, {this.cvUrl = ''});

  final String cvUrl;
  final String notice;
  final FullUser user;
  final String id;
}
