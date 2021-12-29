import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:union_app/src/design/design.dart';
import 'package:union_app/src/screens/app/app.dart';
import 'package:union_app/src/screens/home/home.dart';
import 'package:union_app/src/screens/messaging/chat/bloc/chat_bloc.dart';
import 'package:union_app/src/screens/messaging/chat/view/widgets/chat_list_widget.dart';
import 'package:union_app/src/screens/messaging/chat/view/widgets/sending_area_widget.dart';
import 'package:union_app/src/screens/widgets/app_drawer.dart';
import 'package:union_app/src/theme.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({Key? key, required this.partnerUid}) : super(key: key);

  static Route<void> route(String partnerUid) {
    return MaterialPageRoute<void>(builder: (_) => ChatPage(partnerUid: partnerUid));
  }

  final String partnerUid;

  @override
  Widget build(BuildContext context) {
    final String uid = context.select((AppBloc bloc) => bloc.state.user.id);
    return BlocProvider<ChatBloc>(
      create: (_) =>
          ChatBloc(
            myUid: uid,
            partnerUid: partnerUid,
          ),
      child: BlocBuilder<ChatBloc, ChatState>(
        builder: (BuildContext context, ChatState state) {
          return Scaffold(
            drawer: const AppDrawer(),
            appBar: AppBar(backgroundColor: Colors.transparent, shadowColor: Colors.transparent, title: Row(
              children: <Widget>[
                Avatar(avatarSize : 20,photo: context.select((ChatBloc bloc) => bloc.state.partnerUser.photo)),
                const SizedBox(width: 10,),
                Text(context.select((ChatBloc bloc) => bloc.state.partnerUser.displayName ?? ''), style: AppStyles.textStyleBodyBig,),
              ],
            )),
            body: _EditProfilePage(),
          );
        },
      ),
    );
  }
}

class _EditProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String uid = context.select((AppBloc bloc) => bloc.state.user.id);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          Expanded(
            child: BlocBuilder<ChatBloc, ChatState>(
                buildWhen: (ChatState previous, ChatState current) => previous.messages != current.messages,
                builder: (BuildContext context, ChatState state) {
                  return ChatListWidget(
                    loggedUid: uid,
                    chatMessages: state.messages,
                  );
                }),
          ),
          const SizedBox(
            height: 15,
          ),
          const SendingAreaWidget(),
        ],
      ),
    );
  }
}
