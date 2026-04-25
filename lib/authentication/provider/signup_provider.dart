import 'package:CampusX/core/constant/app_routes.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:CampusX/core/function/api_client.dart';
import 'package:CampusX/core/function/utilities.dart';

class SignUpProvider extends ChangeNotifier {
  final ApiClient apiClient = ApiClient();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
  TextEditingController();

  String _nameError = '';
  String _emailError = '';
  String _passwordError = '';
  String _confirmPasswordError = '';

  bool _isConditionsChecked = false;
  String _selectedRole = 'Teacher';
  bool _isLoading = false;
  bool _showPassword = false;
  bool _showConfirmPassword = false;

  // Getters
  String get nameError => _nameError;
  String get emailError => _emailError;
  String get passwordError => _passwordError;
  String get confirmPasswordError => _confirmPasswordError;

  bool get isConditionChecked => _isConditionsChecked;
  String get selectedRole => _selectedRole;
  bool get isLoading => _isLoading;
  bool get showPassword => _showPassword;
  bool get showConfirmPassword => _showConfirmPassword;

  // Setters
  void togglePassword(bool value) {
    _showPassword = value;
    notifyListeners();
  }

  void toggleConfirmPassword(bool value) {
    _showConfirmPassword = value;
    notifyListeners();
  }

  void toggleConditionsCheck(bool value) {
    _isConditionsChecked = value;
    notifyListeners();
  }

  void changeRole(String role) {
    _selectedRole = role;
    notifyListeners();
  }

  Future<void> validateInput(BuildContext context) async {
    _nameError = '';
    _emailError = '';
    _passwordError = '';
    _confirmPasswordError = '';

    String name = nameController.text.trim();
    String email = emailController.text.trim();
    String password = passwordController.text;
    String confirmPassword = confirmPasswordController.text;

    bool isValid = true;

    if (name.isEmpty) {
      _nameError = 'Name cannot be empty';
      isValid = false;
    }

    if (email.isEmpty) {
      _emailError = 'Email cannot be empty';
      isValid = false;
    } else if (!RegExp(r"^[\w\.-]+@[\w\.-]+\.\w+$").hasMatch(email)) {
      _emailError = 'Enter valid email';
      isValid = false;
    }

    if (!_isConditionsChecked) {
      showToast('Please agree to terms');
      isValid = false;
    }

    if (password.isEmpty) {
      _passwordError = 'Password required';
      isValid = false;
    } else if (password.length < 6) {
      _passwordError = 'Min 6 characters';
      isValid = false;
    }

    if (confirmPassword != password) {
      _confirmPasswordError = 'Password not matched';
      isValid = false;
    }

    notifyListeners();

    if (!isValid) return;

    final success = await signUp(
      name,
      email,
      password,
      _selectedRole.toLowerCase(),
    );

    if (success && context.mounted) {
      Navigator.pushNamed(
        context,
        AppRoutes.verifyOtp,
        arguments: email,
      );
    }
  }
  Future<bool> signUp(
      String name,
      String email,
      String password,
      String role,
      ) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await apiClient.dio.post(
        '/auth/create/',
        options: Options(contentType: Headers.jsonContentType),
        data: {
          'name': name,
          'email': email,
          'password': password,
          'role': role,
        },
      );

      showSnackBarGlobal('Success', response.data['detail']);
      return true;
    } on DioException catch (e) {
      final errorMessage = e.response?.data?['detail'] ?? 'Unknown error';
      showSnackBarGlobal('Failed', errorMessage);
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}