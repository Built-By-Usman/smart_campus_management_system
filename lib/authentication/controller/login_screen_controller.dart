import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:CampusX/core/constant/app_routes.dart';
import 'package:CampusX/core/function/api_client.dart';
import 'package:CampusX/core/function/utilities.dart';

class LoginScreenController extends GetxController {
  final ApiClient apiClient = ApiClient();
  final storage = const FlutterSecureStorage();
  static const tokenKey = 'jwt_token';

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  var rememberMe = false.obs;
  // var selectedRole = 'Admin'.obs;
  var showPassword = false.obs;
  var isLoading = false.obs;
  var emailError = ''.obs;
  var passwordError = ''.obs;

  // void changeRole(String newRole) {
  //   selectedRole.value = newRole;
  // }

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
        '/auth/login/',
        options: Options(contentType: Headers.formUrlEncodedContentType),
        data: {
          'username': email,
          // 'role': selectedRole.value.toLowerCase(),
          'password': password,
        },
      );
      final body = response.data;
      final token = body['access_token'] ?? body['token'];

      if (token != null) {
        await storage.write(key: tokenKey, value: token);
        int id;
        String name;
        String userEmail;

        final preferences = await SharedPreferences.getInstance();
        preferences.setBool('is_logged_in', rememberMe.value);
        if (body['admin']!=null) {
          final admin = body['admin'];
          id = admin['id'];
          name = admin['name'] ?? '';
          userEmail = admin['email'] ?? '';
          print('Hello');
        }
        else{
          id = body['id'];
          name = body['name'] ?? '';
          userEmail = body['email'] ?? '';
        }
        preferences.setInt('id', id);
        preferences.setString('name', name);
        preferences.setString('email', userEmail);
        // preferences.setString('role', body['role'].toLowerCase());
          Get.offAllNamed(AppRoutes.adminHome);



      }
    } on DioException catch (e) {
      if (e.response != null && e.response?.data != null) {
        final errorMessage = e.response?.data['detail'] ?? "Unknown error";
        if (errorMessage == "Please ask admin to approve your account") {
          showToast('Please ask your admin to approve you account');
        } else if (errorMessage == "Please verify you email address") {
          Get.toNamed(AppRoutes.verifyOtp, arguments: email);
        } else {
          showSnackBar('Failed', errorMessage);
        }
      } else {
        showSnackBar('Failed', "Unknown error occurred");
      }
    } finally {
      isLoading.value = false;
    }
  }
}
