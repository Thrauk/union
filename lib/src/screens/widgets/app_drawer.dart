import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:union_app/src/models/models.dart';
import 'package:union_app/src/screens/app/app.dart';
import 'package:union_app/src/screens/app/bloc/app_bloc.dart';
import 'package:union_app/src/screens/article/user_articles/view/user_articles_page.dart';
import 'package:union_app/src/screens/experimental/organization/joined_organizations/view/joined_organizations_page.dart';
import 'package:union_app/src/screens/home/home.dart';
import 'package:union_app/src/screens/messaging/conversations/view/conversations_page.dart';
import 'package:union_app/src/screens/open_roles/view_user_applications/view/user_applications_page.dart';
import 'package:union_app/src/screens/profile/profile.dart';
import 'package:union_app/src/screens/project/user_projects/user_projects.dart';
import 'package:union_app/src/screens/search_results/multi_search/view/multi_search_page.dart';
import 'package:union_app/src/theme.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AppUser user = context.select((AppBloc bloc) => bloc.state.user);
    return Drawer(
      child: ListView(
        children: <Widget>[
          BlocBuilder<AppBloc, AppState>(builder: (BuildContext context, AppState state) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => ProfilePage(uid: user.id),
                  ),
                );
              },
              child: UserAccountsDrawerHeader(
                currentAccountPictureSize: const Size(85, 85),
                currentAccountPicture: Avatar(photo: state.userDetails.photo),
                accountName: context.select(
                  (AppBloc bloc) => Text(
                    state.userDetails.displayName ?? '',
                    style: AppStyles.textStyleBodyDark,
                  ),
                ),
                accountEmail: context.select(
                  (AppBloc bloc) => Text(
                    state.userDetails.email ?? '',
                    style: AppStyles.textStyleBodySmallDark,
                  ),
                ),
              ),
            );
          }),
          ListTile(
            onTap: () {
              Navigator.push(context, ConversationsPage.route());
            },
            leading: const Icon(
              Icons.message,
              color: Colors.white70,
            ),
            title: const Text(
              'Messages',
              style: AppStyles.textStyleBody,
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => UserProjectsPage(uid: context.read<AppBloc>().state.user.id),
                ),
              );
            },
            leading: const Icon(
              Icons.analytics,
              color: Colors.white70,
            ),
            title: const Text(
              'My projects',
              style: AppStyles.textStyleBody,
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => UserArticlesPage(uid: context.read<AppBloc>().state.user.id),
                ),
              );
            },
            leading: const Icon(
              Icons.article,
              color: Colors.white70,
            ),
            title: const Text(
              'My articles',
              style: AppStyles.textStyleBody,
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.push(context, UserApplicationsPage.route(context.read<AppBloc>().state.user.id));
            },
            leading: const Icon(
              Icons.analytics_outlined,
              color: Colors.white70,
            ),
            title: const Text(
              'My applications',
              style: AppStyles.textStyleBody,
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.push(context, JoinedOrganizationsPage.route());
            },
            leading: const Icon(
              Icons.group,
              color: Colors.white70,
            ),
            title: const Text(
              'Organizations',
              style: AppStyles.textStyleBody,
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.push(context, MultiSearchPage.route());
            },
            leading: const Icon(
              Icons.search,
              color: Colors.white70,
            ),
            title: const Text(
              'Search',
              style: AppStyles.textStyleBody,
            ),
          ),
          const ListTile(
            leading: Icon(
              Icons.settings,
              color: Colors.white70,
            ),
            title: Text(
              'Settings',
              style: AppStyles.textStyleBody,
            ),
          ),
          GestureDetector(
            onTap: () {
              context.read<AppBloc>().add(AppLogoutRequested());
              Navigator.of(context).popUntil((Route<void> route) => false);
            },
            child: const ListTile(
              leading: Icon(
                Icons.logout,
                color: Colors.white70,
              ),
              title: Text(
                'Log Out',
                style: AppStyles.textStyleBody,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
