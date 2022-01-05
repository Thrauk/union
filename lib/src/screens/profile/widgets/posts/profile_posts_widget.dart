import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:union_app/src/models/models.dart';
import 'package:union_app/src/screens/profile/bloc/profile_bloc.dart';
import 'package:union_app/src/screens/profile/widgets/articles/articles_list_widget.dart';
import 'package:union_app/src/screens/profile/widgets/projects/project_list_widget.dart';

import '../../../../theme.dart';

class ProfilePostsWidget extends StatelessWidget {
  const ProfilePostsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      buildWhen: (ProfileState previous, ProfileState current) => previous.selectedPosts != current.selectedPosts,
      builder: (BuildContext context, ProfileState state) {
        return Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    if (state.selectedPosts != SelectedPosts.project) {
                      context.read<ProfileBloc>().add(SelectedProjectsPosts());
                    }
                  },
                  child: Chip(
                    label: Text(
                      'Projects',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Lato',
                        color: state.selectedPosts == SelectedPosts.project ? AppColors.primaryColor : AppColors.white07,
                      ),
                    ),
                    labelPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 4),
                    backgroundColor: state.selectedPosts == SelectedPosts.project ? AppColors.backgroundLight : null,
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: () {
                    if (state.selectedPosts != SelectedPosts.article) {
                      context.read<ProfileBloc>().add(SelectedArticlesPosts());
                    }
                  },
                  child: Chip(
                    label: Text(
                      'Articles',
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Lato',
                          color: state.selectedPosts == SelectedPosts.article ? AppColors.primaryColor : AppColors.white07),
                    ),
                    labelPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 4),
                    backgroundColor: state.selectedPosts == SelectedPosts.article ? AppColors.backgroundLight : null,
                  ),
                ),
              ],
            ),
            if (state.selectedPosts == SelectedPosts.project)
              ProjectListWidget(
                uid: state.fullUser.id,
                user: state.fullUser,
              )
            else
              ArticlesListWidget(
                uid: state.fullUser.id,
                user: state.fullUser,
              ),
          ],
        );
      },
    );
  }
}
