part of 'element_bloc.dart';

@immutable
class ElementState extends Equatable {

  const ElementState({this.user = FullUser.empty});

  final FullUser user;

  ElementState copyWith({FullUser? user}) {
    return ElementState(user: user ?? this.user);
  }

  @override
  List<Object?> get props => <Object?>[user];

}
