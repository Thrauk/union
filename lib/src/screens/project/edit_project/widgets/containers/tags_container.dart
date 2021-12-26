import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:union_app/src/models/form_inputs/tag_name.dart';
import 'package:union_app/src/screens/project/edit_project/bloc/edit_project_bloc.dart';
import 'package:union_app/src/theme.dart';

class TagsContainer extends StatelessWidget {
  const TagsContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String _currentTag = '';
    String? _errorText;
    final TextEditingController _controller = TextEditingController();

    return BlocBuilder<EditProjectBloc, EditProjectState>(
      buildWhen: (EditProjectState previous, EditProjectState current) =>
          (previous.project.tags!.length != current.project.tags!.length) ||
          (previous.tag != current.tag),
      builder: (BuildContext context, EditProjectState state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextField(
              controller: _controller,
              style: const TextStyle(
                color: AppColors.white07,
              ),
              onChanged: (String val) => {
                context.read<EditProjectBloc>().add(
                      TagChanged(_currentTag),
                    ),
                _currentTag = val,
                _errorText = state.project.tags!.contains(_currentTag)
                    ? 'Tag already added'
                    : (TagName.dirty(_currentTag).invalid
                        ? 'Invalid tag'
                        : null),
              },
              cursorColor: AppColors.primaryColor,
              decoration: InputDecoration(
                labelText: 'Tag',
                errorText: _errorText,
                suffixIcon: GestureDetector(
                  onTap: () {
                    _controller.clear();
                    _errorText = null;
                    context
                        .read<EditProjectBloc>()
                        .add(AddTagButtonPressed(_currentTag));
                    _errorText = null;
                  },
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
              children: state.project.tags!
                  .map((e) => TagItemWidget(label: e as String))
                  .toList()
                  .cast<Widget>(),
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
      labelPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 4),
      onDeleted: () =>
          context.read<EditProjectBloc>().add(RemoveTagButtonPressed(label)),
      backgroundColor: AppColors.primaryColor,
    );
  }
}
