import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:union_app/src/repository/authentication/auth.dart';
import 'package:union_app/src/screens/sign_up/cubit/sign_up_cubit.dart';
import 'package:union_app/src/screens/sign_up/view/sign_up_form.dart';

class IntroPage01 extends StatelessWidget {
  const IntroPage01({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const IntroPage01());
  }

  static Page page() => const MaterialPage<void>(child: IntroPage01());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(169, 223, 216, 1),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: _Intro01(),
      ),
    );
  }
}

class _Intro01 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Image(image: AssetImage('assets/intro_page/page_1.png')),

    ],);
  }

}