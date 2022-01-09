import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:union_app/src/models/article.dart';
import 'package:union_app/src/models/models.dart';
import 'package:union_app/src/screens/article/article_details/article_details_page.dart';
import 'package:union_app/src/screens/home/home.dart';
import 'package:union_app/src/util/date_format_utils.dart';

import '../../../../theme.dart';

class ArticlesListElementWidget extends StatelessWidget {
  const ArticlesListElementWidget({Key? key, required Article article, required FullUser user})
      : _article = article,
        _user = user,
        super(key: key);

  final Article _article;
  final FullUser _user;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => ArticleDetailsPage(
              article: _article,
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
                  Avatar(
                    photo: _user.photo,
                    avatarSize: 22,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    _user.displayName ?? '',
                    overflow: TextOverflow.ellipsis,
                    style: AppStyles.textStyleBody,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'on ${DateFormatUtils.timestampToDate(_article.date)}',
                    style: AppStyles.textStyleBodySmall,
                  ),
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
                    ),
                    child: GestureDetector(
                      child: Text(
                        _article.body ?? '',
                        style: AppStyles.textStyleBody,
                        overflow: TextOverflow.ellipsis,
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
  }
}
