import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_app/src/screens/intro/cubit/intro_cubit.dart';

void main() {
  late IntroCubit introCubit;

  setUp(() {
    introCubit = IntroCubit(maxPageNumber: 3);
  });

  blocTest<IntroCubit, IntroState>('Call next page one time from initial state',
      build: () => introCubit,
      act: (IntroCubit cubit) => cubit.nextPage(),
      expect: () =>
          <IntroState>[const IntroState(maxPageNumber: 3, currentPage: 1)]);

  blocTest<IntroCubit, IntroState>('Call previous page one time from initial state',
      build: () => introCubit,
      act: (IntroCubit cubit) {cubit.previousPage();
      },
      expect: () => <void>[]);

  blocTest<IntroCubit, IntroState>('call nextPage more times',
      build: () => introCubit,
      act: (IntroCubit cubit) {
        cubit.nextPage();
        cubit.nextPage();
        cubit.nextPage();
      },
      expect: () => <IntroState>[
            const IntroState(maxPageNumber: 3, currentPage: 1),
            const IntroState(maxPageNumber: 3, currentPage: 2),
          ]);
}
