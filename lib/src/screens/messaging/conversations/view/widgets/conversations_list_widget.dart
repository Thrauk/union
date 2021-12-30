import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:union_app/src/screens/app/app.dart';
import 'package:union_app/src/screens/messaging/conversations/bloc/conversations_bloc.dart';
import 'package:union_app/src/screens/messaging/conversations/view/widgets/conversations_list_element_widget.dart';

class ConversationsListWidget extends StatelessWidget {
  const ConversationsListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String uid = context.select((AppBloc bloc) => bloc.state.user.id);
    return BlocBuilder<ConversationsBloc, ConversationsState>(
        builder: (BuildContext context, ConversationsState state) {
          return ListView.builder(
              itemCount: state.conversations.length,
              shrinkWrap: false,
              itemBuilder: (BuildContext context, int index) {
            return ConversationsListElementWidget(uid: state.conversations[index].members.where((String member) => member != uid).first, conversation: state.conversations[index]);
          });
        },
    );

    }
  }
