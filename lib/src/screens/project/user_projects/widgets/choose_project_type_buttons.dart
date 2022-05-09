import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:union_app/src/screens/project/user_projects/bloc/user_projects_bloc.dart';
import 'package:union_app/src/theme.dart';

class ChooseProjectTypeWidget extends StatelessWidget {
  const ChooseProjectTypeWidget(
      {Key? key,
      required ProjectType projectType,
      required Function() myProjectsPressed,
      required Function() joinedProjectsPressed})
      : _projectType = projectType,
        _myProjectsPressed = myProjectsPressed,
        _joinedProjectsPressed = joinedProjectsPressed,
        super(key: key);

  final ProjectType _projectType;
  final Function() _myProjectsPressed;
  final Function() _joinedProjectsPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          GestureDetector(
            onTap: () => _myProjectsPressed(),
            child: Chip(
              label: Text(
                'My projects',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Lato',
                  color: _projectType == ProjectType.OWNED ? AppColors.primaryColor : AppColors.white07,
                ),
              ),
              labelPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 4),
              backgroundColor: _projectType == ProjectType.OWNED ? AppColors.backgroundLight : null,
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: () => _joinedProjectsPressed(),
            child: Chip(
              label: Text(
                'Joined projects',
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Lato',
                    color: _projectType == ProjectType.JOINED ? AppColors.primaryColor : AppColors.white07),
              ),
              labelPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 4),
              backgroundColor: _projectType == ProjectType.JOINED ? AppColors.backgroundLight : null,
            ),
          ),
        ],
      ),
    );
  }
}

