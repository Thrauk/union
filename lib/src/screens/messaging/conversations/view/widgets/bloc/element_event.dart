part of 'element_bloc.dart';

@immutable
abstract class ElementEvent extends Equatable{
  @override
  List<Object?> get props => <Object?>[];

}

class Initialize extends ElementEvent {}
