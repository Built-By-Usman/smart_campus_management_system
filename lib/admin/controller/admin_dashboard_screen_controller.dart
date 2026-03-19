import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:CampusX/core/function/api_client.dart';
import 'package:CampusX/models/complaint_model.dart';
import 'package:CampusX/models/user_model.dart';

class AdminDashboardScreenController extends GetxController {
  var isLoading = false.obs;
  var totalStudents = ''.obs;
  var totalTeachers = ''.obs;
  var activeCourses = ''.obs;
  var pendingComplaints = ''.obs;
  var userId = 0.obs;
  var userName = ''.obs;
  var userEmail = ''.obs;
  RxList<UserModel> recentUsers = <UserModel>[].obs;
  RxList<ComplaintModel> recentComplaints = <ComplaintModel>[].obs;


  final ApiClient apiClient = ApiClient();

  @override
  void onInit() {
    isLoading.value = true;
    loadDashBoard();
    super.onInit();
  }

  Future<void> loadDashBoard() async {
    try {
      isLoading.value = true;
      await loadUserData();
      await fetchStats();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadUserData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    userId.value = preferences.getInt('id') ?? 0;
    userName.value = preferences.getString('name') ?? 'Unknown';
    userEmail.value = preferences.getString('email') ?? 'smartt@example.com';
  }

  Future<void> fetchStats() async {
    try {
      final response = await apiClient.dio.get('/user/load-admin-dashboard/');

      final data = response.data;
      print(data);

      totalStudents.value = data['total_students'].toString();
      totalTeachers.value = data['total_teachers'].toString();
      activeCourses.value = data['active_courses'].toString();
      pendingComplaints.value = data['pending_complaints'].toString();
      List<UserModel> fetchedUsers = (data['recent_users'] as List)
          .map((json) => UserModel.fromJson(json))
          .toList();
      recentUsers.value = fetchedUsers;
      List<ComplaintModel> fetchedComplaints = (data['recent_complaints'] as List)
      .map((json)=>ComplaintModel.fromJson(json)).toList();
      recentComplaints.value=fetchedComplaints;
    } on DioException catch (e) {
      totalStudents.value = 'Unknown';
      totalTeachers.value = 'Unknown';
      activeCourses.value = 'Unknown';
      pendingComplaints.value = 'Unknown';

      print(e);
    }
  }
}
