import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:union_app/src/models/github/github_repository_item.dart';
import 'package:union_app/src/screens/github/user_repositories/view/user_repositories_page.dart';
import 'package:union_app/src/screens/project/create_project/bloc/bloc.dart';
import 'package:union_app/src/screens/project/create_project/create_project.dart';
import 'package:union_app/src/screens/widgets/github/github_repository_widget/github_repository_widget.dart';
import 'package:union_app/src/theme.dart';

class GithubButtonWidget extends StatelessWidget {
  const GithubButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateProjectBloc, CreateProjectState>(
      buildWhen: (CreateProjectState previous, CreateProjectState current) {
        return previous.githubRepository != current.githubRepository ||
            previous.isGithubAccountLinked != current.isGithubAccountLinked;
      },
      builder: (BuildContext context, CreateProjectState state) {
        return state.githubRepository == GithubRepositoryItem.empty
            ? ElevatedButton(
                onPressed: () {
                  state.isGithubAccountLinked == true
                      ? Navigator.of(context).push(UserRepositoriesPage.route()).then(
                          (dynamic value) {
                            if (value != null)
                              context.read<CreateProjectBloc>().add(RepositoryChosed(value as GithubRepositoryItem));
                          },
                        )
                      : showAlertDialog(context);
                },
                style: ElevatedButton.styleFrom(
                  primary: AppColors.backgroundLight,
                  minimumSize: const Size(double.infinity, 48),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                    Image(
                      image: AssetImage('assets/icons/github_icon.png'),
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Link GitHub Repository',
                      style: TextStyle(
                        color: AppColors.white07,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GithubRepositoryWidget(repositoryItem: state.githubRepository, onTap: (_) {}),
                  ElevatedButton(
                    onPressed: () => context.read<CreateProjectBloc>().add(RepositoryRemoved()),
                    style: ElevatedButton.styleFrom(
                      primary: AppColors.backgroundLight,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    child: Text(
                      'Remove',
                      style: AppStyles.textStyleBody.copyWith(color: AppColors.redLight),
                    ),
                  ),
                ],
              );
      },
    );
  }
}

void showAlertDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) => Center(
      child: AlertDialog(
        elevation: 20,
        actionsPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        actions: [
          const SizedBox(width: 16),
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: const Text(
              'Ok',
              style: AppStyles.textStyleBodyPrimary,
            ),
          ),
        ],
        backgroundColor: AppColors.backgroundLight,
        title: const Text('Hold on!', style: AppStyles.textStyleHeading1),
        content: const Text('Please link your GitHub account if you want to link a repository', style: AppStyles.textStyleBody),
      ),
    ),
  );
}
