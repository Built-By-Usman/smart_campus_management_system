import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:CampusX/core/constant/app_routes.dart';

class SplashProvider with ChangeNotifier {

  Future<void> checkLoginStatus(BuildContext context) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    // preferences.clear();
    bool isLoggedIn = preferences.getBool('is_logged_in') ?? false;


    await Future.delayed(const Duration(seconds: 2));

    if (isLoggedIn) {
      String role = preferences.getString('role') ?? '';
print(role);
print(isLoggedIn.toString());
      if (role == 'admin') {
        Navigator.pushReplacementNamed(context, AppRoutes.adminHome);
      } else if (role == 'teacher') {
        Navigator.pushReplacementNamed(context, AppRoutes.teacherHome);
      }
      else if (role == 'student') {
        Navigator.pushReplacementNamed(context, AppRoutes.studentHome);
      }else {
        Navigator.pushReplacementNamed(context, AppRoutes.login);
      }
    } else {
      Navigator.pushReplacementNamed(context, AppRoutes.login);
    }
  }
}