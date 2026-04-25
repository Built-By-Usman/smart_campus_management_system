import 'package:CampusX/core/constant/app_color.dart';
import 'package:CampusX/teacher/provider/teacher_home_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TeacherHomeScreen extends StatelessWidget {
  const TeacherHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final teacherHomeProvider = Provider.of<TeacherHomeProvider>(context);
    return Scaffold(
      extendBody: true,
      body: teacherHomeProvider.screens[teacherHomeProvider.index],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: AppColor.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: Offset(0, -5)
              )
            ]
        ),
        child: NavigationBarTheme(
          data: NavigationBarThemeData(
            indicatorColor: AppColor.blue.withOpacity(0.1),
            labelTextStyle: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.selected)) {
                return TextStyle(
                  color: AppColor.blue,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                );
              }
              return TextStyle(color: AppColor.subHeading, fontSize: 12);
            }),
            iconTheme: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.selected)) {
                return IconThemeData(color: AppColor.blue, size: 26);
              }
              return IconThemeData(color: AppColor.subHeading, size: 24);
            }),
          ),
          child: NavigationBar(
            height: 70,
            backgroundColor: Colors.white,
            elevation: 0,
            selectedIndex: teacherHomeProvider.index,
            onDestinationSelected: (index) => teacherHomeProvider.changeIndex(index),
            destinations: const [
              NavigationDestination(
                selectedIcon: Icon(Icons.dashboard_rounded),
                icon: Icon(Icons.dashboard_outlined),
                label: 'Dashboard',
              ),
              NavigationDestination(
                selectedIcon: Icon(Icons.people_alt_rounded),
                icon: Icon(Icons.person_outline),
                label: 'My Courses',
              ),
              NavigationDestination(
                selectedIcon: Icon(Icons.menu_book_rounded),
                icon: Icon(Icons.menu_book_outlined),
                label: 'Assignments',
              ),
              NavigationDestination(
                selectedIcon: Icon(Icons.settings_rounded),
                icon: Icon(Icons.settings_outlined),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),


    );
  }
}
