import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:union_app/src/models/github/github_repository_item.dart';
import 'package:union_app/src/theme.dart';

class GithubRepositoryWidget extends StatelessWidget {
  const GithubRepositoryWidget(
      {Key? key, required GithubRepositoryItem repositoryItem, required Function(GithubRepositoryItem) onTap})
      : _repositoryItem = repositoryItem,
        _onTap = onTap,
        super(key: key);

  final GithubRepositoryItem _repositoryItem;
  final Function(GithubRepositoryItem) _onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _onTap(_repositoryItem),
      child: Card(
        color: AppColors.backgroundLight,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  const Image(
                    image: AssetImage('assets/icons/github_icon.png'),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      _repositoryItem.fullName,
                      style: AppStyles.textStyleHeading1.copyWith(color: AppColors.white08),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  )
                ],
              ),
              const SizedBox(height: 8),
              Text('Created at ${_repositoryItem.createdAt}', style: AppStyles.textStyleBodySmall),
              const SizedBox(height: 12),
              Row(
                children: [
                  Text(
                    '${_repositoryItem.forksCount} forks • ${_repositoryItem.watchersCount} watchers',
                    style: AppStyles.textStyleBodyPrimarySmall,
                  ),
                  if (_repositoryItem.language != null)
                    Text(
                      ' • ${_repositoryItem.language!}',
                      style: AppStyles.textStyleBodyPrimarySmall,
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
