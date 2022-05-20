import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:union_app/src/repository/authentication/auth.dart';
import 'package:union_app/src/screens/widgets/github/github_link_widget/bloc/github_link_widget_bloc.dart';
import 'package:union_app/src/theme.dart';

class GithubLinkWidget extends StatelessWidget {
  const GithubLinkWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<GithubLinkWidgetBloc>(
      create: (BuildContext context) => GithubLinkWidgetBloc(context.read<AuthenticationRepository>())..add(Initialize()),
      child: _GithubLinkWidget(),
    );
  }


}

class _GithubLinkWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GithubLinkWidgetBloc, GithubLinkWidgetState>(
      listener: (BuildContext context, GithubLinkWidgetState state) {
        if(state.linkSuccess == true) {
        }
      },
      builder: (BuildContext context, GithubLinkWidgetState state) {
        return ElevatedButton(
          onPressed: () {
            context.read<GithubLinkWidgetBloc>().add(LinkPressed());
          },
          style: ElevatedButton.styleFrom(
            primary: AppColors.backgroundLight,
            minimumSize: const Size(double.infinity, 48),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const <Widget>[
              Image(
                image: AssetImage('assets/icons/github_icon.png'),
              ),
              SizedBox(width: 8),
              Text(
                'Link GitHub Account',
                style: TextStyle(
                  color: AppColors.white07,
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

}