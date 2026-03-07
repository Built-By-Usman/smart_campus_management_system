import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smar_campus_management_system/core/constant/app_color.dart';
import 'package:smar_campus_management_system/core/constant/app_routes.dart';
import 'package:smar_campus_management_system/routes.dart';

void main() {
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: AppRoutes.splash,
    getPages: pages,
    theme: ThemeData(
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColor.white,
        selectedItemColor: AppColor.blue,
        unselectedItemColor: AppColor.subHeading,
        elevation: 2,
        type: BottomNavigationBarType.fixed
      )
    ),
  ));
}

