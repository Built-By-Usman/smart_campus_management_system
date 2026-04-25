import 'package:CampusX/teacher/provider/teacher_assignment_provider.dart';
import 'package:CampusX/teacher/provider/teacher_courses_provider.dart';
import 'package:CampusX/teacher/provider/teacher_dashboard_provider.dart';
import 'package:CampusX/teacher/provider/teacher_home_provider.dart';
import 'package:CampusX/teacher/provider/teacher_submission_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:CampusX/core/constant/app_color.dart';
import 'package:CampusX/core/constant/app_routes.dart';
import 'package:CampusX/routes.dart';
import 'admin/provider/admin_dashboard_provider.dart';
import 'admin/provider/admin_home_provider.dart';
import 'authentication/provider/login_provider.dart';
import 'authentication/provider/signup_provider.dart';
import 'authentication/provider/splash_provider.dart';
import 'core/constant/navigator_key.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginProvider()),
        ChangeNotifierProvider(create: (_) => SignUpProvider()),
        ChangeNotifierProvider(create: (_) => SplashProvider()),
        ChangeNotifierProvider(create: (_) => AdminHomeProvider()),
        ChangeNotifierProvider(create: (_) => AdminDashboardProvider()),
        ChangeNotifierProvider(create: (_) => TeacherHomeProvider()),
        ChangeNotifierProvider(create: (_) => TeacherDashboardProvider()),
        ChangeNotifierProvider(create: (_) => TeacherCoursesProvider()),
        ChangeNotifierProvider(create: (_) => TeacherAssignmentProvider()),
        ChangeNotifierProvider(create: (_) => TeacherSubmissionProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      initialRoute: AppRoutes.splash,
      onGenerateRoute: AppRouter.generateRoute,
      theme: ThemeData(
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: AppColor.white,
          selectedItemColor: AppColor.blue,
          unselectedItemColor: AppColor.subHeading,
          elevation: 2,
          type: BottomNavigationBarType.fixed,
        ),
      ),
    );
  }
}