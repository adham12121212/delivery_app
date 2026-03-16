import 'package:delivery_app/feature/Auth/data/model/login_request_body.dart';
import 'package:delivery_app/feature/Auth/data/model/login_response.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import '../constant/api_constants.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

@POST(ApiConstants.loginEndpoint)
  Future<LoginResponse> login(
    @Body() LoginRequestBody loginRequestBody,
    );

}