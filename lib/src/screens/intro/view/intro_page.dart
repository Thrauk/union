
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:union_app/src/screens/intro/intro.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({Key? key}) : super(key: key);

  static const List<String> descriptionList = <String>[
    'Find a team and start working\ntogether',
    'Write or discover thousands of\narticles',
    'Find tech events happening\nnear you'
  ];
  static const int maxPageNumber = 3;

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const IntroPage());
  }

  static Page<void> page() => const MaterialPage<void>(child: IntroPage());

  @override
  Widget build(BuildContext context) {
    return BlocProvider<IntroCubit>(
      create: (_) => IntroCubit(maxPageNumber: maxPageNumber),
      child: _Intro(),
    );
  }
}

class _Intro extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(169, 223, 216, 1),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: GestureDetector(
              onHorizontalDragEnd: (DragEndDetails details) {
                // swipe right to left, next page
                if (details.primaryVelocity! < 0) {
                  context.read<IntroCubit>().nextPage();
                }
                // swipe left to right, previous page
                else if (details.primaryVelocity! > 0) {
                  context.read<IntroCubit>().previousPage();
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Container(
                        alignment: Alignment.bottomCenter,
                        child: const Text(
                          'Union',
                          style: TextStyle(
                              fontFamily: 'LatoBlack',
                              fontWeight: FontWeight.w900,
                              fontSize: 26),
                        ),
                      ),
                    ),
                    const Expanded(
                      flex: 5,
                      child: ImageAndTextWidget(),
                    )
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              color: const Color.fromRGBO(18, 18, 18, 1),
              width: double.infinity,
              child: const DotsAndButtonsWidget(),
            ),
          ),
        ],
      ),
    );
  }
}
