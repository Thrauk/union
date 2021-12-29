import 'package:bubble/bubble.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:union_app/src/models/chat/chat_message.dart';
import 'package:union_app/src/screens/messaging/chat/bloc/chat_bloc.dart';
import 'package:union_app/src/theme.dart';

class ChatListWidget extends StatefulWidget {
  const ChatListWidget({Key? key, required this.chatMessages, required this.loggedUid}) : super(key: key);

  final List<ChatMessage> chatMessages;
  final String loggedUid;

  @override
  ChatListWidgetState createState() => ChatListWidgetState();

}

class ChatListWidgetState extends State<ChatListWidget> {
  late final ScrollController _scrollController;

  @override
  Widget build(BuildContext context) {
    final ListView listView = ListView.builder(
      controller: _scrollController,
      itemCount: widget.chatMessages.length,
      shrinkWrap: false,
      itemBuilder: (BuildContext context, int index) {
        final bool isFirstMessage = index == 0 || widget.chatMessages[index].authorId != widget.chatMessages[index-1].authorId;
        final double spacingTop = isFirstMessage ? 10 : 2;
        return widget.chatMessages[index].authorId == widget.loggedUid
            ? Bubble(
                margin: BubbleEdges.only(top: spacingTop, left: 50),
                nip: BubbleNip.rightTop,
                showNip: isFirstMessage,
                alignment: Alignment.topRight,
                color: AppColors.primaryColor,
                child: Text(widget.chatMessages[index].message, textAlign: TextAlign.right, style: AppStyles.textStyleBodySmallDark,),
              )
            : Bubble(
                margin: BubbleEdges.only(top: spacingTop, right: 50),
                nip: BubbleNip.leftTop,
                showNip: isFirstMessage,
                alignment: Alignment.topLeft,
                child: Text(widget.chatMessages[index].message, textAlign: TextAlign.left, style: AppStyles.textStyleBodySmallDark,),
              );
      },
    );
    WidgetsBinding.instance!.addPostFrameCallback((_){

      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);

    });

    return listView;
  }

  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
