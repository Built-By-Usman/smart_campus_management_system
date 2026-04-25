import 'package:flutter/material.dart';

import '../view/admin_course_management_screen.dart';
import '../view/admin_dashboard_screen.dart';
import '../view/admin_setting_screen.dart';
import '../view/admin_user_management_screen.dart';

class AdminHomeProvider extends ChangeNotifier {
  int _index = 0;

  int get index => _index;

  void changeIndex(int newIndex) {
    _index = newIndex;
    notifyListeners();
  }

  final List<Widget> screens = [
    AdminDashboardScreen(),
    AdminUserManagementScreen(),
    AdminCourseManagementScreen(),
    AdminSettingScreen(),
  ];
}