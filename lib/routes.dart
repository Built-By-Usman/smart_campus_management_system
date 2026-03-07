
import 'package:get/get.dart';
import 'package:smar_campus_management_system/core/constant/app_routes.dart';
import 'package:smar_campus_management_system/view/home_screen.dart';
import 'package:smar_campus_management_system/view/login_screen.dart';
import 'package:smar_campus_management_system/view/signup_screen.dart';
import 'package:smar_campus_management_system/view/splash_screen.dart';
import 'package:smar_campus_management_system/view/verify_otp_screen.dart';

final List<GetPage<dynamic>> pages = [
  GetPage(name: AppRoutes.splash, page: ()=>SplashScreen()),
  GetPage(name: AppRoutes.login, page: ()=>LoginScreen()),
  GetPage(name: AppRoutes.signUp, page: ()=>SignupScreen()),
  GetPage(name: AppRoutes.home, page: ()=>HomeScreen()),
  GetPage(name: AppRoutes.verifyOtp, page: ()=>VerifyOtpScreen(email: Get.arguments,)),
];