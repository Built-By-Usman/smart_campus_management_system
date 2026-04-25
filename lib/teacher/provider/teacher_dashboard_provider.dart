import 'package:CampusX/models/submission_model.dart';
import 'package:CampusX/models/teacher_dashboard.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/function/api_client.dart';

class TeacherDashboardProvider with ChangeNotifier {
  final ApiClient apiClient = ApiClient();

  bool isLoading = false;

  // Changed to int to match the backend and your model
  int totalCourses = 0;
  int totalAssignments = 0;
  int totalSubmissions = 0;

  int userId = 0;
  String userName = '';
  String userEmail = '';

  // Updated to hold Submissions instead of Users/Complaints
  List<SubmissionModel> recentSubmissions = [];

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
      final response = await apiClient.dio.get('/user/load-teacher-dashboard/');

      // Map the response using the TeacherDashboardResponse model
      final dashboardData = TeacherDashboardModel.fromJson(response.data);

      totalCourses = dashboardData.totalCourses;
      totalAssignments = dashboardData.totalAssignments;
      totalSubmissions = dashboardData.totalSubmissions;
      recentSubmissions = dashboardData.recentSubmissions;

      notifyListeners();
    } on DioException catch (e) {
      // Reset values or handle error state
      totalCourses = 0;
      totalAssignments = 0;
      totalSubmissions = 0;
      recentSubmissions = [];

      debugPrint("Dashboard Error: ${e.message}");
      notifyListeners();
    }
  }
}