import 'package:firebase_auth/firebase_auth.dart';

import '../erorr/api_exception.dart';
import '../erorr/firebase_auth_error_mapper.dart';

class FireBaseService {
  Future<User> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user!;
  }

  Future<User> signUpWithEmailAndPassword({
    required String email,required String password
})async{
    final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password
    );
    return credential.user!;
  }




}
