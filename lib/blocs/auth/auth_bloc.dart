import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tolovde_pay/data/models/user_model.dart';
import 'package:tolovde_pay/data/network/response.dart';
import 'package:tolovde_pay/data/repositories/auth_repository.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<RegisterEvent>(_registerUser);

    on<LoginEvent>(_loginUser);

    on<LogOutEvent>(_logOut);

    on<LoginWithGoogle>(_loginWithGoogle);
  }

  _registerUser(RegisterEvent event, emit) async {
    if (event.userModel.name.isEmpty) {
      emit(AuthErrorState("Siz ismni kiritmadingiz"));
      return;
    } else if (event.userModel.email.isEmpty) {
      emit(AuthErrorState("Siz emailni kiritmadingiz"));
      return;
    } else if (event.confirmPassword == '') {
      emit(AuthErrorState("Parolni tasdiqlang"));
      return;
    }

    try {
      if (event.userModel.password == event.confirmPassword) {
        emit(AuthLoadState(isLoad: true));
        NetworkResponse networkResponse = await AuthRepository()
            .signUp(event.userModel.email, event.userModel.password);
        if (networkResponse.errorText == '') {
          emit(AuthSuccessState(networkResponse.data));
        } else {
          emit(AuthErrorState(networkResponse.errorText.toString()));
        }
      } else {
        emit(AuthErrorState("Parollar mos emas"));
        return;
      }
    } catch (e) {
      emit(AuthErrorState('$e'));
    }
  }

  _loginUser(LoginEvent event, emit) async {
    try {
      emit(AuthLoadState(isLoad: true));
      NetworkResponse networkResponse =
          await AuthRepository().signIn(event.email, event.password);
      if (networkResponse.errorText.isEmpty) {
        emit(AuthSuccessState(networkResponse.data));
      } else {
        emit(AuthErrorState(networkResponse.errorText.toString()));
      }
    } catch (e) {
      emit(AuthErrorState('$e'));
    }
  }

  _logOut(LogOutEvent event, emit) async {
    emit(AuthLoadState(isLoad: true));
    NetworkResponse networkResponse = await AuthRepository().logOut();
    emit(AuthSuccessState(networkResponse.data));
  }

  _loginWithGoogle(LoginWithGoogle event, emit) async {
    try {
      String? clientId;
      emit(AuthLoadState(isLoad: true));
      final GoogleSignInAccount? googleUser =
          await GoogleSignIn(clientId: clientId).signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      emit(AuthSuccessState(userCredential));
    } catch (e) {
      emit(AuthErrorState('$e'));
    }
  }
}
