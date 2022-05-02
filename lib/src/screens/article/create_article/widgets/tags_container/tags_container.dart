import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:union_app/src/models/form_inputs/tag_name.dart';
import 'package:union_app/src/screens/article/create_article/bloc/bloc.dart';
import 'package:union_app/src/screens/widgets/chips/chip_with_text_and_delete_button.dart';
import 'package:union_app/src/theme.dart';

class TagsContainer extends StatelessWidget {
  const TagsContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String _currentTag = '';
    String? _errorText;
    final TextEditingController _controller = TextEditingController();

    return BlocBuilder<CreateArticleBloc, CreateArticleState>(
      buildWhen: (CreateArticleState previous, CreateArticleState current) =>
          (previous.tagItems.length != current.tagItems.length) || (previous.tag != current.tag),
      builder: (BuildContext context, CreateArticleState state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextField(
              controller: _controller,
              style: const TextStyle(
                color: AppColors.white07,
              ),
              onChanged: (String val) => {
                _currentTag = val,
                _errorText = state.tagItems.contains(TagName.dirty(_currentTag))
                    ? 'Tag already added'
                    : (TagName.dirty(_currentTag).invalid ? 'Invalid tag' : null),
                // context.read<CreateProjectBloc>().add(TagChanged(val)),
              },
              cursorColor: AppColors.primaryColor,
              decoration: InputDecoration(
                labelText: 'Tag',
                errorText: _errorText,
                suffixIcon: GestureDetector(
                  onTap: () {
                    _controller.clear();
                    _errorText = null;
                    context.read<CreateArticleBloc>().add(AddTagButtonPressed(_currentTag));
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
              children: state.tagItems
                  .map(
                    (TagName tag) => ChipWithTextAndDeleteButton(
                      label: tag.value,
                      onDeleted: () {
                        context.read<CreateArticleBloc>().add(RemoveTagButtonPressed(tag.value));
                      },
                    ),
                  )
                  .toList()
                  .cast<Widget>(),
            ),
          ],
        );
      },
    );
  }
}
