import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:union_app/src/screens/app/app.dart';
import 'package:union_app/src/screens/messaging/chat/bloc/chat_bloc.dart';
import 'package:union_app/src/screens/widgets/app_drawer.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({Key? key, required this.partnerUid}) : super(key: key);

  static Route<void> route(String partnerUid) {
    return MaterialPageRoute<void>(builder: (_) => ChatPage(partnerUid: partnerUid));
  }

  final String partnerUid;

  @override
  Widget build(BuildContext context) {
    final String uid = context.select((AppBloc bloc) => bloc.state.user.id);
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(backgroundColor: Colors.transparent, shadowColor: Colors.transparent, title: const Text('Chattin ')),
      body: BlocProvider<ChatBloc>(
        create: (_) => ChatBloc(
          myUid: uid,
          partnerUid: partnerUid,
        ),
        child: _EditProfilePage(),
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
      child: BlocBuilder<ChatBloc, ChatState>(
        builder: (BuildContext context, ChatState state) {
          return Column(
            children: <Widget>[
              Flexible(
                child: ListView.builder(
                  shrinkWrap: false,
                  itemCount: state.messages.length,
                  itemBuilder: (BuildContext context, int index) {
                    return state.messages[index].authorId == uid
                        ? Bubble(
                      margin: const BubbleEdges.only(top: 10, left: 50),
                      alignment: Alignment.topRight,
                      color: Color.fromRGBO(225, 255, 199, 1.0),
                      child: Text(state.messages[index].message, textAlign: TextAlign.right),
                    )
                        : Bubble(
                      margin: const BubbleEdges.only(top: 10, right: 50),
                      alignment: Alignment.topLeft,
                      child: Text(state.messages[index].message, textAlign: TextAlign.right),
                    );
                  },
                ),
              ),
              Row(
                children: <Widget>[
                  Flexible(
                    child: TextField(
                      onChanged: (String value) => context.read<ChatBloc>().add(ComposedMessageChanged(message: value)),
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      maxLines: 5,
                      minLines: 1,
                      keyboardType: TextInputType.multiline,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      context.read<ChatBloc>().add(SendMessage());
                    },
                    icon: const Icon(
                      Icons.send,
                      color: Colors.white38,
                    ),
                  )
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
