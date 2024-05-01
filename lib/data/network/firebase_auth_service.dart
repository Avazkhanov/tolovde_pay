import 'package:firebase_auth/firebase_auth.dart';
import 'package:tolovde_pay/data/network/response.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<NetworkResponse> signUpWithEmailPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return NetworkResponse(data: userCredential);
    } catch (e) {
      return NetworkResponse(errorText: "$e");
    }
  }


  Future<NetworkResponse> signInWithEmailPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return NetworkResponse(data: userCredential);
    } catch (e) {
      return NetworkResponse(errorText: "$e");
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
