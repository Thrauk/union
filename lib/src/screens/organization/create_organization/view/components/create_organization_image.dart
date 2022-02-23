import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../barrel.dart';
import '../barrel.dart';

class CreateOrganizationImage extends StatelessWidget {
  const CreateOrganizationImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateOrganizationBloc, CreateOrganizationState>(
      builder: (BuildContext context, CreateOrganizationState state) {
        return GestureDetector(
          onTap: () {
            context.read<CreateOrganizationBloc>().add(SelectImage());
          },
          child: SelectImageWidget(
            image: state.selectedImage,
          ),
        );
      },
    );
  }
}
