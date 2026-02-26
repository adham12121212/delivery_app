// ignore_for_file: constant_identifier_names

import 'dart:io';

import 'package:dio/dio.dart';

import '../constant/api_constants.dart';
import 'api_error_model.dart';

/// TODO: wallahy I will refactor this .. Omar Ahmed
enum DataSource {
  NO_CONTENT,
  BAD_REQUEST,
  FORBIDDEN,
  UNAUTORISED,
  NOT_FOUND,
  INTERNAL_SERVER_ERROR,
  CONNECT_TIMEOUT,
  CANCEL,
  RECEIVE_TIMEOUT,
  SEND_TIMEOUT,
  CACHE_ERROR,
  NO_INTERNET_CONNECTION,
  DEFAULT,
}

class ResponseCode {
  static const int SUCCESS = 200; // success with data
  static const int NO_CONTENT = 204; // success with no data
  static const int BAD_REQUEST = 400; // failure, API rejected request
  static const int UNAUTORISED = 401; // failure, user is not authorised
  static const int FORBIDDEN = 403; // failure, API rejected request
  static const int NOT_FOUND = 404; // failure, not found
  static const int INTERNAL_SERVER_ERROR = 500; // failure, crash in server side
  static const int API_LOGIC_ERROR = 422; // API logic error (validation, etc)

  // local status code
  static const int CONNECT_TIMEOUT = -1;
  static const int CANCEL = -2;
  static const int RECEIVE_TIMEOUT = -3;
  static const int SEND_TIMEOUT = -4;
  static const int CACHE_ERROR = -5;
  static const int NO_INTERNET_CONNECTION = -6;
  static const int DEFAULT = -7;
}

class ResponseMessage {
  static const String NO_CONTENT = ApiErrors.noContent;
  static const String BAD_REQUEST = ApiErrors.badRequestError;
  static const String UNAUTORISED = ApiErrors.unauthorizedError;
  static const String FORBIDDEN = ApiErrors.forbiddenError;
  static const String INTERNAL_SERVER_ERROR = ApiErrors.internalServerError;
  static const String NOT_FOUND = ApiErrors.notFoundError;

  // local messages
  static const String CONNECT_TIMEOUT = ApiErrors.timeoutError;
  static const String CANCEL = ApiErrors.defaultError;
  static const String RECEIVE_TIMEOUT = ApiErrors.timeoutError;
  static const String SEND_TIMEOUT = ApiErrors.timeoutError;
  static const String CACHE_ERROR = ApiErrors.cacheError;
  static const String NO_INTERNET_CONNECTION = ApiErrors.noInternetError;
  static const String DEFAULT = ApiErrors.defaultError;
}

extension DataSourceExtension on DataSource {
  ApiErrorModel getFailure() {
    switch (this) {
      case DataSource.NO_CONTENT:
        return ApiErrorModel(
          code: ResponseCode.NO_CONTENT,
          message: ResponseMessage.NO_CONTENT,
        );

      case DataSource.BAD_REQUEST:
        return ApiErrorModel(
          code: ResponseCode.BAD_REQUEST,
          message: ResponseMessage.BAD_REQUEST,
        );

      case DataSource.FORBIDDEN:
        return ApiErrorModel(
          code: ResponseCode.FORBIDDEN,
          message: ResponseMessage.FORBIDDEN,
        );

      case DataSource.UNAUTORISED:
        return ApiErrorModel(
          code: ResponseCode.UNAUTORISED,
          message: ResponseMessage.UNAUTORISED,
        );

      case DataSource.NOT_FOUND:
        return ApiErrorModel(
          code: ResponseCode.NOT_FOUND,
          message: ResponseMessage.NOT_FOUND,
        );

      case DataSource.INTERNAL_SERVER_ERROR:
        return ApiErrorModel(
          code: ResponseCode.INTERNAL_SERVER_ERROR,
          message: ResponseMessage.INTERNAL_SERVER_ERROR,
        );

      case DataSource.CONNECT_TIMEOUT:
        return ApiErrorModel(
          code: ResponseCode.CONNECT_TIMEOUT,
          message: ResponseMessage.CONNECT_TIMEOUT,
        );

      case DataSource.CANCEL:
        return ApiErrorModel(
          code: ResponseCode.CANCEL,
          message: ResponseMessage.CANCEL,
        );

      case DataSource.RECEIVE_TIMEOUT:
        return ApiErrorModel(
          code: ResponseCode.RECEIVE_TIMEOUT,
          message: ResponseMessage.RECEIVE_TIMEOUT,
        );

      case DataSource.SEND_TIMEOUT:
        return ApiErrorModel(
          code: ResponseCode.SEND_TIMEOUT,
          message: ResponseMessage.SEND_TIMEOUT,
        );

      case DataSource.CACHE_ERROR:
        return ApiErrorModel(
          code: ResponseCode.CACHE_ERROR,
          message: ResponseMessage.CACHE_ERROR,
        );

      case DataSource.NO_INTERNET_CONNECTION:
        return ApiErrorModel(
          code: ResponseCode.NO_INTERNET_CONNECTION,
          message: ResponseMessage.NO_INTERNET_CONNECTION,
        );

      case DataSource.DEFAULT:
        return ApiErrorModel(
          code: ResponseCode.DEFAULT,
          message: ResponseMessage.DEFAULT,
        );
    }
  }
}

class ErrorHandler implements Exception {
  late final ApiErrorModel apiErrorModel;

  ErrorHandler.handle(dynamic error) {
    if (error is DioException) {
      apiErrorModel = _handleError(error);
    } else {
      apiErrorModel = DataSource.DEFAULT.getFailure();
    }
  }
}

ApiErrorModel _handleError(DioException error) {
  switch (error.type) {
    case DioExceptionType.connectionTimeout:
      return DataSource.CONNECT_TIMEOUT.getFailure();

    case DioExceptionType.sendTimeout:
      return DataSource.SEND_TIMEOUT.getFailure();

    case DioExceptionType.receiveTimeout:
      return DataSource.RECEIVE_TIMEOUT.getFailure();

    case DioExceptionType.cancel:
      return DataSource.CANCEL.getFailure();

    case DioExceptionType.connectionError:
    // Usually no internet / DNS / refused
      return DataSource.NO_INTERNET_CONNECTION.getFailure();

    case DioExceptionType.badCertificate:
      return DataSource.DEFAULT.getFailure();

    case DioExceptionType.badResponse:
      return _handleBadResponse(error);

    case DioExceptionType.unknown:
    // Sometimes unknown wraps SocketException (no internet)
      final e = error.error;
      if (e is SocketException) {
        return DataSource.NO_INTERNET_CONNECTION.getFailure();
      }
      // If there is a response, handle it like badResponse
      if (error.response != null) {
        return _handleBadResponse(error);
      }
      return DataSource.DEFAULT.getFailure();
  }
}

ApiErrorModel _handleBadResponse(DioException error) {
  final statusCode = error.response?.statusCode;
  final data = error.response?.data;

  // 1) Try parse your backend error body if it's JSON map
  if (data is Map<String, dynamic>) {
    try {
      return ApiErrorModel.fromJson(data);
    } catch (_) {
      // fallback below
    }
  }

  // 2) Fallback by status code
  switch (statusCode) {
    case 204:
      return DataSource.NO_CONTENT.getFailure();

    case 400:
      return DataSource.BAD_REQUEST.getFailure();

    case 401:
      return DataSource.UNAUTORISED.getFailure();

    case 403:
      return DataSource.FORBIDDEN.getFailure();

    case 404:
      return DataSource.NOT_FOUND.getFailure();

    case 422:
    // If your API returns validation errors but parsing failed
    // you can keep DEFAULT or map to BAD_REQUEST depending on your app behavior
      return ApiErrorModel(
        code: ResponseCode.API_LOGIC_ERROR,
        message: ApiErrors.defaultError,
      );

    case 500:
      return DataSource.INTERNAL_SERVER_ERROR.getFailure();

    default:
      return DataSource.DEFAULT.getFailure();
  }
}

class ApiInternalStatus {
  static const int SUCCESS = 0;
  static const int FAILURE = 1;
}
