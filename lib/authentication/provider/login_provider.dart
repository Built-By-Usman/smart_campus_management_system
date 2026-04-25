import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:CampusX/core/constant/app_routes.dart';
import 'package:CampusX/core/function/utilities.dart';

class LoginProvider with ChangeNotifier {
  final Dio dio = Dio();
  final storage = const FlutterSecureStorage();
  static const tokenKey = 'jwt_token';
  // final baseUrl = 'https://smart-campus-backend-orqg.onrender.com';
  final baseUrl = 'http://localhost:8000/smart-campus';

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _rememberMe = false;
  bool _showPassword = false;
  bool _isLoading = false;
  String _emailError = '';
  String _passwordError = '';

  //Getter
  bool get rememberMe=>_rememberMe;
  bool get showPassword=>_showPassword;
  bool get isLoading=>_isLoading;
  String get emailError=>_emailError;
  String get passwordError=>_passwordError;

  //Setter

  void toggleRemember(bool value){
    _rememberMe=value;
    notifyListeners();
  }
  void togglePassword(bool value){
    _showPassword=value;
    notifyListeners();
  }

  void validateInput(BuildContext context) {
    _emailError = '';
    _passwordError= '';

    var email = emailController.value.text.trim();
    var password = passwordController.value.text.trim();

    bool isValid = true;

    if (email.isEmpty) {
      _emailError = 'Please enter your email';
      isValid = false;
    } else if (password.isEmpty) {
      _passwordError = 'Please enter a password';
      isValid = false;
    }
    notifyListeners();
    if (isValid) {
      login(context, email, password);
    }
  }


  Future<void> login(BuildContext context,String email, String password) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await dio.post(
        '$baseUrl/auth/login/',
        options: Options(contentType: Headers.formUrlEncodedContentType),
        data: {
          'username': email,
          'password': password,
        },
      );

      final body = response.data;
      final token = body['access_token'];

      if (token != null) {
        await storage.write(key: tokenKey, value: token);

        final prefs = await SharedPreferences.getInstance();
        prefs.setBool('is_logged_in', _rememberMe);

        int id;
        String name;
        String userEmail;
        String role = '';

        // ✅ ADMIN FLOW
        if (body['admin'] != null) {
          final admin = body['admin'];

          id = admin['id'];
          name = admin['name'] ?? '';
          userEmail = admin['email'] ?? '';
          role = 'admin';

          await prefs.setInt('id', id);
          await prefs.setString('name', name);
          await prefs.setString('email', userEmail);
          await prefs.setString('role', role);

          Navigator.pushNamedAndRemoveUntil(context, AppRoutes.adminHome, (route)=>false);
        }

        // ✅ USER FLOW (teacher / student)
        else if (body['user'] != null) {
          final user = body['user'];

          id = user['id'];
          name = user['name'] ?? '';
          userEmail = user['email'] ?? '';
          role = user['role'] ?? '';

          await prefs.setInt('id', id);
          await prefs.setString('name', name);
          await prefs.setString('email', userEmail);
          await prefs.setString('role', role);

          // 🔥 ROLE-BASED NAVIGATION
          if (role == 'teacher') {
            Navigator.pushNamedAndRemoveUntil(context, AppRoutes.teacherHome, (route)=>false);
          } else if (role == 'student') {
            Navigator.pushNamedAndRemoveUntil(context, AppRoutes.studentHome, (route)=>false);
          } else {
            showSnackBarGlobal('Error', 'Unknown role');
          }
        }
      }
    } on DioException catch (e) {
      final errorMessage =
          e.response?.data?['detail'] ?? "Unknown error";

      if (errorMessage == "Please ask admin to approve your account") {
        showToast('Please ask your admin to approve your account');
      } else if (errorMessage == "Please verify your email address") {
        Navigator.pushNamedAndRemoveUntil(context, AppRoutes.verifyOtp, (route)=>false,arguments: email);

      } else {
        showSnackBarGlobal('Failed', errorMessage);
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }}
