import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:union_app/src/screens/article/edit_article/bloc/edit_article_bloc.dart';
import 'package:union_app/src/theme.dart';

class BodyInputWidget extends StatelessWidget {
  const BodyInputWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditArticleBloc, EditArticleState>(
      buildWhen: (EditArticleState previous, EditArticleState current) =>
          previous.article.body != current.article.body,
      builder: (BuildContext context, EditArticleState state) {
        return TextFormField(
          initialValue: state.article.body,
          onChanged: (String value) =>
              context.read<EditArticleBloc>().add(BodyChanged(value)),
          style: AppStyles.textStyleBody,
          minLines: 1,
          maxLines: null,
          cursorColor: AppColors.white07,
          decoration: const InputDecoration(
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            hintText: 'Start writing here...',
            border: InputBorder.none,
          ),
        );
      },
    );
  }
}
