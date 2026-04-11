import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../domain/auth_repo/reset_repo.dart';
import 'reset_state.dart';

class ResetCubit extends Cubit<ResetState> {
  final ResetRepo repo;
  ResetCubit(this.repo) : super(ResetInitial());


  Future<void> sendResetLink(String email) async {
    emit(ResetLoading());
    try {
      await repo.sendResetLink(email);
      emit(ResetLinkSent());
    } on FirebaseAuthException catch (e) {
      emit(ResetError('${e.code}: ${e.message}'));
    } catch (e) {
      emit(ResetError(e.toString()));
    }
  }

  Future<void> changePassword(String newPassword) async {
    emit(ResetLoading());
    try {
      await repo.changePassword(newPassword);
      emit(PasswordChanged());
    } catch (e) {
      emit(ResetError(e.toString()));
    }
  }


}
