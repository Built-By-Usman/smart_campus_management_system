import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/admin_home_screen_controller.dart';

class AdminHomeScreen extends StatelessWidget {
  AdminHomeScreen({super.key});

  final AdminHomeScreenController controller = Get.put(AdminHomeScreenController());

  @override
  Widget build(BuildContext context) {
    return Obx(()=>Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          controller.changeIndex(index);
        },

        currentIndex: controller.index.value,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard_outlined),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline ),
            label: 'Users',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.factory),
            label: 'Courses',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined,),
            label: 'Settings',
          ),
        ],
      ),
      body: controller.screens[controller.index.value],
    ));
  }
}
