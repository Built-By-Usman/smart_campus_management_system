import 'package:CampusX/student/view/student_home_screen.dart';
import 'package:CampusX/teacher/view/teacher_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:CampusX/core/constant/app_routes.dart';

import 'authentication/view/login_screen.dart';
import 'authentication/view/signup_screen.dart';
import 'authentication/view/splash_screen.dart';
import 'authentication/view/verify_otp_screen.dart';
import 'admin/view/admin_home_screen.dart';
import 'admin/view/admin_approve_user_screen.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {

      case AppRoutes.splash:
        return MaterialPageRoute(builder: (_) =>  SplashScreen());

      case AppRoutes.login:
        return MaterialPageRoute(builder: (_) =>  LoginScreen());

      case AppRoutes.signUp:
        return MaterialPageRoute(builder: (_) =>  SignupScreen());

      case AppRoutes.verifyOtp:
        final email = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => VerifyOtpScreen(email: email),
        );

      case AppRoutes.adminHome:
        return MaterialPageRoute(builder: (_) =>  AdminHomeScreen());

      case AppRoutes.teacherHome:
        return MaterialPageRoute(builder: (_)=> TeacherHomeScreen());
      case AppRoutes.studentHome:
        return MaterialPageRoute(builder: (_)=> StudentHomeScreen());

      case AppRoutes.adminApproveUsers:
        final user = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => AdminApproveUserScreen(user: user),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('No route found')),
          ),
        );
    }
  }
}