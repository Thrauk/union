import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:union_app/src/models/models.dart';
import 'package:union_app/src/screens/home/home.dart';
import 'package:union_app/src/screens/project/project_details/view/project_details_page.dart';

import '../../../../theme.dart';

class ProjectListElementWidget extends StatelessWidget {
  const ProjectListElementWidget({Key? key, required Project project, required FullUser user})
      : _project = project,
        _user = user,
        super(key: key);

  final Project _project;
  final FullUser _user;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) => ProjectDetailsPage(
              project: _project,
            ),
          ),
        );
      },
      child: Card(
        color: AppColors.backgroundLight,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                _project.title!,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontFamily: 'Lato',
                  fontSize: 18,
                  color: AppColors.white09,
                ),
              ),

              const SizedBox(height: 12),
              Wrap(
                children: [
                  ConstrainedBox(
                    constraints: const BoxConstraints(
                      minHeight: 14,
                    ),
                    child: GestureDetector(
                      child: Text(
                        _project.shortDescription,
                        style: const TextStyle(
                          fontFamily: 'Lato',
                          fontSize: 14,
                          color: AppColors.white07,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),

              Row(
                children: <Widget>[
                  Avatar(photo: _user.photo, avatarSize: 10,),
                  const SizedBox(width: 10),
                  Text(
                    'Created by ${_user.displayName}',
                    overflow: TextOverflow.ellipsis,
                    style: AppStyles.textStyleBodySmall,
                  ),
                  const Spacer(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
