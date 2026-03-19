
import 'package:get/get.dart';
import 'package:CampusX/admin/view/admin_approve_user_screen.dart';
import 'package:CampusX/core/constant/app_routes.dart';

import 'admin/view/admin_home_screen.dart';
import 'authentication/view/login_screen.dart';
import 'authentication/view/signup_screen.dart';
import 'authentication/view/splash_screen.dart';
import 'authentication/view/verify_otp_screen.dart';

final List<GetPage<dynamic>> pages = [
  GetPage(name: AppRoutes.splash, page: ()=>SplashScreen()),
  GetPage(name: AppRoutes.login, page: ()=>LoginScreen()),
  GetPage(name: AppRoutes.signUp, page: ()=>SignupScreen()),
  GetPage(name: AppRoutes.verifyOtp, page: ()=>VerifyOtpScreen(email: Get.arguments,)),

  ///Admin Routes
  GetPage(name: AppRoutes.adminHome, page: ()=>AdminHomeScreen()),
  GetPage(name: AppRoutes.adminApproveUsers, page: ()=>AdminApproveUserScreen(user: Get.arguments)),
];