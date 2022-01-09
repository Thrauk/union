import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:union_app/src/models/chat/conversation.dart';
import 'package:union_app/src/screens/home/home.dart';
import 'package:union_app/src/screens/messaging/chat/view/chat_page.dart';
import 'package:union_app/src/theme.dart';

import 'bloc/element_bloc.dart';

class ConversationsListElementWidget extends StatelessWidget {
  const ConversationsListElementWidget({Key? key, required this.uid, required this.conversation}) : super(key: key);

  final String uid;
  final Conversation conversation;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ElementBloc>(
      create: (_) => ElementBloc(uid: uid),
      child: BlocBuilder<ElementBloc, ElementState>(
        builder: (BuildContext context, ElementState state) {
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(ChatPage.route(uid));
            },
            child: Card(
              color: AppColors.backgroundDark,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    Avatar(
                      photo: state.user.photo,
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
                            state.user.displayName ?? '',
                            style: AppStyles.textStyleBody,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                conversation.lastMessage!.message,
                                style: AppStyles.textStyleBodySmall,
                              ),
                              Text(
                                DateFormat('kk:mm').format(DateTime.fromMicrosecondsSinceEpoch(conversation.lastReceivedTimestamp!)),
                                style: AppStyles.textStyleBodySmall,
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
