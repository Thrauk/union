import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:union_app/src/theme.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget(
      {Key? key, Function()? onSearchPressed, Function(String)? onTextChanged, String hintText = 'Search something...'})
      : _onSearchPressed = onSearchPressed,
        _onTextChanged = onTextChanged,
        _hintText = hintText,
        super(key: key);

  final Function()? _onSearchPressed;
  final Function(String)? _onTextChanged;
  final String _hintText;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        GestureDetector(
            onTap: () {
              final FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus) {
                currentFocus.unfocus();
              }
              if (_onSearchPressed != null) _onSearchPressed!();
            },
            child: const Icon(Icons.search, color: Colors.white)),
        const SizedBox(width: 6),
        Expanded(
          child: TextField(
            onChanged: (String value) {
              if (_onTextChanged != null) _onTextChanged!(value);
            },
            style: AppStyles.textStyleBody,
            cursorColor: AppColors.white07,
            decoration: InputDecoration(
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              hintText: _hintText,
            ),
          ),
        ),
      ],
    );
  }
}
