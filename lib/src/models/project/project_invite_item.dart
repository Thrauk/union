import 'package:union_app/src/models/models.dart';

class ProjectInviteItem {
  ProjectInviteItem(this.receiverUid, this.sender, this.project, this.id);

  final String receiverUid;
  final FullUser sender;
  final Project project;
  final String id;
}
