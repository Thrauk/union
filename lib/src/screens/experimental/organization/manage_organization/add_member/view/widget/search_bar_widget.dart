import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:union_app/src/screens/experimental/organization/manage_organization/add_member/bloc/add_member_organization_bloc.dart';

import '../../../../../../../theme.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          GestureDetector(
              onTap: () {
                final FocusScopeNode currentFocus = FocusScope.of(context);
                if (!currentFocus.hasPrimaryFocus) {
                  currentFocus.unfocus();
                }
                context.read<AddMemberOrganizationBloc>().add(SearchPressed());
              },
              child: const Icon(Icons.search, color: Colors.white)),
          const SizedBox(width: 6),
          Expanded(
            child: TextField(
              onChanged: (String value) => context.read<AddMemberOrganizationBloc>().add(SearchValueChanged(value: value)),
              style: AppStyles.textStyleBody,
              cursorColor: AppColors.white07,
              decoration: const InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                hintText: 'Search something...',
              ),
            ),
          ),
        ],
      ),
    );
  }
}