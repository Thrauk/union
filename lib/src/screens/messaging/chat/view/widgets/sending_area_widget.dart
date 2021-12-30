import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:union_app/src/design/design.dart';
import 'package:union_app/src/screens/messaging/chat/bloc/chat_bloc.dart';
import 'package:union_app/src/theme.dart';

class SendingAreaWidget extends StatelessWidget {
  const SendingAreaWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    // MUST DISPOSE OF IT IN BLOC!!!
    final TextEditingController _controller = TextEditingController();

    return SizedBox(
      height: 45,
      child: Row(
        children: <Widget>[
          Flexible(
            child: TextField(
              onTap: () {
                context.read<ChatBloc>().add(ScrollToBottom());
              },
              controller: _controller,
              onChanged: (String value) => context.read<ChatBloc>().add(ComposedMessageChanged(message: value)),
              style: const TextStyle(
                color: AppColors.white09,
              ),
              decoration: TextFieldProprieties.revolutishInputDecoration(),
              cursorColor: AppColors.white09,
              maxLines: 5,
              minLines: 1,
              keyboardType: TextInputType.multiline,
            ),
          ),
          IconButton(
            onPressed: () {
              final FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus) {
                currentFocus.unfocus();
              }
              _controller.clear();
              context.read<ChatBloc>().add(SendMessage());
            },
            icon: const Icon(
              Icons.send,
              color: Colors.white38,
            ),
          )
        ],
      ),
    );
  }
}
