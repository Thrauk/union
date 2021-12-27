import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:union_app/src/models/article.dart';
import 'package:union_app/src/repository/storage/firebase_article_repository/firebase_article_reposiory.dart';
import 'package:union_app/src/screens/article/article_details/article_details_page.dart';
import 'package:union_app/src/screens/article/user_articles/widget/article_item_widget/bloc/article_item_widget_bloc.dart';
import 'package:union_app/src/theme.dart';
import 'package:flutter/rendering.dart';
import 'package:union_app/src/models/models.dart';
import 'package:union_app/src/util/date_format_utils.dart';

class ArticleItemWidget extends StatelessWidget {
  const ArticleItemWidget({Key? key, required this.article}) : super(key: key);

  final Article article;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      child: _ArticleItemWidget(article: article),
      create: (_) => ArticleItemWidgetBloc(FirebaseArticleRepository())
        ..add(GetDetails(article.ownerId)),
    );
  }
}

class _ArticleItemWidget extends StatelessWidget {
  const _ArticleItemWidget({Key? key, required this.article}) : super(key: key);

  final Article article;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ArticleItemWidgetBloc, ArticleItemWidgetState>(
      buildWhen:
          (ArticleItemWidgetState previous, ArticleItemWidgetState current) {
        return (previous.ownerDisplayName != current.ownerDisplayName) ||
            (previous.ownerPhotoUrl != current.ownerPhotoUrl ||
                previous.isExpanded != current.isExpanded);
      },
      builder: (BuildContext context, ArticleItemWidgetState state) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => ArticleDetailsPage(
                  article: article,
                ),
              ),
            );
          },
          child: Card(
            color: AppColors.backgroundLight,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: state.ownerPhotoUrl != ''
                                  ? NetworkImage(state.ownerPhotoUrl!)
                                  : const AssetImage('assets/icons/user.png')
                                      as ImageProvider),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        state.ownerDisplayName!,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontFamily: 'Lato',
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.white09,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                          ' on ${DateFormatUtils.timestampToDate(article.date)}',
                      style: AppStyles.textStyleBodySmall,),
                      const Spacer(),
                      const Image(
                          image: AssetImage('assets/icons/three_dots.png'))
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Wrap(
                    children: [
                      ConstrainedBox(
                        constraints: const BoxConstraints(
                          minHeight: 14,
                          maxHeight: 14 * 3,
                        ),
                        child: GestureDetector(
                          child: Text(
                            article.body ?? '',
                            overflow: state.isExpanded == false
                                ? TextOverflow.ellipsis
                                : TextOverflow.visible,
                            style: const TextStyle(
                              fontFamily: 'Lato',
                              fontSize: 14,
                              color: AppColors.white07,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
