import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:CampusX/core/function/api_client.dart';
import 'package:CampusX/models/complaint_model.dart';
import 'package:CampusX/models/user_model.dart';

class AdminDashboardProvider extends ChangeNotifier {
  final ApiClient apiClient = ApiClient();

  bool isLoading = false;

  String totalStudents = '';
  String totalTeachers = '';
  String activeCourses = '';
  String pendingComplaints = '';

  int userId = 0;
  String userName = '';
  String userEmail = '';

  List<UserModel> recentUsers = [];
  List<ComplaintModel> recentComplaints = [];

  Future<void> loadDashboard() async {
    isLoading = true;
    notifyListeners();

    try {
      await loadUserData();
      await fetchStats();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadUserData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    userId = preferences.getInt('id') ?? 0;
    userName = preferences.getString('name') ?? 'Unknown';
    userEmail = preferences.getString('email') ?? 'smartt@example.com';
  }

  Future<void> fetchStats() async {
    try {
      final response =
      await apiClient.dio.get('/user/load-admin-dashboard/');

      final data = response.data;

      totalStudents = data['total_students'].toString();
      totalTeachers = data['total_teachers'].toString();
      activeCourses = data['active_courses'].toString();
      pendingComplaints = data['pending_complaints'].toString();

      recentUsers = (data['recent_users'] as List)
          .map((json) => UserModel.fromJson(json))
          .toList();

      recentComplaints = (data['recent_complaints'] as List)
          .map((json) => ComplaintModel.fromJson(json))
          .toList();

      notifyListeners();
    } on DioException catch (e) {
      totalStudents = 'Unknown';
      totalTeachers = 'Unknown';
      activeCourses = 'Unknown';
      pendingComplaints = 'Unknown';

      notifyListeners();
      print(e);
    }
  }
}