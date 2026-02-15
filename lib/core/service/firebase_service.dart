import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
