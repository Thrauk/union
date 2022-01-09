import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:union_app/src/models/models.dart';
import 'package:union_app/src/screens/home/home.dart';
import 'package:union_app/src/screens/project/project_details/view/project_details_page.dart';
import 'package:union_app/src/util/date_format_utils.dart';

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
          MaterialPageRoute(
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
              Row(
                children: <Widget>[
                  const Icon(Icons.analytics, color: AppColors.primaryColor,),
                  const SizedBox(width: 6),
                  Text(_project.title!, overflow: TextOverflow.ellipsis, style: AppStyles.buttonTextStylePrimaryColor),
                ],
              ),
              const SizedBox(
                height: 6,
              ),
              Row(
                children: <Widget>[
                  Text(
                    'Created by ${_user.displayName}',
                    overflow: TextOverflow.ellipsis,
                    style: AppStyles.textStyleBodySmall,
                  ),
                  Text(
                    ' on ${DateFormatUtils.timestampToDate(_project.timestamp)}',
                    overflow: TextOverflow.ellipsis,
                    style: AppStyles.textStyleBodySmall,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Wrap(
                children: <Widget>[
                  ConstrainedBox(
                    constraints: const BoxConstraints(
                      minHeight: 16,
                    ),
                    child: GestureDetector(
                      child: Text(
                        _project.shortDescription,
                        style: AppStyles.textStyleBody,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
