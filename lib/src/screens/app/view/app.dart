// ignore_for_file: always_specify_types

import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:union_app/src/repository/authentication/auth.dart';
import 'package:union_app/src/screens/app/app.dart';
import 'package:union_app/src/screens/app/bloc/app_bloc.dart';
import 'package:union_app/src/screens/auth/login/login.dart';
import 'package:union_app/src/screens/home/home.dart';
import 'package:union_app/src/theme.dart';

class App extends StatelessWidget {
  const App({
    Key? key,
    required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(key: key);

  final AuthenticationRepository _authenticationRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _authenticationRepository,
      child: BlocProvider(
        create: (_) => AppBloc(
          authenticationRepository: _authenticationRepository,
        ),
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,

      home: FlowBuilder<AppStatus>(
        state: context.select((AppBloc bloc) => bloc.state.status),
        onGeneratePages: onGenerateAppViewPages,
      ),

      // home:
      // BlocBuilder<AppBloc, AppState>(
      //     buildWhen: (AppState previous, AppState current) => previous.status != current.status,
      //     builder: (BuildContext context, AppState state) {
      //       switch(state.status) {
      //         case AppStatus.authenticated:
      //           return const HomePage();
      //         case AppStatus.unauthenticated:
      //           return const LoginPage();
      //       }
      //     }
      // ),
    );
  }
}
