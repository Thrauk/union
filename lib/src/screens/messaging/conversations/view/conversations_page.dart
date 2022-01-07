import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:union_app/src/screens/app/app.dart';
import 'package:union_app/src/screens/messaging/conversations/bloc/conversations_bloc.dart';
import 'package:union_app/src/screens/messaging/conversations/view/widgets/conversations_list_widget.dart';
import 'package:union_app/src/screens/widgets/app_bottom_nav_bar/app_bottom_nav_bar.dart';
import 'package:union_app/src/screens/widgets/app_drawer.dart';
import 'package:union_app/src/theme.dart';

class ConversationsPage extends StatelessWidget {
  const ConversationsPage({Key? key}) : super(key: key);

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const ConversationsPage());
  }

  @override
  Widget build(BuildContext context) {
    final String uid = context.select((AppBloc bloc) => bloc.state.user.id);
    return Scaffold(
      drawer: const AppDrawer(),
      bottomNavigationBar: const CustomNavBar(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        title: const Text('Conversations', style: AppStyles.textStyleBodyBig),
      ),
      body: BlocProvider<ConversationsBloc>(
        create: (_) => ConversationsBloc(
          uid: uid,
        ),
        child: const ConversationsListWidget(),
      ),
    );
  }
}
