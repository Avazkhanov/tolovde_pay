part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {}

class AuthInitial extends AuthState {

  @override
  List<Object> get props => [];
}
class AuthLoadState extends AuthState {
  final bool isLoad;

   AuthLoadState({ this.isLoad = false});
  @override
  List<Object> get props => [
    isLoad.hashCode,
  ];
}


class AuthSuccessState extends AuthState{

  final UserCredential? userCredential;

  AuthSuccessState(this.userCredential);

  @override
  List<Object?> get props => [
    userCredential.hashCode
  ];

}

class AuthErrorState extends AuthState {
  final String errorText;
  AuthErrorState(this.errorText);

  @override
  List<Object> get props => [
    errorText.hashCode,
  ];
}
