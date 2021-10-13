import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:union_app/src/screens/intro/cubit/intro_cubit.dart';

class ButtonsWidget01 extends StatelessWidget {
  const ButtonsWidget01({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(
          flex: 1,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
                primary: Colors.transparent,
                onSurface: Colors.transparent,
                shadowColor: Colors.transparent,
                side: const BorderSide(
                    width: 2.0, color: Color.fromRGBO(169, 223, 216, 1)),
                minimumSize: const Size(double.infinity, double.infinity)),
            child: const Text(
              'Skip',
              style: TextStyle(
                color: Color.fromRGBO(169, 223, 216, 1),
                fontFamily: 'Lato',
                fontWeight: FontWeight.w700,
                fontSize: 20,
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          flex: 1,
          child: ElevatedButton(
            onPressed: () {
              context.read<IntroCubit>().nextPage();
            },
            style: ElevatedButton.styleFrom(
                primary: const Color.fromRGBO(169, 223, 216, 1),
                onSurface: Colors.transparent,
                shadowColor: Colors.transparent,
                side: const BorderSide(
                    width: 2.0, color: Color.fromRGBO(169, 223, 216, 1)),
                minimumSize: const Size(double.infinity, double.infinity)),
            child: const Text(
              'Next',
              style: TextStyle(
                color: Color.fromRGBO(18, 18, 18, 1),
                fontFamily: 'Lato',
                fontWeight: FontWeight.w700,
                fontSize: 20,
              ),
            ),
          ),
        ),
      ],
    );
  }
}