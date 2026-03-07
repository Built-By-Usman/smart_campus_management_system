import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smar_campus_management_system/view/course_management_screen.dart';
import 'package:smar_campus_management_system/view/dashboard_screen.dart';
import 'package:smar_campus_management_system/view/user_management_screen.dart';

class HomeScreenController extends GetxController{

  var index = 0.obs;


  void changeIndex(int newIndex){
    index.value = newIndex;
  }

  final List<Widget> screens = [
    DashboardScreen(),
    UserManagementScreen(),
    CourseManagementScreen(),
    Center(child: Text('Settings'),),
  ];

}