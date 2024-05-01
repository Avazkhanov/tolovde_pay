part of 'auth_bloc.dart';

 abstract class AuthEvent extends Equatable {}

class RegisterEvent extends AuthEvent{

  final UserModel userModel;
  final String confirmPassword;
  RegisterEvent(this.userModel, this.confirmPassword);

  @override
  List<Object?> get props => [
    userModel.hashCode,
    confirmPassword.hashCode
  ];
}

class LoginWithGoogle extends AuthEvent{
  @override
  List<Object?> get props => throw UnimplementedError();
}

class LoginEvent extends AuthEvent{

  final String email;
  final String password;
  LoginEvent(this.email, this.password);

  @override
  List<Object?> get props => [
    email.hashCode,
    password.hashCode
  ];


}
class LogOutEvent extends AuthEvent{

  LogOutEvent();

  @override
  List<Object?> get props => [];


}