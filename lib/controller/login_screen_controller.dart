import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smar_campus_management_system/core/constant/app_routes.dart';
import 'package:smar_campus_management_system/core/function/api_client.dart';
import 'package:smar_campus_management_system/core/function/utilities.dart';

class LoginScreenController extends GetxController {
  final ApiClient apiClient = ApiClient();
  final baseURL = 'http://153.92.208.33/smart-campus';
  final storage = const FlutterSecureStorage();
  static const tokenKey = 'jwt_token';

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  var rememberMe = false.obs;
  var selectedRole = 'Admin'.obs;
  var showPassword = false.obs;
  var isLoading = false.obs;
  var emailError = ''.obs;
  var passwordError = ''.obs;

  void changeRole(String newRole) {
    selectedRole.value = newRole;
  }

  void validateInput() {
    emailError.value = '';
    passwordError.value = '';

    var email = emailController.value.text.trim();
    var password = passwordController.value.text.trim();

    bool isValid = true;

    if (email.isEmpty) {
      emailError.value = 'Please enter your email';
      isValid = false;
    } else if (password.isEmpty) {
      passwordError.value = 'Please enter a password';
      isValid = false;
    }
    if (isValid) {
      login(email, password);
    }
  }

  void goToSignUpScreen() {
    Get.toNamed(AppRoutes.signUp);
  }

  Future<void> login(String email, String password) async {
    isLoading.value = true;

    try {
      final response = await apiClient.dio.post(
        '/login/',
        options: Options(contentType: Headers.jsonContentType),
        data: {
          'email': email,
          'role': selectedRole.value.toLowerCase(),
          'password': password,
        },
      );
      final body = response.data;
      final token = body['access_token'] ?? body['token'];

      if (token != null) {
        await storage.write(key: tokenKey, value: token);
        final id = body['id'];
        final name = body['name'];
        final email = body['email'];

        final preferences = await SharedPreferences.getInstance();

        preferences.setBool('is_logged_in', rememberMe.value);
        preferences.setString('id', id);
        preferences.setString('name', name);
        preferences.setString('email', email);

        Get.offAllNamed(AppRoutes.home);
      }
    } on DioException catch (e) {
      if(e.response!=null&&e.response?.data!=null){
        final errorMessage = e.response?.data['detail']??"Unknown error";
        if (errorMessage == "Please ask admin to approve your account"){
          print('hello');

        }else if(errorMessage == "Please verify you email address"){
          Get.toNamed(AppRoutes.verifyOtp,arguments: email);

        }
        else{
          showSnackBar('Failed', errorMessage);
        }

      }
      else{
        showSnackBar('Failed', "Unknown error occurred");

      }


    }finally{
      isLoading.value=false;
    }
  }
}
