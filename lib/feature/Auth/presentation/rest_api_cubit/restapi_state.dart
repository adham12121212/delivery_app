import 'package:freezed_annotation/freezed_annotation.dart';

import 'restapi_state.dart';

part 'restapi_state.freezed.dart';

@freezed
class RestapiState<T> with _$RestapiState<T>{
 const factory RestapiState.initial() = _Initial;


 const factory RestapiState.loading() = Loading;
 const factory RestapiState.success(T data) = Success<T>;
 const factory RestapiState.error({required String error}) = Error;
}


