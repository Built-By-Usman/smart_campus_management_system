import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../view/admin_course_management_screen.dart';
import '../view/admin_dashboard_screen.dart';
import '../view/admin_user_management_screen.dart';

class AdminHomeScreenController extends GetxController{

  var index = 0.obs;


  void changeIndex(int newIndex){
    index.value = newIndex;
  }

  final List<Widget> screens = [
    AdminDashboardScreen(),
    AdminUserManagementScreen(),
    AdminCourseManagementScreen(),
    Center(child: Text('Settings'),),
  ];

}