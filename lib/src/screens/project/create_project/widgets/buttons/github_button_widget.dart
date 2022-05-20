import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:union_app/src/models/github/github_repository_item.dart';
import 'package:union_app/src/screens/github/user_repositories/view/user_repositories_page.dart';
import 'package:union_app/src/screens/project/create_project/bloc/bloc.dart';
import 'package:union_app/src/screens/widgets/github/github_repository_widget/github_repository_widget.dart';
import 'package:union_app/src/theme.dart';

class GithubButtonWidget extends StatelessWidget {
  const GithubButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateProjectBloc, CreateProjectState>(
      buildWhen: (CreateProjectState previous, CreateProjectState current) {
        return previous.githubRepository != current.githubRepository;
      },
      builder: (BuildContext context, CreateProjectState state) {
        return state.githubRepository == GithubRepositoryItem.empty
            ? ElevatedButton(
                onPressed: () => Navigator.of(context).push(UserRepositoriesPage.route()).then(
                  (dynamic value) {
                    if (value != null) context.read<CreateProjectBloc>().add(RepositoryChosed(value as GithubRepositoryItem));
                  },
                ),
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
