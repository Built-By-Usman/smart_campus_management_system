import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:smar_campus_management_system/core/constant/app_routes.dart';
import 'package:smar_campus_management_system/core/function/utilities.dart';

class ApiClient {
  final dio = Dio();

  final storage = FlutterSecureStorage();

  ApiClient() {
    dio.options.baseUrl = 'http://153.92.208.33/smart-campus';
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await storage.read(key: 'jwt_token');

          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
        onError: (e, handler) async {
          if (e.response?.statusCode == 401 &&
              e.requestOptions.path.contains('/auth/login/')) {
            await storage.delete(key: 'jwt_token');
            showSnackBar('Session Expired', 'Please login again');
            Get.offAllNamed(AppRoutes.login);
          }
          return handler.next(e);
        },
      ),
    );
  }
}
