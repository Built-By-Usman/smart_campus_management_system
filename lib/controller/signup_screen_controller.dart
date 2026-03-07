import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:smar_campus_management_system/core/constant/app_routes.dart';
import 'package:smar_campus_management_system/core/function/api_client.dart';
import 'package:smar_campus_management_system/core/function/utilities.dart';

class SignupScreenController extends GetxController {
  final ApiClient apiClient = ApiClient();
  final baseURL = 'http://153.92.208.33/smart-campus';

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  var nameError = ''.obs;
  var emailError = ''.obs;
  var passwordError = ''.obs;
  var confirmPasswordError = ''.obs;

  var isConditionsChecked = false.obs;
  var selectedRole = 'Teacher'.obs;
  var isLoading = false.obs;
  var showPassword = false.obs;
  var showConfirmPassword = false.obs;

  void validateInput() {
    nameError.value = '';
    emailError.value = '';
    passwordError.value = '';
    confirmPasswordError.value = '';

    String name = nameController.text.trim();
    String email = emailController.text.trim();
    String password = passwordController.text;
    String confirmPassword = confirmPasswordController.text;
    String role = selectedRole.value.toLowerCase();

    bool isValid = true;

    if (name.isEmpty) {
      nameError.value = 'Name cannot be empty';
      isValid = false;
    } else if (email.isEmpty) {
      emailError.value = 'Email cannot be empty';
      isValid = false;
    } else if (!RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    ).hasMatch(email)) {
      emailError.value = 'Please enter a valid email';
      isValid = false;
    } else if (!isConditionsChecked.value) {
      showToast('Please agree to our term and conditions');
      isValid = false;
    }

    if (password.isEmpty) {
      passwordError.value = 'Password cannot be empty';
      isValid = false;
    } else if (confirmPassword.isEmpty) {
      passwordError.value = 'Password cannot be empty';
      isValid = false;
    } else if (password.length < 6) {
      passwordError.value = 'Password must be at least 6 characters';
      isValid = false;
    } else if (password != confirmPassword) {
      confirmPasswordError.value = 'Confirm password not matched';
      isValid = false;
    }

    if (isValid) {
      signUp(name, email, password, role);
    }
  }

  Future<void> signUp(
    String name,
    String email,
    String password,
    String role,
  ) async {
    isLoading.value = true;

    try {
      final response = await apiClient.dio.post(
        '/user/',
        options: Options(contentType: Headers.jsonContentType),
        data: {
          'name': name,
          'email': email,
          'password': password,
          'role': role,
        },
      );

      showSnackBar('Success', response.data['detail']);
      Get.toNamed(AppRoutes.verifyOtp, arguments: email);
    } on DioException catch (e) {
      if (e.response != null || e.response?.data != null) {
        final errorMessage = e.response?.data['detail'] ?? 'Unknown error';
        print(errorMessage);
        showSnackBar('Failed', errorMessage);
      }
    } finally {
      isLoading.value = false;
    }
  }

  void goToHomeScreen() {
    Get.offAllNamed(AppRoutes.home);
  }

  void goToLoginScreen() {
    Get.offAllNamed(AppRoutes.login);
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
