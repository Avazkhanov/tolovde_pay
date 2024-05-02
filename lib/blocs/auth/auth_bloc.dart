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
    on<RegisterEvent>((event, emit) async {

      if(event.userModel.name.isEmpty){
        emit(AuthErrorState("Siz isimni kiritmadingiz"));
        return;
      }
      else if(event.userModel.email.isEmpty){
        emit(AuthErrorState("Siz emailni kiritmadingiz"));
        return;
      }
      else if(event.confirmPassword == ''){
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
        }
        else {
          emit(AuthErrorState("Sizning parolingiz mos kelmadi"));
          return;
        }

      } catch (e) {
        emit(AuthErrorState('$e'));
      }
    });
// hi diear
    on<LoginEvent>((event, emit) async {
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
    });

    on<LogOutEvent>((event, emit) async {
        emit(AuthLoadState(isLoad: true));
        NetworkResponse networkResponse = await AuthRepository().logOut();
          emit(AuthSuccessState(networkResponse.data));
    });

// hello world
   on<LoginWithGoogle>((event,emit) async{
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
      });
  }

}







// Future<void> signInWithGoogle(BuildContext context,
//     [String? clientId]) async {
//   // Trigger the authentication flow
//   _notify(true);
//
//   final GoogleSignInAccount? googleUser =
//   await GoogleSignIn(clientId: clientId).signIn();
//
//   // Obtain the auth details from the request
//   final GoogleSignInAuthentication? googleAuth =
//   await googleUser?.authentication;
//
//   // Create a new credential
//   final credential = GoogleAuthProvider.credential(
//     accessToken: googleAuth?.accessToken,
//     idToken: googleAuth?.idToken,
//   );
//
//   // Once signed in, return the UserCredential
//   UserCredential userCredential =
//   await FirebaseAuth.instance.signInWithCredential(credential);
//   _notify(false);
//   if (userCredential.user != null) {
//     Navigator.pushReplacementNamed(context, RouteNames.tabRoute);
//   }
// }
