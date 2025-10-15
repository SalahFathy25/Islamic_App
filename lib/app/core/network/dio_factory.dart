// import 'dart:developer';
//
//
// import 'package:dio/dio.dart';
//
// import '../helper/error/failures.dart';
//
// class DioFactory {
//   DioFactory._();
//
//   static Dio? dio;
//
//   static Dio getDio() {
//     Duration timeOut = const Duration(seconds: 30);
//
//     if (dio == null) {
//       dio = Dio();
//       dio!
//         ..options.connectTimeout = timeOut
//         // ..options.baseUrl = EndPoint.baseUrl
//         ..options.receiveTimeout = timeOut
//         ..options.validateStatus = (status) => status! < 500;
//       addDioHeaders();
//       addDioInterceptor();
//       return dio!;
//     } else {
//       return dio!;
//     }
//   }
//
//   static void addDioHeaders() async {
//     dio?.options.headers = {
//       'Accept': 'application/json',
//       'Content-Type': 'application/json',
//       'Authorization': 'Bearer ${UserLocal.token}',
//     };
//   }
//
//   static void setTokenIntoHeaderAfterLogin(String token) {
//     dio?.options.headers = {
//       'Accept': 'application/json',
//       'Content-Type': 'application/json',
//       'Authorization': 'Bearer $token',
//     };
//   }
//
//   static void addDioInterceptor() {
//     dio?.interceptors.addAll([
//       //  PrettyDioLogger(
//       //   requestBody: true,
//       //   requestHeader: true,
//       //   responseHeader: true,
//       // ),
//       InterceptorsWrapper(
//         onRequest: (options, handler) {
//           log('➡️ REQUEST [${options.method}] => PATH: ${options.path}');
//           log('Headers: ${options.headers}');
//           log('Data: ${options.data}');
//           if (options.data.runtimeType == FormData) {
//             final formData = options.data as FormData;
//             log('Data: ${formData.fields}');
//           }
//           log('Query: ${options.queryParameters}');
//           return handler.next(options);
//         },
//         onResponse: (response, handler) {
//           log(
//             '✅ RESPONSE [${response.statusCode}] => PATH: ${response.requestOptions.path}',
//           );
//           log('Response Data: ${response.data}');
//           if (response.statusCode == 401) {
//             CacheHelper.removeData(key: MyCashKey.token);
//             CustomNavigator.instance.pushNamedAndRemoveUntil(
//               LoginScreen.routeName,
//                   (route) => false,
//             );
//           }
//           return handler.next(response);
//         },
//         onError: (DioException error, handler) {
//           log(
//             '❌ ERROR [${error.response?.statusCode}] => PATH: ${error.requestOptions.path}',
//           );
//
//           log('Error Message: ${error.message}');
//           log('Error Data: ${error.response?.data}');
//           handler.reject(
//             DioException(
//               requestOptions: error.requestOptions,
//               type: DioExceptionType.unknown,
//               error: ServerFailure.fromDioError(error),
//             ),
//           );
//         },
//       ),
//     ]);
//   }
// }
