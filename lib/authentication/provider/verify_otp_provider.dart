import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:CampusX/core/function/api_client.dart';
import 'package:CampusX/core/function/utilities.dart';

class VerifyOtpProvider with ChangeNotifier {
  final String email;

  VerifyOtpProvider({required this.email});

  final ApiClient apiClient = ApiClient();

  Timer? _timer;

  int _resendOtpTimer = 59;
  bool _validForResendCode = false;
  bool _isLoading = false;

  // Getters
  int get resendOtpTimer => _resendOtpTimer;
  bool get validForResendCode => _validForResendCode;
  bool get isLoading => _isLoading;

  void startTimer() {
    _resendOtpTimer = 59;
    _validForResendCode = false;

    _timer?.cancel();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_resendOtpTimer > 0) {
        _resendOtpTimer--;
        notifyListeners();
      } else {
        timer.cancel();
        _validForResendCode = true;
        notifyListeners();
      }
    });
  }

  Future<bool> verifyOtp(String otp) async {
    _isLoading = true;
    notifyListeners();

    try {
      await apiClient.dio.post(
        '/auth/verify-otp/',
        options: Options(contentType: Headers.jsonContentType),
        data: {'email': email, 'otp': otp},
      );

      showSnackBarGlobal(
        'Success',
        'Email Verified Successfully, Please ask admin to approve your account',
      );

      return true; // 👈 tell UI to navigate
    } on DioException catch (e) {
      final errorMessage =
          e.response?.data?['detail'] ?? 'Unknown Error';

      showSnackBarGlobal('Error', errorMessage);
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> resendOtp() async {
    _isLoading = true;
    notifyListeners();

    try {
      await apiClient.dio.post(
        '/auth/resend-otp/',
        options: Options(contentType: Headers.jsonContentType),
        data: {'email': email},
      );

      _validForResendCode = false;
      startTimer();

      showSnackBarGlobal('Success', 'Email resent successfully');
    } on DioException catch (e) {
      final errorMessage =
          e.response?.data?['detail'] ?? 'Unknown Error';

      showSnackBarGlobal('Error', errorMessage);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}