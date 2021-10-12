import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:union_app/src/screens/intro/intro.dart';

class ImageAndTextWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IntroCubit, IntroState>(
      buildWhen: (previous, current) =>
          previous.currentPage != current.currentPage,
      builder: (context, state) {
        return Column(
          children: <Widget>[
            Expanded(
              flex: 4,
              child: _IntroImage(
                currentPage: state.currentPage,
              ),
            ),
            Expanded(
              flex: 1,
              child: _IntroDescriptionText(
                currentPage: state.currentPage,
              ),
            )
          ],
        );
      },
    );
  }
}

class _IntroImage extends StatelessWidget {
  const _IntroImage({required this.currentPage});

  final int currentPage;

  @override
  Widget build(BuildContext context) {
    return Image(
      image: AssetImage('assets/intro_page/page_$currentPage.png'),
    );
  }
}

class _IntroDescriptionText extends StatelessWidget {
  const _IntroDescriptionText({required this.currentPage});

  final int currentPage;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Container(
        alignment: Alignment.topLeft,
        child: Text(
          IntroPage.descriptionList[currentPage],
          style: TextStyle(
              fontFamily: 'LatoBold',
              fontWeight: FontWeight.w700,
              fontSize: 23),
        ),
      ),
    );
  }
}
