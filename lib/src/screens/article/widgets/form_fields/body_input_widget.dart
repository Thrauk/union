import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:union_app/src/screens/article/bloc/create_article_bloc.dart';
import 'package:union_app/src/theme.dart';

class BodyInputWidget extends StatelessWidget {
  const BodyInputWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateArticleBloc, CreateArticleState>(
      buildWhen: (CreateArticleState previous, CreateArticleState current) =>
      previous.body != current.body,
      builder: (BuildContext context, CreateArticleState state) {
        return  TextField(
          onChanged: (String value) => context.read<CreateArticleBloc>().add(BodyChanged(value)),
          style: AppStyles.textStyleBody,
          minLines: 1,
          maxLines: null,
          cursorColor: AppColors.white07,
          decoration: const InputDecoration(
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              hintText: 'Start writing here...',
              border: InputBorder.none),
        );
      },
    );
  }
}
