import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:union_app/src/screens/profile/profile.dart';

class InteractionMenuWidget extends StatelessWidget {
  const InteractionMenuWidget({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(builder: (BuildContext context, ProfileState state) {
      return Container(
        height: 50,
        color: Colors.red,
      );
    });
  }

}