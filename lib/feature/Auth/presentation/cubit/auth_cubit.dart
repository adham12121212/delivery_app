import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../../../core/erorr/api_exception.dart';
import '../../../../core/storage/auth_local_data.dart';
import '../../data/model/user_model.dart';
import '../../domain/auth_repo/auth_repo.dart';
import '../../domain/entity/user_entity.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.authRepo) : super(AuthInitial());

  final AuthRepo authRepo;

  /// Login with email/password
  Future<void> login(String email, String password) async {
    emit(AuthLoading());
    try {
      final data = await authRepo.signInWithEmailAndPassword(email: email, password: password);
      await AuthLocalData.saveLoginState(true);
      await AuthLocalData.saveUid(data.id);
      emit(AuthSuccess(user: data));
    } on ApiException catch (e) {
      emit(AuthError(message: e.message));
    } catch (_) {
      emit(AuthError(message: 'حدث خطأ غير متوقع'));
    }
  }

  /// Sign up
  Future<void> signUp(String email, String password, String name) async {
    emit(AuthLoading());
    try {
      final data = await authRepo.signUpWithEmailAndPassword(email: email, password: password, name: name);
      await AuthLocalData.saveLoginState(true);
      await AuthLocalData.saveUid(data.id);
      emit(AuthSuccess(user: data));
    } on ApiException catch (e) {
      emit(AuthError(message: e.message));
    } catch (_) {
      emit(AuthError(message: 'حدث خطأ غير متوقع'));
    }
  }

  /// Google login
  Future<void> google() async {
    emit(AuthLoading());
    try {
      final data = await authRepo.signInWithGoogle();
      await AuthLocalData.saveLoginState(true);
      await AuthLocalData.saveUid(data.id);
      emit(AuthSuccess(user: data));
    } on ApiException catch (e) {
      emit(AuthError(message: e.message));
    } catch (_) {
      emit(AuthError(message: 'حدث خطأ غير متوقع'));
    }
  }

  /// Facebook login
  Future<void> facebook() async {
    emit(AuthLoading());
    try {
      final data = await authRepo.signInWithFacebook();
      await AuthLocalData.saveLoginState(true);
      await AuthLocalData.saveUid(data.id);
      emit(AuthSuccess(user: data));
    } on ApiException catch (e) {
      emit(AuthError(message: e.message));
    } catch (_) {
      emit(AuthError(message: 'حدث خطأ غير متوقع'));
    }
  }

  /// Get current user
  Future<void> getUser() async {
    emit(AuthLoading());
    try {
      final data = await authRepo.getCurrentUser();
      emit(AuthSuccess(user: data));
    } on ApiException catch (e) {
      emit(AuthError(message: e.message));
    } catch (_) {
      emit(AuthError(message: 'حدث خطأ غير متوقع'));
    }
  }

  /// Sign out
  Future<void> signOut() async {
    emit(AuthLoading());
    try {
      await authRepo.signOut();
      await AuthLocalData.clearLogin();
      emit(AuthLoggedOut());
    } on ApiException catch (e) {
      emit(AuthError(message: e.message));
    } catch (_) {
      emit(AuthError(message: 'حدث خطأ غير متوقع'));
    }
  }
}