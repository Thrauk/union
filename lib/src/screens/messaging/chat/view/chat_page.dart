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
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          title: const Center(child: Text('Chattin'))),
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
              Expanded(
                flex: 9,
                child: ListView.builder(
                  shrinkWrap: false,
                  itemCount: state.messages.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Align(
                      alignment: state.messages[index].authorId == uid ? Alignment.centerRight : Alignment.centerLeft,
                      child: Text(
                        state.messages[index].message,
                        style: TextStyle(
                          color: Colors.white38
                        ),
                      ),
                    );
                  },
                ),
              ),
              Expanded(
                flex: 1,
                child: Row(
                  children: <Widget>[
                    Flexible(
                      child: TextField(
                        onChanged: (String value) => context.read<ChatBloc>().add(ComposedMessageChanged(message: value)),
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        context.read<ChatBloc>().add(SendMessage());
                      },
                      icon: const Icon(Icons.send, color: Colors.white38,),
                    )
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
