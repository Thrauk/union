import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:union_app/src/models/models.dart';
import 'package:union_app/src/models/organization/organization.dart';
import 'package:union_app/src/screens/app/app.dart';
import 'package:union_app/src/screens/article/article_details/article_details_page.dart';
import 'package:union_app/src/screens/home/home.dart';
import 'package:union_app/src/screens/organization/joined_organizations/view/widgets/organizations_list_view_element.dart';
import 'package:union_app/src/screens/project/project_details/view/project_details_page.dart';
import 'package:union_app/src/screens/search_results/multi_search/bloc/multi_search_page_bloc.dart';
import 'package:union_app/src/screens/user_profile/profile/profile.dart';
import 'package:union_app/src/theme.dart';
import 'package:union_app/src/utils/date_format_utils.dart';

class MultiSearchPage extends StatelessWidget {
  const MultiSearchPage({Key? key}) : super(key: key);

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const MultiSearchPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        title: const Text('Search', style: AppStyles.textStyleBodyBig),
      ),
      body: BlocProvider<MultiSearchPageBloc>(
        create: (_) => MultiSearchPageBloc(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              _SearchBarWidget(),
              _SearchTypeChips(),
              Flexible(child: _ResultListView()),
            ],
          ),
        ),
      ),
    );
  }
}

class _SearchBarWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        GestureDetector(
            onTap: () {
              final FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus) {
                currentFocus.unfocus();
              }
              context.read<MultiSearchPageBloc>().add(SearchPressed());
            },
            child: const Icon(Icons.search, color: Colors.white)),
        const SizedBox(width: 6),
        Expanded(
          child: TextField(
            onChanged: (String value) => context.read<MultiSearchPageBloc>().add(QueryTextChanged(queryText: value)),
            style: AppStyles.textStyleBody,
            cursorColor: AppColors.white07,
            decoration: const InputDecoration(
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              hintText: 'Search something...',
            ),
          ),
        ),
      ],
    );
  }
}

class _ResultListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String uid = context.select((AppBloc bloc) => bloc.state.user.id);
    return BlocBuilder<MultiSearchPageBloc, MultiSearchPageState>(
      builder: (BuildContext context, MultiSearchPageState state) {
        return ListView.builder(
            itemCount: state.resultList.length,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              if (state.searchType == SearchType.user) {
                return _UserListElement(element: state.resultList[index]);
              } else if (state.searchType == SearchType.project) {
                return _ProjectListElement(element: state.resultList[index]);
              } else if (state.searchType == SearchType.article) {
                return _ArticleListElement(element: state.resultList[index]);
              }
              return OrganizationListViewElement(organization: state.resultList[index] as Organization, loggedUid: uid);
            });
      },
    );
  }
}

class _UserListElement extends StatelessWidget {
  const _UserListElement({required dynamic element}) : user = element as FullUser;

  final FullUser user;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(ProfilePage.route(uid: user.id));
      },
      child: Card(
        color: AppColors.backgroundDark,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              Avatar(
                photo: user.photo,
                avatarSize: 24,
              ),
              const SizedBox(
                width: 8,
              ),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      user.displayName ?? '',
                      style: AppStyles.textStyleBody,
                    ),
                    Text(
                      user.jobTitle ?? '',
                      style: AppStyles.textStyleBodySmall,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _ProjectListElement extends StatelessWidget {
  const _ProjectListElement({required dynamic element}) : project = element as Project;

  final Project project;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => ProjectDetailsPage(
              project: project,
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
                  const Icon(
                    Icons.analytics,
                    color: AppColors.primaryColor,
                  ),
                  const SizedBox(width: 6),
                  Text(project.title!, overflow: TextOverflow.ellipsis, style: AppStyles.buttonTextStylePrimaryColor),
                ],
              ),
              const SizedBox(
                height: 6,
              ),
              Row(
                children: <Widget>[
                  const Text(
                    'Created by ',
                    overflow: TextOverflow.ellipsis,
                    style: AppStyles.textStyleBodySmall,
                  ),
                  Text(
                    ' on ${DateFormatUtils.timestampToDate(project.timestamp)}',
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
                        project.shortDescription,
                        style: AppStyles.textStyleBody,
                        overflow: TextOverflow.ellipsis,
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

class _ArticleListElement extends StatelessWidget {
  const _ArticleListElement({required dynamic element}) : article = element as Article;

  final Article article;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => ArticleDetailsPage(
              article: article,
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
              const SizedBox(
                height: 16,
              ),
              Wrap(
                children: [
                  ConstrainedBox(
                    constraints: const BoxConstraints(
                      minHeight: 14,
                    ),
                    child: GestureDetector(
                      child: Text(
                        article.body ?? '',
                        style: AppStyles.textStyleBody,
                        overflow: TextOverflow.ellipsis,
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

class _SearchTypeChips extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MultiSearchPageBloc, MultiSearchPageState>(
      buildWhen: (MultiSearchPageState previous, MultiSearchPageState current) => previous.resultList != current.resultList,
      builder: (BuildContext context, MultiSearchPageState state) {
        return Row(
          children: <Widget>[
            GestureDetector(
              onTap: () {
                if (state.searchType != SearchType.user) {
                  context.read<MultiSearchPageBloc>().add(const SearchTypeChanged(searchType: SearchType.user));
                }
              },
              child: Chip(
                label: Text(
                  'Users',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Lato',
                    color: state.searchType == SearchType.user ? AppColors.primaryColor : AppColors.white07,
                  ),
                ),
                labelPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 4),
                backgroundColor: state.searchType == SearchType.user ? AppColors.backgroundLight : null,
              ),
            ),
            const SizedBox(width: 8),
            GestureDetector(
              onTap: () {
                if (state.searchType != SearchType.project) {
                  context.read<MultiSearchPageBloc>().add(const SearchTypeChanged(searchType: SearchType.project));
                }
              },
              child: Chip(
                label: Text(
                  'Projects',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Lato',
                    color: state.searchType == SearchType.project ? AppColors.primaryColor : AppColors.white07,
                  ),
                ),
                labelPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 4),
                backgroundColor: state.searchType == SearchType.project ? AppColors.backgroundLight : null,
              ),
            ),
            const SizedBox(width: 8),
            GestureDetector(
              onTap: () {
                if (state.searchType != SearchType.article) {
                  context.read<MultiSearchPageBloc>().add(const SearchTypeChanged(searchType: SearchType.article));
                }
              },
              child: Chip(
                label: Text(
                  'Articles',
                  style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Lato',
                      color: state.searchType == SearchType.article ? AppColors.primaryColor : AppColors.white07),
                ),
                labelPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 4),
                backgroundColor: state.searchType == SearchType.article ? AppColors.backgroundLight : null,
              ),
            ),
            const SizedBox(width: 8),
            GestureDetector(
              onTap: () {
                if (state.searchType != SearchType.organization) {
                  context.read<MultiSearchPageBloc>().add(const SearchTypeChanged(searchType: SearchType.organization));
                }
              },
              child: Chip(
                label: Text(
                  'Organizations',
                  style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Lato',
                      color: state.searchType == SearchType.organization ? AppColors.primaryColor : AppColors.white07),
                ),
                labelPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 4),
                backgroundColor: state.searchType == SearchType.organization ? AppColors.backgroundLight : null,
              ),
            ),
          ],
        );
      },
    );
  }
}
