import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:union_app/src/models/models.dart';
import 'package:union_app/src/screens/home/widgets/avatar.dart';
import 'package:union_app/src/screens/project/widgets/project_item_widget/view/project_item_widget.dart';
import 'package:union_app/src/theme.dart';

class InviteItemWidget extends StatelessWidget {
  const InviteItemWidget(
      {Key? key,
      required Project project,
      required FullUser sender,
      required Function(Project project) onAcceptPressed,
      required Function(Project project) onDeletePressed})
      : _project = project,
        _sender = sender,
        _onAcceptPressed = onAcceptPressed,
        _onDeletePressed = onDeletePressed,
        super(key: key);

  final Project _project;
  final FullUser _sender;
  final Function(Project project) _onAcceptPressed;
  final Function(Project project) _onDeletePressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              Avatar(
                photo: _sender.photo,
                avatarSize: 22,
              ),
              const SizedBox(width: 12),
              Text(
                _sender.displayName!,
                overflow: TextOverflow.ellipsis,
                style: AppStyles.textStyleBody.copyWith(fontWeight: FontWeight.w600),
              ),
              const Text(' invited you to this project', style: AppStyles.textStyleBody),
              const SizedBox(height: 12),
            ],
          ),
        ),
        ProjectItemWidget(project: _project),
        Row(
          children: <Widget>[
            ElevatedButton(
              onPressed: () => _onAcceptPressed(_project),
              style: ElevatedButton.styleFrom(
                primary: AppColors.backgroundLight,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              child: const Text(
                'Accept',
                style: AppStyles.textStyleBody,
              ),
            ),
            const SizedBox(width: 4),
            ElevatedButton(
              onPressed: () => _onDeletePressed(_project),
              style: ElevatedButton.styleFrom(
                primary: AppColors.backgroundLight,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              child: Text(
                'Delete',
                style: AppStyles.textStyleBody.copyWith(color: AppColors.redLight),
              ),
            )
          ],
        ),
      ],
    );
  }
}
