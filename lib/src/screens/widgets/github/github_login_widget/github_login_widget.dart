import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:union_app/src/repository/authentication/auth.dart';
import 'package:union_app/src/screens/widgets/github/github_login_widget/bloc/github_login_widget_bloc.dart';

class GithubLoginWidget extends StatelessWidget {
  const GithubLoginWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<GithubLoginWidgetBloc>(
      create: (BuildContext context) => GithubLoginWidgetBloc(context.read<AuthenticationRepository>())..add(Initialize()),
      child: _GithubLoginWidget(),
    );
  }


}

class _GithubLoginWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GithubLoginWidgetBloc, GithubLoginWidgetState>(
      listener: (BuildContext context, GithubLoginWidgetState state) {
        if(state.loginSuccess == true) {
          Navigator.of(context).popUntil((Route<void> route) => false);
        }
      },
      builder: (BuildContext context, GithubLoginWidgetState state) {
        return GestureDetector(
          onTap: () {
            context.read<GithubLoginWidgetBloc>().add(LoginPressed());
          },
          child: const Image(
            image: AssetImage('assets/icons/github_icon.png'),
            fit: BoxFit.fill,
          ),
        );
      },
    );
  }

}