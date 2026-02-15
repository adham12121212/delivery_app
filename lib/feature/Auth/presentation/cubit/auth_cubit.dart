import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../core/erorr/api_exception.dart';
import '../../domain/auth_repo/auth_repo.dart';
import '../../domain/entity/user_entity.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.authRepo) : super(AuthInitial());

  final AuthRepo authRepo;

  Future<void> login(String email, String password) async {
    emit(AuthLoading());
    try {
      final data = await authRepo.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(AuthSuccess(user: data));
    } on ApiException catch (e) {
      emit(AuthError(message: e.message));
    } catch (e) {
      emit(AuthError(message: 'حدث خطأ غير متوقع'));
    }
  }

  Future<void> signUp(String email ,String password,String name)async{
    emit(AuthLoading());
    try{
      final data = await authRepo.signUpWithEmailAndPassword(
          email: email,
          password: password,
          name: name
      );
      emit(AuthSuccess(user: data));
    }on ApiException catch(e){
      emit(AuthError(message: e.message));
    }catch(e){
      emit(AuthError(message: 'حدث خطأ غير متوقع'));
    }
  }
}
