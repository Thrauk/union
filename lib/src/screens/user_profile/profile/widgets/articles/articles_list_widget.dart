import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:union_app/src/models/models.dart';

import 'articles_list_element_widget.dart';
import 'bloc/articles_list_bloc.dart';

class ArticlesListWidget extends StatelessWidget {
  const ArticlesListWidget({
    Key? key,
    required this.uid,
    required this.user,
  }) : super(key: key);

  final String uid;
  final FullUser user;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ArticlesListBloc>(
        create: (_) => ArticlesListBloc(uid: uid)..add(Initialize()),
        child: BlocBuilder<ArticlesListBloc, ArticlesListState>(
          builder: (BuildContext context, ArticlesListState state) {
            return ListView.builder(
                itemCount: state.articleList.length,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return ArticlesListElementWidget(
                    user: user,
                    article: state.articleList[index],
                  );
                });
          },
        ));
  }
}
