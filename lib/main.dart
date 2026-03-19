import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:CampusX/core/constant/app_color.dart';
import 'package:CampusX/core/constant/app_routes.dart';
import 'package:CampusX/routes.dart';

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

