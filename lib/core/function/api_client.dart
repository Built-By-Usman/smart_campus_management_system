import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:CampusX/core/constant/app_routes.dart';
import 'package:CampusX/core/function/utilities.dart';

import '../constant/navigator_key.dart';

class ApiClient {
  final dio = Dio();

  final storage = FlutterSecureStorage();

  ApiClient() {
    // dio.options.baseUrl = 'http://153.92.208.33/smart-campus';
    dio.options.baseUrl = 'http://localhost:8000/smart-campus';
    // dio.options.baseUrl = 'http://192.168.100.217:8000/smart-campus';
    // dio.options.baseUrl = 'https://smart-campus-backend-orqg.onrender.com';
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
            showSnackBarGlobal('Session Expired', 'Please login again');
            navigatorKey.currentState?.pushNamedAndRemoveUntil(
              AppRoutes.login,
                  (route) => false,
            );
          }
          return handler.next(e);
        },
      ),
    );
  }
}
