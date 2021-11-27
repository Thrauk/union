import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:union_app/src/models/form_inputs/tag_name.dart';
import 'package:union_app/src/screens/project/create_project/create_project.dart';
import 'package:union_app/src/theme.dart';

class TagsContainer extends StatelessWidget {
  const TagsContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _currentTag = '';

    return BlocBuilder<CreateProjectCubit, CreateProjectState>(
      buildWhen: (CreateProjectState previous, CreateProjectState current) =>
          previous.tagItems != current.tagItems,
      builder: (BuildContext context, CreateProjectState state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextField(
              style: const TextStyle(
                color: AppColors.white07,
              ),
              onChanged: (String val) => _currentTag = val,
              cursorColor: AppColors.primaryColor,
              decoration: InputDecoration(
                labelText: 'Tag',
                errorText:
                    // TODO add valid condition
                    state.tagItems.any((TagName element) => element.invalid)
                        ? 'Invalid tag name'
                        : null,
                suffixIcon: GestureDetector(
                  onTap: () => context
                      .read<CreateProjectCubit>()
                      .addTagPressed(_currentTag),
                  child: const Icon(
                    Icons.add,
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 4,
              children: state.tagItems
                  .map(
                    (TagName tag) => Chip(
                      label: Text(
                        tag.value,
                        style: const TextStyle(
                            color: AppColors.backgroundDark, fontWeight: FontWeight.w600),
                      ),
                      labelPadding: const EdgeInsets.symmetric(vertical: 1, horizontal: 4),
                      avatar: GestureDetector(
                        onTap: () => {
                          print("E aicea"),
                          context.read<CreateProjectCubit>().removeTagPressed(tag.value)},
                        child: const CircleAvatar(
                          backgroundColor: AppColors.backgroundLight,
                          child: Icon(
                            Icons.clear,
                            color: AppColors.white07,
                          ),
                        ),
                      ),
                      backgroundColor: AppColors.primaryColor,
                    ),
                  )
                  .toList(),
            ),
          ],
        );
      },
    );
  }
}

class TagItemWidget extends StatelessWidget {
  const TagItemWidget({Key? key, required this.label}) : super(key: key);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(
        label,
        style: const TextStyle(
            color: AppColors.backgroundDark, fontWeight: FontWeight.w600),
      ),
      labelPadding: const EdgeInsets.symmetric(vertical: 1, horizontal: 4),
      avatar: GestureDetector(
        onTap: () => {
          print("E aicea"),
          context.read<CreateProjectCubit>().removeTagPressed(label)},
        child: const CircleAvatar(
          backgroundColor: AppColors.backgroundLight,
          child: Icon(
            Icons.clear,
            color: AppColors.white07,
          ),
        ),
      ),
      backgroundColor: AppColors.primaryColor,
    );
  }
}
