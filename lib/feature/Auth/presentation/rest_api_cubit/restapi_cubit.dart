import 'package:bloc/bloc.dart';
import 'package:delivery_app/core/networking/api_result.dart';
import 'package:delivery_app/feature/Auth/data/auth_repo_impl/login_repo.dart';
import 'package:delivery_app/feature/Auth/data/model/login_request_body.dart';
import 'package:delivery_app/feature/Auth/presentation/rest_api_cubit/restapi_state.dart';
import 'package:meta/meta.dart';


class RestapiCubit extends Cubit<RestapiState> {
  final LoginRepo _loginRepo;
  RestapiCubit(this._loginRepo) : super(RestapiState.initial());

  Future<void> login(LoginRequestBody loginRequestBody)async{
    emit(RestapiState.loading());
    final response = await _loginRepo.login(loginRequestBody);
    response.when(
      success: (success) => emit(RestapiState.success(success)),
      error: (error) => emit(RestapiState.error(error: error.apiErrorModel.message!)),
    );
  }

}
