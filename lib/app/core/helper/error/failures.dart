import 'package:dio/dio.dart';

abstract class Failures {
  final String errMessage;

  Failures(this.errMessage);
}

class ServerFailure extends Failures {
  ServerFailure(super.errMessage);
  factory ServerFailure.fromDioError(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure('Connection Timeout with apiServer');
      case DioExceptionType.sendTimeout:
        return ServerFailure('send Timeout with apiServer');
      case DioExceptionType.receiveTimeout:
        return ServerFailure('Receive Timeout with apiServer');
      case DioExceptionType.badCertificate:
        return ServerFailure('Opps there was an error');
      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(
            dioError.response!.statusCode!, dioError.response!.data);
      case DioExceptionType.cancel:
        return ServerFailure('Request to apiServer was cancled');

      case DioExceptionType.connectionError:
        return ServerFailure('Connection Error');
      case DioExceptionType.unknown:
        return ServerFailure('unexpected error, please try again later');
      default:
        return ServerFailure('Opps there was an error, please try again');
    }
  }
  factory ServerFailure.fromResponse(int statusCode, dynamic response) {
    if (statusCode == 400 || statusCode == 401 || statusCode == 403) {
      return ServerFailure(response['error']['message']);
    } else if (statusCode == 404) {
      return ServerFailure('Your Requset is not found, please try again later');
    } else if (statusCode == 500) {
      return ServerFailure('Internal Server error please try agai later');
    } else {
      return ServerFailure('Opps there was an error, please try again');
    }
  }
}
