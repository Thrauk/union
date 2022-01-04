import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:union_app/src/screens/home/bloc/home_page_posts_bloc.dart';
import 'package:union_app/src/theme.dart';

class ChoosePostTypeWidget extends StatelessWidget {
  const ChoosePostTypeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomePagePostsBloc, HomePagePostsState>(
      buildWhen: (HomePagePostsState previous, HomePagePostsState current) {
        return previous.postType != current.postType;
      },
      builder: (BuildContext blocContext, HomePagePostsState state) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  context.read<HomePagePostsBloc>().add(GetProjects());
                },
                child: Chip(
                  label: Text(
                    'Projects',
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Lato',
                      color: state.postType == PostType.PROJECT ? AppColors.primaryColor : AppColors.white07,
                    ),
                  ),
                  labelPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 4),
                  backgroundColor: state.postType == PostType.PROJECT ? AppColors.backgroundLight : null,
                ),
              ),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: () {
                  context.read<HomePagePostsBloc>().add(GetArticles());
                },
                child: Chip(
                  label: Text(
                    'Articles',
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Lato',
                        color: state.postType == PostType.ARTICLE ? AppColors.primaryColor : AppColors.white07),
                  ),
                  labelPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 4),
                  backgroundColor: state.postType == PostType.ARTICLE ? AppColors.backgroundLight : null,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
