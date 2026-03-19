import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminCourseManagementScreenController extends GetxController
    with GetSingleTickerProviderStateMixin {

  var tabIndex = 0.obs;
  late TabController tabController;
  final List<Tab> coursesTab = [
    Tab(text: 'All Courses'),
    Tab(text: 'Active'),
    Tab(text: 'Archived'),
  ];

  @override
  void onInit() {
    tabController = TabController(length: coursesTab.length, vsync: this);
    tabController.addListener((){
      tabIndex.value=tabController.index;
    });
    super.onInit();
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}
