import '../../../../core/service/firebase_service.dart';
import '../../domain/auth_repo/reset_repo.dart';

class ResetRepoImpl implements ResetRepo {
  final FireBaseService service;

  ResetRepoImpl(this.service);

  @override
  Future<void> sendOTP(String email) => service.sendOTP(email);

  @override
  Future<bool> verifyOTP(String email, String otp) =>
      service.verifyOTP(email, otp);

  @override
  Future<void> sendResetLink(String email) =>
      service.sendResetLink(email);

  @override
  Future<void> changePassword(String newPassword) => service.changePassword(newPassword);

}
