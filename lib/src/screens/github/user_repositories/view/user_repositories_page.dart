import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:union_app/src/models/github/github_repository_item.dart';
import 'package:union_app/src/screens/app/app.dart';
import 'package:union_app/src/screens/github/user_repositories/bloc/user_repositories_bloc.dart';
import 'package:union_app/src/screens/widgets/app_bar/simple_app_bar.dart';
import 'package:union_app/src/screens/widgets/exceptions/barrel.dart';
import 'package:union_app/src/screens/widgets/github/github_repository_widget/github_repository_widget.dart';
import 'package:union_app/src/theme.dart';

class UserRepositoriesPage extends StatelessWidget {
  const UserRepositoriesPage({Key? key}) : super(key: key);

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const UserRepositoriesPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SimpleAppBar(title: 'Repositories'),
      body: BlocProvider<UserRepositoriesBloc>(
        create: (BuildContext context) =>
            UserRepositoriesBloc()..add(GetUserRepositories(context.read<AppBloc>().state.user.id)),
        child: const _UserRepositoriesPage(),
      ),
    );
  }
}

class _UserRepositoriesPage extends StatelessWidget {
  const _UserRepositoriesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserRepositoriesBloc, UserRepositoriesState>(
      buildWhen: (UserRepositoriesState previous, UserRepositoriesState current) {
        return previous.status != current.status || previous.repositories != current.repositories;
      },
      builder: (BuildContext context, UserRepositoriesState state) {
        return Column(
          children: <Widget>[
            if (state.status == PageStatus.SUCCESSFUL)
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.repositories.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GithubRepositoryWidget(
                      repositoryItem: state.repositories[index],
                      onTap: (GithubRepositoryItem repository) {
                        Navigator.of(context).pop(repository);
                      },
                    );
                  },
                ),
              )
            else if (state.status == PageStatus.FAILED)
              const SomethingWentWrongWidget()
            else if (state.status == PageStatus.LOADING)
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primaryColor,
                  ),
                ),
              )
          ],
        );
      },
    );
  }
}
