import 'package:dio/dio.dart';

class CustomDioException implements Exception {
  String? message;

  CustomDioException.fromDioError(DioException dioException) {
    switch (dioException.type) {
      case DioExceptionType.connectionTimeout:
        message = "Connection timeout. Please try again.";
        break;
      case DioExceptionType.sendTimeout:
        message = "Request timeout. Please try again.";
        break;
      case DioExceptionType.receiveTimeout:
        message = "Server took too long to respond. Please try again.";
        break;
      case DioExceptionType.badResponse:
        message = _handleError(
          statusCode: dioException.response?.statusCode,
          error: dioException.response?.data,
        );
        break;
      case DioExceptionType.cancel:
        message = "Request was cancelled.";
        break;
      case DioExceptionType.connectionError:
        message = "Unable to connect to the server. Please check your connection.";
        break;
      case DioExceptionType.unknown:
      default:
        message = "An unexpected error occurred. Please try again.";
        break;
    }
  }

  String _handleError({int? statusCode, dynamic error}) {
    if (statusCode == null) return "An unexpected error occurred.";
    switch (statusCode) {
      case 400:
        return error?["message"] ?? "Bad request. Please try again.";
      case 401:
        return "You’ve been logged out. Please sign in again.";
      case 403:
        return error?["message"] ?? "Forbidden. You don't have access.";
      case 404:
        return error?["message"] ?? "Resource not found.";
      case 409:
        return error?["message"] ?? "Conflict occurred. Please try again.";
      case 422:
        return error?["message"] ??
            (error?["details"]?.toString() ?? "Validation error occurred.");
      case 500:
        return "Internal server error. Please try again later.";
      default:
        return "Unexpected error occurred (Status Code: $statusCode).";
    }
  }

  @override
  String toString() {
    return message ?? "Unknown Dio error";
  }
}
