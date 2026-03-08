import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FireBaseService {

  final firestore = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;


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

  Future<User> signInWithGoogle() async {

      final GoogleSignIn googleSignIn = GoogleSignIn.instance;
      // Initialize (required in v7)
      await googleSignIn.initialize();

      // Start authentication
      final GoogleSignInAccount googleUser =
      await googleSignIn.authenticate();

      final GoogleSignInAuthentication googleAuth =
          googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );
      return (await FirebaseAuth.instance
          .signInWithCredential(credential)).user!;

  }



  Future<User> signInWithFacebook() async {
    final LoginResult loginResult = await FacebookAuth.instance.login();

    if (loginResult.status != LoginStatus.success ||
        loginResult.accessToken == null) {
      throw FirebaseAuthException(
        code: 'facebook-login-failed',
        message: loginResult.message ?? 'Facebook login failed',
      );
    }

    final OAuthCredential credential =
    FacebookAuthProvider.credential(
      loginResult.accessToken!.tokenString,
    );

    final UserCredential userCredential =
    await FirebaseAuth.instance.signInWithCredential(credential);

    final user = userCredential.user;

    if (user == null) {
      throw FirebaseAuthException(
        code: 'user-null',
        message: 'User is null',
      );
    }

    return user;
  }



  String generateOTP() {
    final r = Random();
    return (1000 + r.nextInt(9000)).toString();
  }

  Future<void> sendOTP(String email) async {
    final otp = generateOTP();

    await firestore.collection('password_resets').doc(email).set({
      'otp': otp,
      'expiresAt': Timestamp.fromDate(
        DateTime.now().add(const Duration(minutes: 5)),
      ),
    });

    print("OTP => $otp"); // dev testing
  }

  Future<bool> verifyOTP(String email, String code) async {
    final doc =
    await firestore.collection('password_resets').doc(email).get();

    if (!doc.exists) return false;

    final data = doc.data()!;
    final expired = DateTime.now()
        .isAfter((data['expiresAt'] as Timestamp).toDate());

    return !expired && data['otp'] == code;
  }

  Future<void> sendResetLink(String email) async {
    await auth.sendPasswordResetEmail(email: email);
  }

  Future<void> changePassword(String newPassword) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw Exception('User not logged in');
    }
    await user.updatePassword(newPassword);
  }




}
