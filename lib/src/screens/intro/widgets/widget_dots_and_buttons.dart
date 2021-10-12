import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:union_app/src/screens/intro/intro.dart';

class DotsAndButtonsWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IntroCubit, IntroState>(
      buildWhen: (previous, current) => previous.currentPage != current.currentPage,
      builder: (context, state) {
        return Column(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                alignment: Alignment.center,
                child: DotsIndicator(
                  dotsCount: state.maxPageNumber,
                  position: state.currentPage.toDouble(),
                  decorator: DotsDecorator(
                    spacing: EdgeInsets.all(15),
                    activeColor: Color.fromRGBO(196, 196, 196, 1),
                    color: Color.fromRGBO(196, 196, 196, 0.5),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 20),
                  child: ButtonsWidget(currentPage: state.currentPage,)
                ),
              ),
            ),
          ],
        );
      },
    );
  }

}