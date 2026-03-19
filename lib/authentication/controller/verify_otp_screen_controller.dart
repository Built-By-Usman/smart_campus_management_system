import 'dart:async';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:CampusX/core/constant/app_routes.dart';
import 'package:CampusX/core/function/api_client.dart';
import 'package:CampusX/core/function/utilities.dart';

class VerifyOtpScreenController extends GetxController {
  final String email;

  VerifyOtpScreenController({required this.email});

  final ApiClient apiClient = ApiClient();
  Timer? timer;

  var resendOtpTimer = 59.obs;
  var validForResendCode = false.obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    startTimer();
    super.onInit();
  }

  void startTimer() {
    resendOtpTimer.value = 59;

    timer?.cancel();
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (resendOtpTimer.value > 0) {
        resendOtpTimer.value--;
      } else {
        timer.cancel();
        validForResendCode.value = true;
      }
    });
  }

  Future<void> verifyOtp(String otp) async {
    isLoading.value = true;
    try {
      await apiClient.dio.post(
        '/auth/verify-otp/',
        options: Options(contentType: Headers.jsonContentType),
        data: {'email': email, 'otp': otp.toString()},
      );
      showSnackBar(
        'Success',
        'Email Verified Successfully, Please ask admin to approve your account',
      );
      Get.offAllNamed(AppRoutes.login);
    } on DioException catch (e) {
      if (e.response != null || e.response?.data != null) {
        final errorMessage = e.response?.data['detail'] ?? 'Unknown Error';

        showSnackBar('Error', errorMessage);
      } else {
        showSnackBar('Error', 'Unknown error occurred');
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> resendOtp() async {
    isLoading.value = true;
    try {
      await apiClient.dio.post(
        '/auth/resend-otp/',
        options: Options(contentType: Headers.jsonContentType),
        data: {'email': email},
      );
      validForResendCode.value = false;
      startTimer();
      showSnackBar('Success', 'Email Resend successfully');
    } on DioException catch (e) {
      if (e.response != null || e.response?.data != null) {
        final errorMessage = e.response?.data['detail'] ?? 'Unknown Error';
        showSnackBar('Error', errorMessage);
      } else {
        showSnackBar('Error', 'Unknown Error');
      }
    }
  }

  void goBack() {
    Get.back();
  }
}
