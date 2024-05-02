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

class LoginWithGoogle extends AuthEvent{


   @override
  List<Object?> get props => [];
}

class LogOutEvent extends AuthEvent{

  @override
  List<Object?> get props => [];


}