abstract class ResetRepo {
  Future<void> sendOTP(String email);
  Future<bool> verifyOTP(String email, String otp);
  Future<void> sendResetLink(String email);
  Future<void> changePassword(String newPassword);

}
